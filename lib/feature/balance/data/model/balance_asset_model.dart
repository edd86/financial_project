class BalanceAssetModel {
  final int? id;
  final int balanceSheetId;
  final String name;
  final String type;
  final String category;
  final double amount;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;

  BalanceAssetModel({
    this.id,
    required this.balanceSheetId,
    required this.name,
    required this.type,
    required this.category,
    required this.amount,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BalanceAssetModel.fromMap(Map<String, dynamic> json) =>
      BalanceAssetModel(
        id: json["id"],
        balanceSheetId: json["balance_sheet_id"],
        name: json["name"],
        type: json["type"],
        category: json["category"],
        amount: json["amount"].toDouble(),
        description: json["description"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
    "id": id,
    "balance_sheet_id": balanceSheetId,
    "name": name,
    "type": type,
    "category": category,
    "amount": amount,
    "description": description,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };

  BalanceAssetModel copyWith({
    int? id,
    int? balanceSheetId,
    String? name,
    String? type,
    String? category,
    double? amount,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => BalanceAssetModel(
    id: id ?? this.id,
    balanceSheetId: balanceSheetId ?? this.balanceSheetId,
    name: name ?? this.name,
    type: type ?? this.type,
    category: category ?? this.category,
    amount: amount ?? this.amount,
    description: description ?? this.description,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
}
