import 'package:financial_project/core/response.dart';
import 'package:financial_project/feature/client_managment/data/repo/client_repo_impl.dart';
import 'package:financial_project/feature/client_managment/domain/model/clients_home_entity.dart';
import 'package:flutter/material.dart';

class ClientsHomeProvider extends ChangeNotifier {
  ClientsHomeEntity? _clientsHome;

  ClientsHomeProvider() {
    setClientsHome();
  }

  ClientsHomeEntity? get clientsHome => _clientsHome;

  void setClientsHome() async {
    Response<ClientsHomeEntity> response = await ClientRepoImpl()
        .getClientsHome();
    if (response.success) {
      _clientsHome = response.data;
      notifyListeners();
    }
  }
}
