class ServiceModel {
  final int? id;
  final String name;
  final double amount;

  const ServiceModel({this.id, required this.name, required this.amount});

  ServiceModel copyWith({int? id, String? name, double? amount}) {
    return ServiceModel(
      id: id ?? this.id,
      name: name ?? this.name,
      amount: amount ?? this.amount,
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'amount': amount};
  }

  factory ServiceModel.fromMap(Map<String, dynamic> map) {
    return ServiceModel(
      id: map['id'] as int?,
      name: map['name'] as String,
      amount: (map['amount'] as num).toDouble(),
    );
  }
}
