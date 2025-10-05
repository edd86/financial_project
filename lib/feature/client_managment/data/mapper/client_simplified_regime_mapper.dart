import 'package:financial_project/feature/client_managment/data/model/client_simplified_regime_model.dart';
import 'package:financial_project/feature/client_managment/domain/model/client_simplified_regime.dart';

class ClientSimplifiedRegimeMapper {
  static ClientSimplifiedRegime toEntity(ClientSimplifiedRegimeModel model) {
    return ClientSimplifiedRegime(
      id: model.id,
      category: model.category,
      minCapital: model.minCapital,
      maxCapital: model.maxCapital,
      amount: model.amount,
      duePattern: model.duePattern,
    );
  }

  static ClientSimplifiedRegimeModel toModel(ClientSimplifiedRegime entity) {
    return ClientSimplifiedRegimeModel(
      id: entity.id,
      category: entity.category,
      minCapital: entity.minCapital,
      maxCapital: entity.maxCapital,
      amount: entity.amount,
      duePattern: entity.duePattern,
    );
  }
}
