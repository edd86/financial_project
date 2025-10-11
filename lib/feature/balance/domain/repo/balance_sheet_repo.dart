import 'package:financial_project/core/response.dart';
import 'package:financial_project/feature/balance/domain/model/balance_client.dart';
import 'package:financial_project/feature/balance/domain/model/balance_resume_entity.dart';
import 'package:financial_project/feature/balance/domain/model/balance_sheet.dart';
import 'package:financial_project/feature/balance/domain/model/balance_sheets_client.dart';

abstract class BalanceSheetRepo {
  Future<Response<BalanceSheet>> addBalance(BalanceSheet balance);
  Future<Response<List<BalanceSheet>>> getAllBalances();
  Future<Response<List<BalanceClient>>> getClientByName(String name);
  Future<Response<List<BalanceSheetsClient>>> getClientBalanceSheets();
  Future<Response<List<BalanceSheetsClient>>> findBalanceSheetByClient(
    String clientName,
  );
  Future<Response<BalanceResumeEntity>> getBalanceResume(int balanceId);
}
