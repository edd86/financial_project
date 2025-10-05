import 'package:financial_project/feature/balance/data/model/balance_client_model.dart';
import 'package:financial_project/feature/balance/domain/model/balance_client.dart';

class BalanceClientMapper {
  static BalanceClient toEntity(BalanceClientModel model) {
    return BalanceClient(
      id: model.id,
      businessName: model.businessName,
      nitCi: model.nitCi,
    );
  }

  static BalanceClientModel toModel(BalanceClient entity) {
    return BalanceClientModel(
      id: entity.id,
      businessName: entity.businessName,
      nitCi: entity.nitCi,
    );
  }
}
