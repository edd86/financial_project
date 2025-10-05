import 'package:financial_project/feature/balance/data/model/balance_asset_model.dart';
import 'package:financial_project/feature/balance/domain/model/balance_asset.dart';

class BalanceAssetMapper {
  static BalanceAsset toEntity(BalanceAssetModel model) {
    return BalanceAsset(
      id: model.id,
      balanceSheetId: model.balanceSheetId,
      name: model.name,
      type: model.type,
      category: model.category,
      amount: model.amount,
      description: model.description,
    );
  }

  static BalanceAssetModel toModel(BalanceAsset entity) {
    return BalanceAssetModel(
      id: entity.id,
      balanceSheetId: entity.balanceSheetId,
      name: entity.name,
      type: entity.type,
      category: entity.category,
      amount: entity.amount,
      description: entity.description,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }
}
