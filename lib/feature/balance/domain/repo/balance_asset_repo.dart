import 'package:financial_project/core/response.dart';
import 'package:financial_project/feature/balance/domain/model/balance_asset.dart';

abstract class BalanceAssetRepo {
  Future<Response<List<BalanceAsset>>> getBalanceAssets(int balanceSheetId);
  Future<Response<BalanceAsset>> addBalanceAsset(BalanceAsset balanceAsset);
  Future<Response<BalanceAsset>> updateBalanceAsset(BalanceAsset balanceAsset);
}
