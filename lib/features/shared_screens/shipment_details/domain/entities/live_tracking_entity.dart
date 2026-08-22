class LiveTrackingEntity {
  final double? remainingDistanceKm;
  final int? remainingDurationMins;
  final String? error;
 
  const LiveTrackingEntity({
    this.remainingDistanceKm,
    this.remainingDurationMins,
    this.error,
  });
 
  bool get hasError => error != null && error!.trim().isNotEmpty;
 
  bool get hasData => remainingDistanceKm != null && remainingDurationMins != null;
 
  static LiveTrackingEntity? fromDynamic(dynamic raw) {
    if (raw == null) return null;
    if (raw is! Map) return null;
 
    final map = Map<String, dynamic>.from(raw);
 
    if (map['error'] != null) {
      return LiveTrackingEntity(error: map['error'].toString());
    }
 
    final rawDistance = map['remaining_distance_km'];
    final rawDuration = map['remaining_duration_mins'];
 
    final double? distance = rawDistance is num
        ? rawDistance.toDouble()
        : double.tryParse(rawDistance?.toString() ?? '');
 
    final int? duration = rawDuration is num
        ? rawDuration.toInt()
        : int.tryParse(rawDuration?.toString() ?? '');
 
    if (distance == null && duration == null) return null;
 
    return LiveTrackingEntity(
      remainingDistanceKm: distance,
      remainingDurationMins: duration,
    );
  }
}
 