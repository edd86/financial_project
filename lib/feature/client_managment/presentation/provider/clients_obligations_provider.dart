import 'package:financial_project/core/response.dart';
import 'package:financial_project/feature/client_managment/data/repo/client_repo_impl.dart';
import 'package:financial_project/feature/client_managment/domain/model/client_obligation.dart';
import 'package:flutter/material.dart';

class ClientsObligationsProvider extends ChangeNotifier {
  Response<List<ClientObligation>>? _clientObligations;

  Response<List<ClientObligation>>? get clientObligations => _clientObligations;

  Future<void> setClientObligations(int clientId) async {
    // Indicar que estamos cargando
    _clientObligations = null;
    notifyListeners();

    final response = await ClientRepoImpl().getClientObligations(clientId);

    // Siempre actualizar el estado, incluso si hay error
    _clientObligations = response;
    notifyListeners();
  }
}
