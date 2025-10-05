import 'package:financial_project/feature/balance/data/repo/balance_sheet_repo_impl.dart';
import 'package:financial_project/feature/balance/domain/model/balance_client.dart';
import 'package:flutter/material.dart';

class ClientsListProvider extends ChangeNotifier {
  List<BalanceClient> _clients = [];

  List<BalanceClient> get clients => _clients;

  void setClients(String name) async {
    // Iniciar con lista vacía si el nombre está vacío
    if (name.isEmpty) {
      _clients = [];
      notifyListeners();
      return;
    }
    
    final res = await BalanceSheetRepoImpl().getClientByName(name);
    // Actualizar la lista de clientes independientemente del resultado
    _clients = res.success ? (res.data ?? []) : [];
    notifyListeners();
  }
}
