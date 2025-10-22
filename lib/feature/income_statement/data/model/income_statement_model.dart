class IncomeStatementModel {
  final int? id;
  final int clientId;
  final DateTime periodStartDate;
  final DateTime periodEndDate;
  final double netSales;
  final double costOfSales;
  final double salesExpenses;
  final double adminExpenses;
  final double depreciation;
  final double otherIncome;
  final double financialExpenses;
  final double taxes;
  final DateTime createdAt;
  final DateTime updatedAt;

  const IncomeStatementModel({
    this.id,
    required this.clientId,
    required this.periodStartDate,
    required this.periodEndDate,
    required this.netSales,
    required this.costOfSales,
    required this.salesExpenses,
    required this.adminExpenses,
    required this.depreciation,
    required this.otherIncome,
    required this.financialExpenses,
    required this.taxes,
    required this.createdAt,
    required this.updatedAt,
  });

  factory IncomeStatementModel.fromMap(Map<String, dynamic> map) =>
      IncomeStatementModel(
        id: map['id'],
        clientId: map['client_id'],
        periodStartDate: DateTime.parse(map['period_start_date']),
        periodEndDate: DateTime.parse(map['period_end_date']),
        netSales: map['net_sales'],
        costOfSales: map['cost_of_sales'],
        salesExpenses: map['sales_expenses'],
        adminExpenses: map['admin_expenses'],
        depreciation: map['depreciation'],
        otherIncome: map['other_income'],
        financialExpenses: map['financial_expenses'],
        taxes: map['taxes'],
        createdAt: DateTime.parse(map['created_at']),
        updatedAt: DateTime.parse(map['updated_at']),
      );

  Map<String, dynamic> toMap() => {
    'id': id,
    'client_id': clientId,
    'period_start_date': periodStartDate.toIso8601String(),
    'period_end_date': periodEndDate.toIso8601String(),
    'net_sales': netSales,
    'cost_of_sales': costOfSales,
    'sales_expenses': salesExpenses,
    'admin_expenses': adminExpenses,
    'depreciation': depreciation,
    'other_income': otherIncome,
    'financial_expenses': financialExpenses,
    'taxes': taxes,
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
  };

  IncomeStatementModel copyWith({
    int? id,
    int? clientId,
    DateTime? periodStartDate,
    DateTime? periodEndDate,
    double? netSales,
    double? costOfSales,
    double? salesExpenses,
    double? adminExpenses,
    double? depreciation,
    double? otherIncome,
    double? financialExpenses,
    double? taxes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => IncomeStatementModel(
    id: id ?? this.id,
    clientId: clientId ?? this.clientId,
    periodStartDate: periodStartDate ?? this.periodStartDate,
    periodEndDate: periodEndDate ?? this.periodEndDate,
    netSales: netSales ?? this.netSales,
    costOfSales: costOfSales ?? this.costOfSales,
    salesExpenses: salesExpenses ?? this.salesExpenses,
    adminExpenses: adminExpenses ?? this.adminExpenses,
    depreciation: depreciation ?? this.depreciation,
    otherIncome: otherIncome ?? this.otherIncome,
    financialExpenses: financialExpenses ?? this.financialExpenses,
    taxes: taxes ?? this.taxes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
}
