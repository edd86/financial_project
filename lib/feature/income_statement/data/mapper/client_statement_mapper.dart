import 'package:financial_project/feature/income_statement/data/model/client_statement_model.dart';
import 'package:financial_project/feature/income_statement/domain/model/client_statement.dart';

class ClientStatementMapper {
  static ClientStatementModel toModel(ClientStatement entity) {
    return ClientStatementModel(
      id: entity.id,
      name: entity.name,
      nitCi: entity.nitCi,
    );
  }

  static ClientStatement toEntity(ClientStatementModel model) {
    return ClientStatement(id: model.id, name: model.name, nitCi: model.nitCi);
  }
}
