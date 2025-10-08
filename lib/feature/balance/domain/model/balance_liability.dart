class BalanceLiability {
  final int? id;
  final int balanceSheetId;
  final String name;
  final String type; // 'corriente' o 'no corriente'
  final String? category;
  final double amount;
  final String? description;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  BalanceLiability({
    this.id,
    required this.balanceSheetId,
    required this.name,
    required this.type,
    this.category,
    this.amount = 0.0,
    this.description,
    this.createdAt,
    this.updatedAt,
  });
}
