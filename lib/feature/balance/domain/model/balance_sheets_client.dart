import 'package:financial_project/feature/balance/domain/model/balance_client.dart';
import 'package:financial_project/feature/balance/domain/model/balance_sheet.dart';

class BalanceSheetsClient {
  final BalanceSheet balanceSheet;
  final BalanceClient balanceClient;

  BalanceSheetsClient({
    required this.balanceSheet,
    required this.balanceClient,
  });
}
