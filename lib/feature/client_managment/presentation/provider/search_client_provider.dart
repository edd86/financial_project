import 'package:financial_project/feature/client_managment/data/repo/client_repo_impl.dart';
import 'package:financial_project/feature/client_managment/domain/model/client.dart';
import 'package:flutter/material.dart';

class SearchClientProvider extends ChangeNotifier {
  List<Client> _searchResults = [];

  List<Client> get searchResults => _searchResults;

  Future<void> searchClients(String query) async {
    if (query.isEmpty) {
      _searchResults.clear();
      notifyListeners();
      return;
    }
    final response = await ClientRepoImpl().searchClients(query);
    if (response.success) {
      _searchResults = response.data!;
      notifyListeners();
      return;
    }
    _searchResults.clear();
    notifyListeners();
  }
}
