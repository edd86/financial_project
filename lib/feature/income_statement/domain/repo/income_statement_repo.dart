import 'package:financial_project/core/response.dart';
import 'package:financial_project/feature/income_statement/domain/model/client_statement.dart';
import 'package:financial_project/feature/income_statement/domain/model/income_statement.dart';

abstract class IncomeStatementRepo {
  Future<Response<List<ClientStatement>>> getClientsStatement({
    String name = '',
  });
  Future<Response<IncomeStatement>> createIncomeStatement(
    IncomeStatement incomeStatement,
  );
}
