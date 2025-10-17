import 'package:financial_project/feature/client_managment/data/model/client_general_regime_model.dart';
import 'package:financial_project/feature/client_managment/domain/model/client_general_regime.dart';

class ClientGeneralRegimeMapper {
  static ClientGeneralRegime toEntity(ClientGeneralRegimeModel model) {
    return ClientGeneralRegime(
      id: model.id,
      name: model.name,
      periodicity: model.periodicity,
      percentage: model.percentage,
      duePatterns: model.duePatterns,
    );
  }

  static ClientGeneralRegimeModel toModel(ClientGeneralRegime entity) {
    return ClientGeneralRegimeModel(
      id: entity.id,
      name: entity.name,
      periodicity: entity.periodicity,
      percentage: entity.percentage,
      duePatterns: entity.duePatterns,
    );
  }
}
