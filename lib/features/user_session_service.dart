
class UserSessionService {
  int? _driverId;
  String? _driverName;
  String? _userRole;


  void setDriverInfo({required int id, String? name}) {
    _driverId = id;
    _driverName = name;
  }

  void setRole(String role) => _userRole = role;


  int? get driverId => _driverId;
  String? get driverName => _driverName;
  String? get userRole => _userRole;
  bool get isDriver => _userRole == 'driver';
  bool get isClient => _userRole == 'client';


  void clear() {
    _driverId = null;
    _driverName = null;
    _userRole = null;
  }
}
