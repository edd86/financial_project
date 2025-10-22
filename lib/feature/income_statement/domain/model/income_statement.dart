class IncomeStatement {
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

  const IncomeStatement({
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
}
