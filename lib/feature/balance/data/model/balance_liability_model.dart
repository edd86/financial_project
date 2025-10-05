class BalanceLiabilityModel {
  final int? id;
  final int balanceSheetId;
  final String name;
  final String type; // 'corriente' o 'no corriente'
  final String? category;
  final double amount;
  final String? description;
  final String createdAt;
  final String updatedAt;

  BalanceLiabilityModel({
    this.id,
    required this.balanceSheetId,
    required this.name,
    required this.type,
    this.category,
    this.amount = 0.0,
    this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Convierte un Map (fila de SQLite) en un objeto LiabilityModel
  factory BalanceLiabilityModel.fromMap(Map<String, dynamic> map) {
    return BalanceLiabilityModel(
      id: map['id'] as int?,
      balanceSheetId: map['balance_sheet_id'] as int,
      name: map['name'] as String,
      type: map['type'] as String,
      category: map['category'] as String?,
      amount: (map['amount'] as num).toDouble(),
      description: map['description'] as String?,
      createdAt: map['created_at'] as String,
      updatedAt: map['updated_at'] as String,
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
      'created_at': createdAt,
      'updated_at': updatedAt,
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
    String? createdAt,
    String? updatedAt,
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
