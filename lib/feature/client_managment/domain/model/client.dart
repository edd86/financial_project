class Client {
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

  Client({
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
}
