import 'package:financial_project/core/response.dart';
import 'package:financial_project/db/helper/db_helper.dart';
import 'package:financial_project/feature/balance/data/mapper/balance_asset_mapper.dart';
import 'package:financial_project/feature/balance/data/model/balance_asset_model.dart';
import 'package:financial_project/feature/balance/domain/model/balance_asset.dart';
import 'package:financial_project/feature/balance/domain/repo/balance_asset_repo.dart';

class BalanceAssetRepoImpl implements BalanceAssetRepo {
  @override
  Future<Response<List<BalanceAsset>>> getBalanceAssets(
    int balanceSheetId,
  ) async {
    final db = await DatabaseHelper().database;

    final res = await db.query(
      'assets',
      where: 'balance_sheet_id = ?',
      whereArgs: [balanceSheetId],
    );
    if (res.isEmpty) {
      return Response.error('No assets found');
    }
    return Response.success(
      res
          .map((e) => BalanceAssetMapper.toEntity(BalanceAssetModel.fromMap(e)))
          .toList(),
    );
  }

  @override
  Future<Response<BalanceAsset>> addBalanceAsset(
    BalanceAsset balanceAsset,
  ) async {
    final db = await DatabaseHelper().database;
    final balanceModel = BalanceAssetMapper.toModel(balanceAsset);
    final res = await db.insert('assets', balanceModel.toMap());
    if (res <= 0) {
      return Response.error('Failed to add asset');
    }
    return Response.success(
      BalanceAssetMapper.toEntity(balanceModel.copyWith(id: res)),
      message: 'Cuenta de activo resgistrada.',
    );
  }

  @override
  Future<Response<BalanceAsset>> updateBalanceAsset(
    BalanceAsset balanceAsset,
  ) async {
    final db = await DatabaseHelper().database;
    final balanceModel = BalanceAssetMapper.toModel(balanceAsset);
    final res = await db.update(
      'assets',
      balanceModel.toMap(),
      where: 'id = ?',
      whereArgs: [balanceModel.id],
    );
    if (res <= 0) {
      return Response.error('Failed to update asset');
    }
    return Response.success(BalanceAssetMapper.toEntity(balanceModel));
  }
}
