class DriverStatisticsModel {
  final int total;
  final double totalPrice;
  final int unpaidCount;
  final double unpaidAmount;
  final double unreceivedBonusesSum;
  final double unreceivedTaxesSum;
  final double amountToPay;
  final double myEarnings;
  final List<FinancialTransactionModel> allBonuses;
  final List<FinancialTransactionModel> allTaxes;

  DriverStatisticsModel({
    required this.total,
    required this.totalPrice,
    required this.unpaidCount,
    required this.unpaidAmount,
    required this.unreceivedBonusesSum,
    required this.unreceivedTaxesSum,
    required this.amountToPay,
    required this.myEarnings,
    required this.allBonuses,
    required this.allTaxes,
  });

  factory DriverStatisticsModel.fromJson(Map<String, dynamic> json) {
    return DriverStatisticsModel(
      total: json['total'] ?? 0,
      totalPrice: double.tryParse(json['total_price'].toString()) ?? 0.0,
      unpaidCount: json['unpaid_count'] ?? 0,
      unpaidAmount: double.tryParse(json['unpaid_amount'].toString()) ?? 0.0,
      unreceivedBonusesSum: double.tryParse(json['unreceived_bonuses_sum'].toString()) ?? 0.0,
      unreceivedTaxesSum: double.tryParse(json['unreceived_taxes_sum'].toString()) ?? 0.0,
      amountToPay: double.tryParse(json['amount_to_pay'].toString()) ?? 0.0,
      myEarnings: double.tryParse(json['my_earnings'].toString()) ?? 0.0,
      allBonuses: json['all_bonuses'] != null
          ? (json['all_bonuses'] as List).map((i) => FinancialTransactionModel.fromJson(i)).toList()
          : [],
      allTaxes: json['all_taxes'] != null
          ? (json['all_taxes'] as List).map((i) => FinancialTransactionModel.fromJson(i)).toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'total_price': totalPrice,
      'unpaid_count': unpaidCount,
      'unpaid_amount': unpaidAmount,
      'unreceived_bonuses_sum': unreceivedBonusesSum,
      'unreceived_taxes_sum': unreceivedTaxesSum,
      'amount_to_pay': amountToPay,
      'my_earnings': myEarnings,
      'all_bonuses': allBonuses.map((e) => e.toJson()).toList(),
      'all_taxes': allTaxes.map((e) => e.toJson()).toList(),
    };
  }
}

class FinancialTransactionModel {
  final int id;
  final double value;
  final bool isReceived;
  final String type; 
  final String createdAt;

  FinancialTransactionModel({
    required this.id,
    required this.value,
    required this.isReceived,
    required this.type,
    required this.createdAt,
  });

  factory FinancialTransactionModel.fromJson(Map<String, dynamic> json) {
    return FinancialTransactionModel(
      id: json['id'] ?? 0,
      value: double.tryParse(json['value'].toString()) ?? 0.0,
      isReceived: json['received'] == 1 || json['received'] == true,
      type: json['type'] ?? '',
      createdAt: json['created_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'value': value,
      'received': isReceived ? 1 : 0,
      'type': type,
      'created_at': createdAt,
    };
  }
}