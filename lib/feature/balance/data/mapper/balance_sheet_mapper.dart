import 'package:financial_project/feature/balance/data/model/balance_sheet_model.dart';
import 'package:financial_project/feature/balance/domain/model/balance_sheet.dart';

class BalanceSheetMapper {
  static BalanceSheet toEntity(BalanceSheetModel model) {
    return BalanceSheet(
      id: model.id,
      clientId: model.clientId,
      balanceDate: model.balanceDate,
      period: model.period,
      status: model.status,
      totalAssets: model.totalAssets,
      totalLiabilities: model.totalLiabilities,
      totalEquity: model.totalEquity,
    );
  }

  static BalanceSheetModel toModel(BalanceSheet entity) {
    return BalanceSheetModel(
      id: entity.id,
      clientId: entity.clientId,
      balanceDate: entity.balanceDate,
      period: entity.period,
      status: entity.status,
      totalAssets: entity.totalAssets,
      totalLiabilities: entity.totalLiabilities,
      totalEquity: entity.totalEquity,
      createdAt: DateTime.now().toIso8601String(),
      updatedAt: DateTime.now().toIso8601String(),
    );
  }
}
