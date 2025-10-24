import 'package:financial_project/feature/income_statement/domain/model/client_statement.dart';
import 'package:financial_project/feature/income_statement/domain/model/income_statement.dart';

class IncomeStatementClient {
  final IncomeStatement incomeStatement;
  final ClientStatement clientStatement;
  IncomeStatementClient({
    required this.incomeStatement,
    required this.clientStatement,
  });
}
