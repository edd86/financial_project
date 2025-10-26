import 'package:financial_project/core/response.dart';
import 'package:financial_project/db/helper/db_helper.dart';
import 'package:financial_project/feature/balance/data/mapper/balance_equity_mapper.dart';
import 'package:financial_project/feature/balance/data/model/balance_equity_model.dart';
import 'package:financial_project/feature/balance/domain/model/balance_equity.dart';
import 'package:financial_project/feature/balance/domain/repo/balance_equity_repo.dart';

class BalanceEquityRepoImpl implements BalanceEquityRepo {
  @override
  Future<Response<BalanceEquity>> createBalanceEquity(
    BalanceEquity balanceEquity,
  ) async {
    final db = await DatabaseHelper().database;
    final balanceEquityModel = BalanceEquityMapper.toModel(balanceEquity);
    try {
      final id = await db.insert('equity', balanceEquityModel.toMap());
      if (id <= 0) {
        return Response.error('Error al agregar la equity');
      }
      return Response.success(
        BalanceEquityMapper.toEntity(balanceEquityModel.copyWith(id: id)),
        message: 'Equity agregada correctamente',
      );
    } catch (e) {
      return Response.error('Error al agregar la equity: $e');
    }
  }

  @override
  Future<Response<List<BalanceEquity>>> getBalanceEquities(
    int balanceSheetId,
  ) async {
    final db = await DatabaseHelper().database;
    try {
      final rows = await db.query(
        'equity',
        where: 'balance_sheet_id = ?',
        whereArgs: [balanceSheetId],
      );
      if (rows.isEmpty) {
        return Response.success([], message: 'No se encontraron equities');
      }
      return Response.success(
        rows
            .map(
              (e) =>
                  BalanceEquityMapper.toEntity(BalanceEquityModel.fromMap(e)),
            )
            .toList(),
      );
    } catch (e) {
      return Response.error('Error al obtener las equities: $e');
    }
  }
}
