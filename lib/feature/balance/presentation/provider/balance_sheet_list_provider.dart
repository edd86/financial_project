import 'package:financial_project/feature/balance/data/repo/balance_sheet_repo_impl.dart';
import 'package:financial_project/feature/balance/domain/model/balance_sheet.dart';
import 'package:financial_project/feature/balance/domain/model/balance_sheets_client.dart';
import 'package:flutter/material.dart';

class BalanceSheetListProvider extends ChangeNotifier {
  final List<BalanceSheetsClient> _balanceSheets = [];

  BalanceSheetListProvider() {
    getBalanceSheets();
  }

  List<BalanceSheetsClient> get balanceSheets => _balanceSheets;

  void addBalanceSheet(BalanceSheet balanceSheet) async {
    final res = await BalanceSheetRepoImpl().addBalance(balanceSheet);
    if (res.success) {
      _balanceSheets.clear();
      getBalanceSheets();
      notifyListeners();
    }
  }

  void getBalanceSheets() async {
    final res = await BalanceSheetRepoImpl().getClientBalanceSheets();
    if (res.success) {
      _balanceSheets.clear();
      _balanceSheets.addAll(res.data!);
      notifyListeners();
    }
  }

  void findBalanceSheetByClient(String clientName) async {
    if (clientName.isEmpty) {
      getBalanceSheets();
      notifyListeners();
      return;
    }
    final res = await BalanceSheetRepoImpl().findBalanceSheetByClient(
      clientName,
    );
    if (res.success) {
      _balanceSheets.clear();
      _balanceSheets.addAll(res.data!);
      notifyListeners();
    }
  }
}
