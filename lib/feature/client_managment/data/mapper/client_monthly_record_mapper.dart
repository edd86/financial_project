import 'package:financial_project/feature/client_managment/data/model/client_monthly_record_model.dart';
import 'package:financial_project/feature/client_managment/domain/model/client_monthly_record.dart';

class ClientMonthlyRecordMapper {
  static ClientMonthlyRecord toEntity(ClientMonthlyRecordModel model) {
    return ClientMonthlyRecord(
      id: model.id,
      clientId: model.clientId,
      recordMonth: model.recordMonth,
      recordYear: model.recordYear,
      totalPurchases: model.totalPurchases,
      purchaseDiscount: model.purchaseDiscount,
      purchaseInvoiceCount: model.purchaseInvoiceCount,
      netPurchases: model.netPurchases,
      grossSales: model.grossSales,
      salesDiscount: model.salesDiscount,
      salesInvoiceCount: model.salesInvoiceCount,
      netSales: model.netSales,
      taxableIncome: model.taxableIncome,
      status: model.status,
      notes: model.notes,
      createdAt: model.createdAt,
      updatedAt: model.updatedAt,
    );
  }

  static ClientMonthlyRecordModel toModel(ClientMonthlyRecord entity) {
    return ClientMonthlyRecordModel(
      id: entity.id,
      clientId: entity.clientId,
      recordMonth: entity.recordMonth,
      recordYear: entity.recordYear,
      totalPurchases: entity.totalPurchases,
      purchaseDiscount: entity.purchaseDiscount,
      purchaseInvoiceCount: entity.purchaseInvoiceCount,
      netPurchases: entity.netPurchases,
      grossSales: entity.grossSales,
      salesDiscount: entity.salesDiscount,
      salesInvoiceCount: entity.salesInvoiceCount,
      netSales: entity.netSales,
      taxableIncome: entity.taxableIncome,
      status: entity.status,
      notes: entity.notes,
      createdAt: entity.createdAt ?? DateTime.now(),
      updatedAt: entity.updatedAt ?? DateTime.now(),
    );
  }
}
