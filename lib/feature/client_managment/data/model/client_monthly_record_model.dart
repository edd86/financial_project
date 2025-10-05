class ClientMonthlyRecordModel {
  final int? id;
  final int clientId;
  final String recordMonth;
  final int recordYear;
  final double totalPurchases;
  final double purchaseDiscount;
  final int purchaseInvoiceCount;
  final double? netPurchases;
  final double grossSales;
  final double salesDiscount;
  final int salesInvoiceCount;
  final double? netSales;
  final double? taxableIncome;
  final String status;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  ClientMonthlyRecordModel({
    this.id,
    required this.clientId,
    required this.recordMonth,
    required this.recordYear,
    required this.totalPurchases,
    required this.purchaseDiscount,
    required this.purchaseInvoiceCount,
    this.netPurchases,
    required this.grossSales,
    required this.salesDiscount,
    required this.salesInvoiceCount,
    this.netSales,
    this.taxableIncome,
    required this.status,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ClientMonthlyRecordModel.fromMap(Map<String, dynamic> map) {
    return ClientMonthlyRecordModel(
      id: map['id'] as int?,
      clientId: map['client_id'] as int,
      recordMonth: map['record_month'] as String,
      recordYear: map['record_year'] as int,
      totalPurchases: map['total_purchases'],
      purchaseDiscount: map['purchase_discount'],
      purchaseInvoiceCount: map['purchase_invoice_count'],
      netPurchases: map['net_purchases'],
      grossSales: map['gross_sales'],
      salesDiscount: map['sales_discount'],
      salesInvoiceCount: map['sales_invoice_count'] as int? ?? 0,
      netSales: map['net_sales'],
      taxableIncome: map['taxable_income'],
      status: map['status'],
      notes: map['notes'],
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
    );
  }

  // Método toMap
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'client_id': clientId,
      'record_month': recordMonth,
      'record_year': recordYear,
      'total_purchases': totalPurchases,
      'purchase_discount': purchaseDiscount,
      'purchase_invoice_count': purchaseInvoiceCount,
      'net_purchases': netPurchases,
      'gross_sales': grossSales,
      'sales_discount': salesDiscount,
      'sales_invoice_count': salesInvoiceCount,
      'net_sales': netSales,
      'taxable_income': taxableIncome,
      'status': status,
      'notes': notes,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  ClientMonthlyRecordModel copyWith({
    int? id,
    int? clientId,
    String? recordMonth,
    int? recordYear,
    double? totalPurchases,
    double? purchaseDiscount,
    int? purchaseInvoiceCount,
    double? netPurchases,
    double? grossSales,
    double? salesDiscount,
    int? salesInvoiceCount,
    double? netSales,
    double? taxableIncome,
    String? status,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ClientMonthlyRecordModel(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      recordMonth: recordMonth ?? this.recordMonth,
      recordYear: recordYear ?? this.recordYear,
      totalPurchases: totalPurchases ?? this.totalPurchases,
      purchaseDiscount: purchaseDiscount ?? this.purchaseDiscount,
      purchaseInvoiceCount: purchaseInvoiceCount ?? this.purchaseInvoiceCount,
      netPurchases: netPurchases ?? this.netPurchases,
      grossSales: grossSales ?? this.grossSales,
      salesDiscount: salesDiscount ?? this.salesDiscount,
      salesInvoiceCount: salesInvoiceCount ?? this.salesInvoiceCount,
      netSales: netSales ?? this.netSales,
      taxableIncome: taxableIncome ?? this.taxableIncome,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
