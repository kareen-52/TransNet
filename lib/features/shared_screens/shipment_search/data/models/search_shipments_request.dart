class SearchShipmentsRequest {
  final String startDate;
  final String endDate;

  SearchShipmentsRequest({
    required this.startDate,
    required this.endDate,
  });

  Map<String, dynamic> toJson() => {
        'start_date': startDate,
        'end_date': endDate,
      };
}