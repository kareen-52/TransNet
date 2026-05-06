import 'package:flutter/material.dart';

class BadgeUiHelper {
  static Color getBadgeColor(String badge) {
    if (badge.contains('مضمون')) return const Color(0xFFE53935);
    if (badge.contains('مُعتمد') || badge.contains('معتمد')) return const Color(0xFF1E88E5);
    if (badge.contains('خبير')) return const Color(0xFFFFB300);
    if (badge.contains('مُنتظم') || badge.contains('منتظم')) return const Color(0xFF43A047);
    return Colors.grey;
  }

  static String getBadgeIconPath(String badge) {
    if (badge.contains('مضمون')) return 'assets/icons/مضمون.png';
    if (badge.contains('مُعتمد') || badge.contains('معتمد')) return 'assets/icons/معتمد.png';
    if (badge.contains('خبير')) return 'assets/icons/خبير.png';
    if (badge.contains('مُنتظم') || badge.contains('منتظم')) return 'assets/icons/منتظم.png';
    return 'assets/icons/معتمد.png';
  }
}