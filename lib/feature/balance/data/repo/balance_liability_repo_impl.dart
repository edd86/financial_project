import 'package:financial_project/core/response.dart';
import 'package:financial_project/db/helper/db_helper.dart';
import 'package:financial_project/feature/balance/data/mapper/balance_liability_mapper.dart';
import 'package:financial_project/feature/balance/data/model/balance_liability_model.dart';
import 'package:financial_project/feature/balance/domain/model/balance_liability.dart';
import 'package:financial_project/feature/balance/domain/repo/balance_liability_repo.dart';

class LiabilityRepoImpl implements BalanceLiabilityRepo {
  @override
  Future<Response<List<BalanceLiability>>> getBalanceLiabilities(
    int balanceSheetId,
  ) async {
    final db = await DatabaseHelper().database;
    try {
      final res = await db.query(
        'balance_liabilities',
        where: 'balance_sheet_id = ?',
        whereArgs: [balanceSheetId],
      );
      if (res.isEmpty) {
        return Response.success([]);
      }
      return Response.success(
        res
            .map(
              (res) => BalanceLiabilityMapper.toEntity(
                BalanceLiabilityModel.fromMap(res),
              ),
            )
            .toList(),
      );
    } catch (e) {
      return Response.error(e.toString());
    }
  }

  @override
  Future<Response<BalanceLiability>> addBalanceLiability(
    BalanceLiability balanceLiability,
  ) async {
    final db = await DatabaseHelper().database;
    final balanceLiabilityModel = BalanceLiabilityMapper.toModel(
      balanceLiability,
    );
    try {
      final id = await db.insert('liabilities', balanceLiabilityModel.toMap());
      if (id <= 0) {
        return Response.error('Error al agregar el pasivo');
      }
      return Response.success(
        BalanceLiabilityMapper.toEntity(balanceLiabilityModel.copyWith(id: id)),
        message: 'Pasivo agregado correctamente',
      );
    } catch (e) {
      return Response.error(e.toString());
    }
  }
}
