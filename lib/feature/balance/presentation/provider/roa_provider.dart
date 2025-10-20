import 'package:financial_project/core/fianancial_ratios.dart';
import 'package:flutter/material.dart';

class RoaProvider extends ChangeNotifier {
  double _roa = 0.0;

  double get roa => _roa;

  void setRoa(double utilNeta, double assets) {
    _roa = FianancialRatios.roa(utilNeta, assets);
    notifyListeners();
  }
}
