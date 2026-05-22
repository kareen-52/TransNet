/// Utility class for formatting raw API date strings into human-readable Arabic
/// date representations used throughout the Shipment Details feature.
///
/// All methods are static — no instances needed.
abstract class DateFormatter {
  /// Formats a raw API datetime string (e.g. `"2024-03-15 14:30:00"`)
  /// into a localised display string (e.g. `"15/03/2024  14:30"`).
  ///
  /// Returns `"غير محدد"` when [raw] is null or cannot be parsed.
  static String format(String? raw) {
    if (raw == null || raw.isEmpty) return 'غير محدد';
    try {
      final parts = raw.trim().split(' ');
      final datePart = parts[0].split('-').reversed.join('/');
      final timePart =
          parts.length >= 2 ? parts[1].substring(0, 5) : '';
      return timePart.isEmpty ? datePart : '$datePart  $timePart';
    } catch (_) {
      return raw;
    }
  }

  /// Formats only the date portion, stripping the time component.
  static String formatDateOnly(String? raw) {
    if (raw == null || raw.isEmpty) return 'غير محدد';
    try {
      final datePart = raw.trim().split(' ')[0];
      return datePart.split('-').reversed.join('/');
    } catch (_) {
      return raw ?? 'غير محدد';
    }
  }
}
