class ServiceLogEntity {
  final int? id;
  final int clientId;
  final int serviceId;
  final DateTime date;
  final DateTime? datePayed;
  final bool isPayed;
  final double amount;

  const ServiceLogEntity({
    this.id,
    required this.clientId,
    required this.serviceId,
    required this.date,
    this.datePayed,
    this.isPayed = false,
    required this.amount,
  });
}
