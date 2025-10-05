class ClientObligationModel {
  int? id;
  int clientId;
  int? monthlyRecordId;
  ObligationType obligationType;
  int? simplifiedId;
  int? generalId;
  double paymentAmount;
  double? appliedPercentage;
  double? taxableBase;
  DateTime dueDate;
  ObligationStatus status;
  DateTime periodStart;
  DateTime periodEnd;
  String? calculationNotes;
  DateTime createdAt;
  DateTime updatedAt;

  ClientObligationModel({
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
    this.status = ObligationStatus.pendiente,
    required this.periodStart,
    required this.periodEnd,
    this.calculationNotes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory ClientObligationModel.fromMap(Map<String, dynamic> map) {
    return ClientObligationModel(
      id: map['id'],
      clientId: map['client_id'],
      monthlyRecordId: map['monthly_record_id'],
      obligationType: ObligationType.fromString(map['obligation_type']),
      simplifiedId: map['simplified_id'],
      generalId: map['general_id'],
      paymentAmount: map['payment_amount']?.toDouble() ?? 0.0,
      appliedPercentage: map['applied_percentage']?.toDouble(),
      taxableBase: map['taxable_base']?.toDouble(),
      dueDate: DateTime.parse(map['due_date']),
      status: ObligationStatus.fromString(map['status']),
      periodStart: DateTime.parse(map['period_start']),
      periodEnd: DateTime.parse(map['period_end']),
      calculationNotes: map['calculation_notes'],
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'client_id': clientId,
      'monthly_record_id': monthlyRecordId,
      'obligation_type': obligationType.value,
      'simplified_id': simplifiedId,
      'general_id': generalId,
      'payment_amount': paymentAmount,
      'applied_percentage': appliedPercentage,
      'taxable_base': taxableBase,
      'due_date': dueDate.toIso8601String(),
      'status': status.value,
      'period_start': periodStart.toIso8601String(),
      'period_end': periodEnd.toIso8601String(),
      'calculation_notes': calculationNotes,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  ClientObligationModel copyWith({
    int? id,
    int? clientId,
    int? monthlyRecordId,
    ObligationType? obligationType,
    int? simplifiedId,
    int? generalId,
    double? paymentAmount,
    double? appliedPercentage,
    double? taxableBase,
    DateTime? dueDate,
    ObligationStatus? status,
    DateTime? periodStart,
    DateTime? periodEnd,
    String? calculationNotes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ClientObligationModel(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      monthlyRecordId: monthlyRecordId ?? this.monthlyRecordId,
      obligationType: obligationType ?? this.obligationType,
      simplifiedId: simplifiedId ?? this.simplifiedId,
      generalId: generalId ?? this.generalId,
      paymentAmount: paymentAmount ?? this.paymentAmount,
      appliedPercentage: appliedPercentage ?? this.appliedPercentage,
      taxableBase: taxableBase ?? this.taxableBase,
      dueDate: dueDate ?? this.dueDate,
      status: status ?? this.status,
      periodStart: periodStart ?? this.periodStart,
      periodEnd: periodEnd ?? this.periodEnd,
      calculationNotes: calculationNotes ?? this.calculationNotes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

enum ObligationType {
  simplificado('simplificado'),
  general('general');

  final String value;
  const ObligationType(this.value);

  static ObligationType fromString(String value) {
    return values.firstWhere(
      (e) => e.value == value,
      orElse: () => ObligationType.general,
    );
  }
}

enum ObligationStatus {
  pendiente('pendiente'),
  cumplido('cumplido'),
  vencido('vencido');

  final String value;
  const ObligationStatus(this.value);

  static ObligationStatus fromString(String value) {
    return values.firstWhere(
      (e) => e.value == value,
      orElse: () => ObligationStatus.pendiente,
    );
  }
}
