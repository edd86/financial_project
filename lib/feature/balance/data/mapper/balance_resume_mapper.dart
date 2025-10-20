import 'package:financial_project/feature/balance/data/model/balance_resume_model.dart';
import 'package:financial_project/feature/balance/domain/model/balance_resume_entity.dart';

class BalanceResumeMapper {
  static BalanceResumeEntity toEntity(BalanceResumeModel model) {
    return BalanceResumeEntity(
      totalAssets: model.totalAssets,
      totalLiabilities: model.totalLiabilities,
      totalEquity: model.totalEquity,
      inventory: model.inventory,
    );
  }
}
