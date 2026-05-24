
abstract class DateFormatter {

  static String format(String? raw) {
    if (raw == null || raw.isEmpty) return 'غير محدد';
    try {
   
      final normalised = raw.trim().replaceFirst('T', ' ').split('.').first;
      final parts = normalised.split(' ');
      final datePart = parts[0].split('-').reversed.join('/');
      final timePart = parts.length >= 2 ? parts[1].substring(0, 5) : '';
      return timePart.isEmpty ? datePart : '$datePart  $timePart';
    } catch (_) {
      return raw;
    }
  }


  static String formatDateOnly(String? raw) {
    if (raw == null || raw.isEmpty) return 'غير محدد';
    try {
      final normalised = raw.trim().replaceFirst('T', ' ').split('.').first;
      final datePart = normalised.split(' ')[0];
      return datePart.split('-').reversed.join('/');
    } catch (_) {
      return raw;
    }
  }
}
