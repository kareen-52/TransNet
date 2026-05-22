/// Utility class for formatting raw API date strings into human-readable Arabic
/// date representations used throughout the Shipment Details feature.
///
/// Handles two input formats:
///   • API format  : "2024-03-15 14:30:00"
///   • ISO 8601    : "2024-03-15T14:30:00.123456"  (from DateTime.now().toIso8601String())
///
/// All methods are static — no instances needed.
abstract class DateFormatter {
  /// Formats a raw datetime string into "DD/MM/YYYY  HH:mm".
  /// Returns "غير محدد" when [raw] is null or cannot be parsed.
  static String format(String? raw) {
    if (raw == null || raw.isEmpty) return 'غير محدد';
    try {
      // Normalise: replace 'T' separator → space, strip sub-seconds
      final normalised = raw.trim().replaceFirst('T', ' ').split('.').first;
      final parts = normalised.split(' ');
      final datePart = parts[0].split('-').reversed.join('/');
      final timePart = parts.length >= 2 ? parts[1].substring(0, 5) : '';
      return timePart.isEmpty ? datePart : '$datePart  $timePart';
    } catch (_) {
      return raw;
    }
  }

  /// Formats only the date portion → "DD/MM/YYYY".
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
