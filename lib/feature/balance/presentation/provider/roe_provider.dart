import 'package:financial_project/core/fianancial_ratios.dart';
import 'package:flutter/material.dart';

class RoeProvider extends ChangeNotifier {
  double _roe = 0.0;

  double get roe => _roe;

  void setRoe(double utilNeta, double equity) {
    _roe = FianancialRatios.roe(utilNeta, equity);
    notifyListeners();
  }
}
