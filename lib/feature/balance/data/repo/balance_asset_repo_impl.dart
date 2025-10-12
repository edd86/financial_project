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

    try {
      final res = await db.query(
        'assets',
        where: 'balance_sheet_id = ?',
        whereArgs: [balanceSheetId],
      );
      if (res.isEmpty) {
        return Response.error('No se encontraron activos');
      }
      return Response.success(
        res
            .map(
              (asset) =>
                  BalanceAssetMapper.toEntity(BalanceAssetModel.fromMap(asset)),
            )
            .toList(),
      );
    } catch (e) {
      return Response.error('Error al obtener activos: $e');
    }
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
      balanceModel.copyWith(updatedAt: DateTime.now()).toMap(),
      where: 'id = ?',
      whereArgs: [balanceModel.id],
    );
    if (res <= 0) {
      return Response.error('Error al intentar actualizar.');
    }
    return Response.success(BalanceAssetMapper.toEntity(balanceModel));
  }

  @override
  Future<Response<BalanceAsset>> deleteBalanceAsset(
    BalanceAsset balanceAsset,
  ) async {
    final db = await DatabaseHelper().database;

    try {
      final res = await db.delete(
        'assets',
        where: 'id = ?',
        whereArgs: [balanceAsset.id!],
      );
      if (res <= 0) {
        return Response.error('No se encontro el activo');
      }
      return Response.success(balanceAsset, message: 'Activo eliminado.');
    } catch (e) {
      return Response.error('Error al eliminar activo: $e');
    }
  }
}
