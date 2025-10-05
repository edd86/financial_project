class ClientObligation {
  int? id;
  int clientId;
  int? monthlyRecordId;
  String obligationType;
  int? simplifiedId;
  int? generalId;
  double paymentAmount;
  double? appliedPercentage;
  double? taxableBase;
  DateTime dueDate;
  String status;
  DateTime periodStart;
  DateTime periodEnd;
  String? calculationNotes;
  DateTime createdAt;
  DateTime updatedAt;

  ClientObligation({
    this.id,
    required this.clientId,
    this.monthlyRecordId,
    required this.obligationType,
    this.simplifiedId,
    this.generalId,
    this.paymentAmount = 0.0,
    this.appliedPercentage,
    this.taxableBase,
    required this.dueDate,
    required this.status,
    required this.periodStart,
    required this.periodEnd,
    this.calculationNotes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();
}
