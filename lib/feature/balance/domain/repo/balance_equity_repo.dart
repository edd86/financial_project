import 'package:financial_project/core/response.dart';
import 'package:financial_project/feature/balance/domain/model/balance_equity.dart';

abstract class BalanceEquityRepo {
  Future<Response<List<BalanceEquity>>> getBalanceEquities(int balanceSheetId);
  Future<Response<BalanceEquity>> createBalanceEquity(
    BalanceEquity balanceEquity,
  );
}
