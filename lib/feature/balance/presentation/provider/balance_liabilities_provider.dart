import 'package:financial_project/core/response.dart';
import 'package:financial_project/feature/balance/data/repo/balance_liability_repo_impl.dart';
import 'package:financial_project/feature/balance/domain/model/balance_liability.dart';
import 'package:flutter/material.dart';

class BalanceLiabilitiesProvider extends ChangeNotifier {
  Response<List<BalanceLiability>> _balanceLiabilities =
      Response.success([]);
      int? _currentBalanceId;

  Response<List<BalanceLiability>> get balanceLiabilities => _balanceLiabilities;
  int? get currentBalanceId => _currentBalanceId;

  void setBalanceLiabilities(int balanceId) async {
    _currentBalanceId = balanceId;
    final balanceLiabilities = await BalanceLiabilityRepoImpl().getBalanceLiabilities(
      balanceId,
    );
    _balanceLiabilities = balanceLiabilities;
    notifyListeners();
  }

  void refreshLiabilities() {
    if (_currentBalanceId != null) {
      setBalanceLiabilities(_currentBalanceId!);
    }
  }

  Future<Response<BalanceLiability>> deleteLiability(BalanceLiability liability) async {
    final result = await BalanceLiabilityRepoImpl().deleteBalanceLiability(liability);
    if (result.success) {
      refreshLiabilities();
    }
    return result;
  }
}