import 'package:financial_project/feature/income_statement/domain/model/client_statement.dart';
import 'package:flutter/material.dart';

class ClientStatementProvider extends ChangeNotifier {
  ClientStatement? _client;

  ClientStatement? get client => _client;

  void setClient(ClientStatement client) {
    _client = client;
    notifyListeners();
  }
}
