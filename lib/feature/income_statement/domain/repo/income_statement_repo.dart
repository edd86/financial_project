import 'package:financial_project/core/response.dart';
import 'package:financial_project/feature/income_statement/domain/model/client_statement.dart';
import 'package:financial_project/feature/income_statement/domain/model/income_statement.dart';
import 'package:financial_project/feature/income_statement/domain/model/income_statement_client.dart';

abstract class IncomeStatementRepo {
  Future<Response<List<ClientStatement>>> getClientsStatement({
    String name = '',
  });
  Future<Response<IncomeStatement>> createIncomeStatement(
    IncomeStatement incomeStatement,
  );
  Future<Response<List<IncomeStatementClient>>> getIncomeStatementClient({
    String name = '',
  });
  Future<Response<ClientStatement>> getClientsStatementById(int id);
  //Metodo abstracto para actualiza y eliminar
  Future<Response<ClientStatement>> deleteClientStatement(
    ClientStatement client,
  );
}
