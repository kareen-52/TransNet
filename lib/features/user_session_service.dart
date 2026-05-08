// ============================================================
// lib/core/services/user_session_service.dart
// ============================================================
// يُستبدل به ApiConstants.driverId / driverName المتغيّرَيْن
// الـ static اللذَيْن كانا anti-pattern.
// يُحقن عبر GetIt كـ LazySingleton.
// ============================================================

class UserSessionService {
  int? _driverId;
  String? _driverName;
  String? _userRole;

  // ─── Setters ──────────────────────────────────────────────
  void setDriverInfo({required int id, String? name}) {
    _driverId = id;
    _driverName = name;
  }

  void setRole(String role) => _userRole = role;

  // ─── Getters ──────────────────────────────────────────────
  int? get driverId => _driverId;
  String? get driverName => _driverName;
  String? get userRole => _userRole;
  bool get isDriver => _userRole == 'driver';
  bool get isClient => _userRole == 'client';

  // ─── Clear (logout) ──────────────────────────────────────
  void clear() {
    _driverId = null;
    _driverName = null;
    _userRole = null;
  }
}
