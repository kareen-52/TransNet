import 'package:dio/dio.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:graduation_progect/core/networking/api_constants.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class MapService {


  final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: {'User-Agent': ApiConstants.userAgent, 'Accept-Language': 'ar'},
    ),
  );



  Future<Map<String, dynamic>?> getRouteData(LatLng start, LatLng end) async {
    try {
      final response = await _dio.get(
        'https://api.openrouteservice.org/v2/directions/driving-car',
        queryParameters: {
          'api_key': ApiConstants.orsApiKey,
          'start': '${start.longitude},${start.latitude}',
          'end': '${end.longitude},${end.latitude}',
        },
      );

      if (response.statusCode == 200) {
        final feature = response.data['features'][0];
        final List coords = feature['geometry']['coordinates'];
        final summary = feature['properties']['summary'];

        return {
          'points': coords.map((c) => LatLng(c[1], c[0])).toList(),
          'distance': summary['distance'] / 1000.0,
          'duration': summary['duration'] / 60.0,
        };
      }
    } catch (e) {
      return null;
    }
    return null;
  }



  Future<List<dynamic>> searchPlaces(String query, {LatLngBounds? bounds}) async {
    try {
      Map<String, dynamic> queryParams = {
        'q': query,
        'format': 'json',
        'limit': 5,
        'addressdetails': 1,
        'accept-language': 'ar',
        'countrycodes': 'sy',
      };


      if (bounds != null) {
        queryParams['viewbox'] = '${bounds.west},${bounds.north},${bounds.east},${bounds.south}';
        queryParams['bounded'] = 1;
      }

      final response = await _dio.get(
        'https://nominatim.openstreetmap.org/search',
        queryParameters: queryParams,
        options: Options(
          headers: {
            'User-Agent': ApiConstants.userAgent,
          },
        ),
      );

      if (response.statusCode == 200) {
        return response.data;
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 429) {
        print("🚨 Nominatim Blocked Us (429)! يجب تقليل سرعة الطلبات.");
      } else {
        print("Search Error: ${e.message}");
      }
    }
    return [];
  }


  Future<LatLng?> getUserCurrentLocation() async {
    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) return null;
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) return null;
    }

    final locationData = await location.getLocation();
    if (locationData.latitude != null && locationData.longitude != null) {
      return LatLng(locationData.latitude!, locationData.longitude!);
    }
    return null;
  }



  Future<Map<String, String>?> getAddressFromLatLng(LatLng position) async {
    try {
      final response = await _dio.get(
        'https://nominatim.openstreetmap.org/reverse',
        queryParameters: {
          'lat': position.latitude,
          'lon': position.longitude,
          'format': 'json',
          'accept-language': 'ar',
          'zoom': 18,
        },
        options: Options(headers: {'User-Agent': 'GraduationProjectApp/1.0'}),
      );

      if (response.statusCode == 200) {
        final addressDetails = response.data['address'] ?? {};


        String displayName = response.data['display_name'] ?? 'موقع غير معروف';


        String state =
            addressDetails['state'] ??
            addressDetails['province'] ??
            addressDetails['region'] ??
            '';

        return {'display_name': displayName, 'state': state};
      }
    } catch (e) {
      print("Reverse Geocode Error: $e");
    }
    return null;
  }

}