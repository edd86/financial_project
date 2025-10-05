import 'package:financial_project/feature/balance/data/model/balance_client_model.dart';
import 'package:financial_project/feature/balance/data/model/balance_sheet_model.dart';

class BalanceSheetClientModel {
  final BalanceSheetModel balanceSheetModel;
  final BalanceClientModel balanceClientModel;

  BalanceSheetClientModel({
    required this.balanceSheetModel,
    required this.balanceClientModel,
  });
}
