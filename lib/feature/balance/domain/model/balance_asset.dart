class BalanceAsset {
  final int? id;
  final int balanceSheetId;
  final String name;
  final String type;
  final String category;
  final double amount;
  final String description;

  BalanceAsset({
    this.id,
    required this.balanceSheetId,
    required this.name,
    required this.type,
    required this.category,
    required this.amount,
    required this.description,
  });
}
