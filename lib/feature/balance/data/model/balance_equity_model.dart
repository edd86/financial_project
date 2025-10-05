class BalanceEquityModel {
  final int? id;
  final int balanceSheetId;
  final String name;
  final String? category;
  final double amount;
  final String? description;
  final DateTime createdAt;
  final DateTime updatedAt;

  BalanceEquityModel({
    this.id,
    required this.balanceSheetId,
    required this.name,
    this.category,
    this.amount = 0.0,
    this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Convierte un Map (fila de SQLite) en un objeto EquityModel
  factory BalanceEquityModel.fromMap(Map<String, dynamic> map) {
    return BalanceEquityModel(
      id: map['id'],
      balanceSheetId: map['balance_sheet_id'],
      name: map['name'],
      category: map['category'],
      amount: map['amount'],
      description: map['description'],
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
    );
  }

  /// Convierte el objeto EquityModel en un Map (para insertar o actualizar)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'balance_sheet_id': balanceSheetId,
      'name': name,
      'category': category,
      'amount': amount,
      'description': description,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  /// Crea una copia del objeto con algunos valores modificados
  BalanceEquityModel copyWith({
    int? id,
    int? balanceSheetId,
    String? name,
    String? category,
    double? amount,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return BalanceEquityModel(
      id: id ?? this.id,
      balanceSheetId: balanceSheetId ?? this.balanceSheetId,
      name: name ?? this.name,
      category: category ?? this.category,
      amount: amount ?? this.amount,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
