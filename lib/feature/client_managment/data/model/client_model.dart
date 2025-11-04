class ClientModel {
  final int? id;
  final String businessName;
  final String taxId;
  final double capital;
  final String regimeType;
  final String? activity;
  final String? description;
  final double? baseProductPrice;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ClientModel({
    this.id,
    required this.businessName,
    required this.taxId,
    required this.capital,
    required this.regimeType,
    this.activity,
    this.description,
    this.baseProductPrice,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'business_name': businessName,
      'tax_id': taxId,
      'capital': capital,
      'regime_type': regimeType,
      'activity': activity,
      'description': description,
      'base_product_price': baseProductPrice,
      'created_at': createdAt!.toIso8601String(),
      'updated_at': updatedAt!.toIso8601String(),
    };
  }

  factory ClientModel.fromMap(Map<String, dynamic> map) {
    return ClientModel(
      id: map['id'],
      businessName: map['business_name'],
      taxId: map['tax_id'],
      capital: map['capital']?.toDouble() ?? 0.0,
      regimeType: map['regime_type'],
      activity: map['activity'],
      description: map['description'],
      baseProductPrice: map['base_product_price']?.toDouble(),
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
    );
  }

  ClientModel copyWith({
    int? id,
    String? businessName,
    String? taxId,
    double? capital,
    String? regimeType,
    String? activity,
    String? description,
    double? baseProductPrice,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ClientModel(
      id: id ?? this.id,
      businessName: businessName ?? this.businessName,
      taxId: taxId ?? this.taxId,
      capital: capital ?? this.capital,
      regimeType: regimeType ?? this.regimeType,
      activity: activity ?? this.activity,
      description: description ?? this.description,
      baseProductPrice: baseProductPrice ?? this.baseProductPrice,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
