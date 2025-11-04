import 'package:financial_project/feature/service_managment/data/repo/service_repo_impl.dart';
import 'package:flutter/material.dart';

class ServicesTotalAmountProvider extends ChangeNotifier {
  double _totalAmount = 0.0;

  double get totalAmount => _totalAmount;

  ServicesTotalAmountProvider() {
    getTotalAmount();
  }

  void getTotalAmount() async {
    final response = await ServiceRepoImpl().getTotalEarnings();
    if (response.success) {
      _totalAmount = response.data ?? 0.0;
      notifyListeners();
    }
  }
}
