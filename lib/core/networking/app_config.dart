// dev:
//   flutter run --dart-define=BASE_URL=http://10.140.20.190:8000/
// production:
//   flutter build apk \
//     --dart-define=BASE_URL=https://api.transnet.app/ \
//     --dart-define=ORS_API_KEY=your_key_here

class AppConfig {
  AppConfig._();

  static const String _baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'https://transnet.up.railway.app/',
  );

  static const String _orsApiKey = String.fromEnvironment(
    'ORS_API_KEY',
    defaultValue:
        'eyJvcmciOiI1YjNjZTM1OTc4NTExMTAwMDFjZjYyNDgiLCJpZCI6ImYwNTI4MWQzMTJhNDQzYzNiNzlhZmQ3NzdjNzc4OTkyIiwiaCI6Im11cm11cjY0In0=',
  );

  static const String baseUrl = _baseUrl;
  static const String apiBaseUrl = '${_baseUrl}api/';
  static const String orsApiKey = _orsApiKey;

  static const String mapTileUrl =
      'https://tile.openstreetmap.org/{z}/{x}/{y}.png';
  static const String userAgent = 'com.example.transnet_graduation_project';
}
