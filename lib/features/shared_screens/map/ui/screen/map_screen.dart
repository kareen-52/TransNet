import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:graduation_progect/core/networking/api_constants.dart';
import 'package:graduation_progect/features/shared_screens/map/logic/data/map_service.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import '../widgets/bottom_info_sheet.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController();
  final MapService _mapService = MapService();

  LocationData? _currentLoc;
  LatLng? _destination;
  List<LatLng> _routePoints = [];
  double? _distance, _duration;
  bool _isLoading = false;
  bool _isSheetMinimized = false;

  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  List<dynamic> _searchResults = [];
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _initLocation();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  Future<void> _initLocation() async {
    final loc = Location();
    _currentLoc = await loc.getLocation();
    loc.onLocationChanged.listen((newLoc) {
      if (mounted) setState(() => _currentLoc = newLoc);
    });
  }

  void _goToMyLocation() {
    if (_currentLoc != null) {
      _mapController.move(
        LatLng(_currentLoc!.latitude!, _currentLoc!.longitude!),
        16.0,
      );
    }
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    if (query.isEmpty) {
      setState(() => _searchResults = []);
      return;
    }

    setState(() => _isSearching = true);
    _debounce = Timer(const Duration(milliseconds: 600), () async {
      final results = await _mapService.searchPlaces(query);
      if (mounted) {
        setState(() {
          _searchResults = results;
          _isSearching = false;
        });
      }
    });
  }

  void _selectPlace(dynamic place) {
    FocusScope.of(context).unfocus();
    final lat = double.parse(place['lat']);
    final lon = double.parse(place['lon']);
    final newDest = LatLng(lat, lon);

    setState(() {
      _destination = newDest;
      _searchResults = [];
      _searchController.text = place['display_name'].split(',')[0];
    });

    _mapController.move(newDest, 16.0);
  }

  Future<void> _fetchRoute() async {
    if (_currentLoc == null || _destination == null) return;
    setState(() => _isLoading = true);

    final start = LatLng(_currentLoc!.latitude!, _currentLoc!.longitude!);
    final data = await _mapService.getRouteData(start, _destination!);

    if (data != null) {
      setState(() {
        _routePoints = data['points'];
        _distance = data['distance'];
        _duration = data['duration'];
        _isSheetMinimized = false;
      });
      _mapController.fitCamera(
        CameraFit.bounds(
          bounds: LatLngBounds.fromPoints(_routePoints),
          padding: const EdgeInsets.all(70),
        ),
      );
    }
    setState(() => _isLoading = false);
  }

  void _reset() {
    setState(() {
      _destination = null;
      _routePoints.clear();
      _distance = null;
      _duration = null;
      _searchController.clear();
      _isSheetMinimized = false;
    });
    _goToMyLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _currentLoc == null
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    initialCenter: LatLng(
                      _currentLoc!.latitude!,
                      _currentLoc!.longitude!,
                    ),
                    initialZoom: 15,
                    onTap: (_, p) {
                      if (_distance == null) {
                        setState(() {
                          _destination = p;
                          _searchController.clear();
                        });
                      }
                    },
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: ApiConstants.mapUrl,
                      userAgentPackageName: ApiConstants.userAgent,
                    ),
                    if (_routePoints.isNotEmpty)
                      PolylineLayer(
                        polylines: [
                          Polyline(
                            points: _routePoints,
                            color: Colors.blueAccent.withOpacity(0.8),
                            strokeWidth: 6,
                          ),
                        ],
                      ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: LatLng(
                            _currentLoc!.latitude!,
                            _currentLoc!.longitude!,
                          ),
                          child: _buildUserMarker(),
                        ),
                        if (_destination != null)
                          Marker(
                            point: _destination!,
                            child: const Icon(
                              Icons.location_on,
                              color: Colors.red,
                              size: 45,
                            ),
                            alignment: Alignment.topCenter,
                          ),
                      ],
                    ),
                  ],
                ),

                if (_distance == null)
                  Positioned(
                    top: 50,
                    left: 15,
                    right: 15,
                    child: _buildSearchArea(),
                  ),

                Positioned(
                  bottom: _distance != null
                      ? (_isSheetMinimized ? 100 : 250)
                      : 100,
                  right: 20,
                  child: FloatingActionButton(
                    heroTag: "btn_locate",
                    mini: true,
                    backgroundColor: Colors.white,
                    child: const Icon(Icons.my_location, color: Colors.blue),
                    onPressed: _goToMyLocation,
                  ),
                ),

                // 3. زر "الذهاب إلى هنا"
                if (_destination != null && _distance == null)
                  Positioned(
                    bottom: 30,
                    left: 20,
                    right: 20,
                    child: _buildConfirmRouteButton(),
                  ),

                // 4. بطاقة المعلومات الاحترافية
                if (_distance != null)
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: _isSheetMinimized
                        ? _buildMinimizedInfo()
                        : BottomInfoSheet(
                            distance: _distance!,
                            duration: _duration!,
                            onCancel: _reset,
                            onMinimize: () =>
                                setState(() => _isSheetMinimized = true),
                            onStart: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("بدأت الرحلة.. جاري التتبع"),
                                ),
                              );
                            },
                          ),
                  ),
              ],
            ),
    );
  }

  // ويدجت البحث
  Widget _buildSearchArea() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
          ),
          child: TextField(
            controller: _searchController,
            onChanged: _onSearchChanged,
            decoration: InputDecoration(
              hintText: "ابحث عن وجهتك...",
              prefixIcon: const Icon(Icons.search, color: Colors.blue),
              suffixIcon: _isSearching
                  ? const Padding(
                      padding: EdgeInsets.all(12),
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : (_searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () =>
                                setState(() => _searchController.clear()),
                          )
                        : null),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 15),
            ),
          ),
        ),
        if (_searchResults.isNotEmpty)
          Container(
            margin: const EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            constraints: const BoxConstraints(maxHeight: 250),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final place = _searchResults[index];
                return ListTile(
                  leading: const Icon(
                    Icons.location_on_outlined,
                    color: Colors.orange,
                  ),
                  title: Text(
                    place['display_name'],
                    style: const TextStyle(fontSize: 13),
                  ),
                  onTap: () => _selectPlace(place),
                );
              },
            ),
          ),
      ],
    );
  }

  Widget _buildConfirmRouteButton() {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue[800],
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      onPressed: _isLoading ? null : _fetchRoute,
      icon: _isLoading
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            )
          : const Icon(Icons.directions),
      label: Text(_isLoading ? "جاري الرسم..." : "الذهاب إلى هنا"),
    );
  }

  // ويدجت البطاقة المصغرة
  Widget _buildMinimizedInfo() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: FloatingActionButton.extended(
        onPressed: () => setState(() => _isSheetMinimized = false),
        backgroundColor: Colors.blue[900],
        label: Text(
          "${_distance!.toStringAsFixed(1)} كم - ${_duration!.round()} دقيقة",
        ),
        icon: const Icon(Icons.expand_less, color: Colors.orange),
      ),
    );
  }

  Widget _buildUserMarker() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.2),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Icon(Icons.circle, color: Colors.blue[700], size: 18),
      ),
    );
  }
}
