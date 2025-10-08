class BalanceLiabilityModel {
  final int? id;
  final int balanceSheetId;
  final String name;
  final String type; // 'corriente' o 'no corriente'
  final String? category;
  final double amount;
  final String? description;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  BalanceLiabilityModel({
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

  /// Convierte un Map (fila de SQLite) en un objeto LiabilityModel
  factory BalanceLiabilityModel.fromMap(Map<String, dynamic> map) {
    return BalanceLiabilityModel(
      id: map['id'],
      balanceSheetId: map['balance_sheet_id'],
      name: map['name'],
      type: map['type'],
      category: map['category'],
      amount: map['amount'],
      description: map['description'],
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
    );
  }

  /// Convierte el objeto LiabilityModel a un Map (para insertar o actualizar)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'balance_sheet_id': balanceSheetId,
      'name': name,
      'type': type,
      'category': category,
      'amount': amount,
      'description': description,
      'created_at': createdAt!.toIso8601String(),
      'updated_at': updatedAt!.toIso8601String(),
    };
  }

  /// Crea una copia del objeto con algunos valores modificados
  BalanceLiabilityModel copyWith({
    int? id,
    int? balanceSheetId,
    String? name,
    String? type,
    String? category,
    double? amount,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return BalanceLiabilityModel(
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
}
