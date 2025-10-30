class ServiceLogModel {
  final int? id;
  final int clientId;
  final int serviceId;
  final DateTime date;
  final DateTime? datePayed;
  final bool isPayed;
  final double amount;

  const ServiceLogModel({
    this.id,
    required this.clientId,
    required this.serviceId,
    required this.date,
    this.datePayed,
    this.isPayed = false,
    required this.amount,
  });

  ServiceLogModel copyWith({
    int? id,
    int? clientId,
    int? serviceId,
    DateTime? date,
    DateTime? datePayed,
    bool? isPayed,
    double? amount,
  }) {
    return ServiceLogModel(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      serviceId: serviceId ?? this.serviceId,
      date: date ?? this.date,
      datePayed: datePayed ?? this.datePayed,
      isPayed: isPayed ?? this.isPayed,
      amount: amount ?? this.amount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'client_id': clientId,
      'service_id': serviceId,
      'date': date.toIso8601String(),
      'date_payed': datePayed?.toIso8601String(),
      'is_payed': isPayed ? 1 : 0,
      'amount': amount,
    };
  }

  factory ServiceLogModel.fromMap(Map<String, dynamic> map) {
    return ServiceLogModel(
      id: map['id'],
      clientId: map['client_id'],
      serviceId: map['service_id'],
      date: DateTime.parse(map['date']),
      datePayed: map['date_payed'] == null
          ? null
          : DateTime.parse(map['date_payed']),
      isPayed: map['is_payed'] == 1 ? true : false,
      amount: map['amount'].toDouble(),
    );
  }
}
