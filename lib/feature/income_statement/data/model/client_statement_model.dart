class ClientStatementModel {
  final int id;
  final String name;
  final String nitCi;

  ClientStatementModel({
    required this.id,
    required this.name,
    required this.nitCi,
  });

  factory ClientStatementModel.fromMap(Map<String, dynamic> map) {
    return ClientStatementModel(
      id: map['id'],
      name: map['business_name'],
      nitCi: map['tax_id'],
    );
  }
}
