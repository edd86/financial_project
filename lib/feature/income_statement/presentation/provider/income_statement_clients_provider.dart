import 'package:financial_project/core/response.dart';
import 'package:financial_project/feature/income_statement/data/repo/income_statement_repo_impl.dart';
import 'package:financial_project/feature/income_statement/domain/model/income_statement_client.dart';
import 'package:flutter/material.dart';

class IncomeStatementClientsProvider extends ChangeNotifier {
  Response<List<IncomeStatementClient>> _statementClientRes = Response.success(
    [],
  );

  Response<List<IncomeStatementClient>> get statementClientRes =>
      _statementClientRes;

  void setStatementClientRes({String name = ''}) async {
    final res = await IncomeStatementRepoImpl().getIncomeStatementClient(
      name: name,
    );
    _statementClientRes = res;
    notifyListeners();
  }
}
