class BalanceEquity {
  final int? id;
  final int balanceSheetId;
  final String name;
  final String? category;
  final double amount;
  final String? description;

  BalanceEquity({
    this.id,
    required this.balanceSheetId,
    required this.name,
    this.category,
    this.amount = 0.0,
    this.description,
  });
}
