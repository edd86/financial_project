class ClientMonthlyRecord {
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
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ClientMonthlyRecord({
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
    this.createdAt,
    this.updatedAt,
  });
}
