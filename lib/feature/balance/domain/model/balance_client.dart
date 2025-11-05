import 'package:financial_project/feature/balance/domain/model/balance_sheet.dart';

class BalanceClient {
  final int id;
  final String businessName;
  final String nitCi;
  final BalanceSheet? balanceSheet;

  BalanceClient({
    required this.id,
    required this.businessName,
    required this.nitCi,
    this.balanceSheet,
  });
}
