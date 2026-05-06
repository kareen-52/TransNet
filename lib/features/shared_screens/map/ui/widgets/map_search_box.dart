import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/features/shared_screens/map/logic/data/map_service.dart';
import 'package:latlong2/latlong.dart';

class MapSearchWidget extends StatefulWidget {
  final MapService mapService;
  final Function(LatLng newLocation) onPlaceSelected;
  final String expectedGovernorate;
  final LatLngBounds? governorateBounds;

  const MapSearchWidget({
    super.key,
    required this.mapService,
    required this.onPlaceSelected,
    required this.expectedGovernorate,
    this.governorateBounds,
  });

  @override
  State<MapSearchWidget> createState() => _MapSearchWidgetState();
}

class _MapSearchWidgetState extends State<MapSearchWidget> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  List<dynamic> _searchResults = [];
  bool _isSearching = false;

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    if (query.trim().isEmpty) {
      setState(() {
        _searchResults = [];
        _isSearching = false;
      });
      return;
    }

    setState(() => _isSearching = true);
    _debounce = Timer(const Duration(milliseconds: 600), () async {

      final enhancedQuery = "$query, ${widget.expectedGovernorate}";
      final results = await widget.mapService.searchPlaces(
        enhancedQuery,
        bounds: widget.governorateBounds,
      );

      if (mounted) {
        setState(() {
          _searchResults = results;
          _isSearching = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(15.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10.r,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: TextField(
            controller: _searchController,
            onChanged: _onSearchChanged,
            decoration: InputDecoration(
              hintText: "ابحث عن منطقة أو شارع...",
              prefixIcon: Icon(Icons.search, color: theme.colorScheme.primary),
              suffixIcon: _isSearching
                  ? Padding(
                      padding: EdgeInsets.all(12.r),
                      child: const CircularProgressIndicator(strokeWidth: 2),
                    )
                  : (_searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              _onSearchChanged('');
                              FocusScope.of(context).unfocus();
                            },
                          )
                        : null),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                vertical: 15.h,
                horizontal: 16.w,
              ),
            ),
          ),
        ),
        if (_searchResults.isNotEmpty)
          Container(
            margin: EdgeInsets.only(top: 8.h),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(15.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10.r,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            constraints: BoxConstraints(maxHeight: 250.h),
            child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final place = _searchResults[index];
                return ListTile(
                  leading: Icon(
                    Icons.location_on_outlined,
                    color: theme.colorScheme.secondary,
                  ),
                  title: Text(
                    place['display_name'],
                    style: theme.textTheme.bodyMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  onTap: () {
                    final lat = double.parse(place['lat']);
                    final lon = double.parse(place['lon']);
                    widget.onPlaceSelected(LatLng(lat, lon));
                    setState(() {
                      _searchResults = [];
                      _searchController.text = place['display_name'].split(',',)[0];
                    });
                    FocusScope.of(context).unfocus();
                  },
                );
              },
            ),
          ),
      ],
    );
  }
}
