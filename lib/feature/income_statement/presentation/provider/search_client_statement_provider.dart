import 'package:financial_project/core/response.dart';
import 'package:financial_project/feature/income_statement/data/repo/income_statement_repo_impl.dart';
import 'package:financial_project/feature/income_statement/domain/model/client_statement.dart';
import 'package:flutter/material.dart';

class SearchClientStatementProvider extends ChangeNotifier {
  Response<List<ClientStatement>> _clientStatements = Response.success([]);

  Response<List<ClientStatement>> get clientStatements => _clientStatements;

  void setClientStatement({String name = ''}) async {
    final res = await IncomeStatementRepoImpl().getClientsStatement(name: name);
    _clientStatements = res;
    notifyListeners();
  }
}
