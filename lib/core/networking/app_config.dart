//
// بناء للـ dev:
//   flutter run --dart-define=BASE_URL=http://192.168.1.106:8000/
//
// بناء للـ production:
//   flutter build apk \
//     --dart-define=BASE_URL=https://api.transnet.app/ \
//     --dart-define=ORS_API_KEY=your_key_here
// ============================================================

class AppConfig {
  AppConfig._();

  static const String _baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'http://192.168.1.101:8000/', // dev fallback فقط
  );

  static const String _orsApiKey = String.fromEnvironment(
    'ORS_API_KEY',
    defaultValue:
        'eyJvcmciOiI1YjNjZTM1OTc4NTExMTAwMDFjZjYyNDgiLCJpZCI6ImYwNTI4MWQzMTJhNDQzYzNiNzlhZmQ3NzdjNzc4OTkyIiwiaCI6Im11cm11cjY0In0=', // فارغ في dev — الخريطة ستعطي error واضح
  );

  static const String baseUrl = _baseUrl;
  static const String apiBaseUrl = '${_baseUrl}api/';
  static const String orsApiKey = _orsApiKey;

  static const String mapTileUrl =
      'https://tile.openstreetmap.org/{z}/{x}/{y}.png';
  static const String userAgent = 'com.example.transnet_graduation_project';
}
