import 'package:financial_project/core/response.dart';
import 'package:financial_project/feature/balance/domain/model/balance_liability.dart';

abstract class BalanceLiabilityRepo {
  Future<Response<List<BalanceLiability>>> getBalanceLiabilities(
    int balanceSheetId,
  );
  Future<Response<BalanceLiability>> addBalanceLiability(
    BalanceLiability balanceLiability,
  );
}
