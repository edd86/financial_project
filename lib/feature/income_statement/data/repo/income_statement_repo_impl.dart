import 'package:financial_project/core/response.dart';
import 'package:financial_project/db/helper/db_helper.dart';
import 'package:financial_project/feature/income_statement/data/mapper/client_statement_mapper.dart';
import 'package:financial_project/feature/income_statement/data/mapper/income_statement_mapper.dart';
import 'package:financial_project/feature/income_statement/data/model/client_statement_model.dart';
import 'package:financial_project/feature/income_statement/domain/model/client_statement.dart';
import 'package:financial_project/feature/income_statement/domain/model/income_statement.dart';
import 'package:financial_project/feature/income_statement/domain/repo/income_statement_repo.dart';

class IncomeStatementRepoImpl implements IncomeStatementRepo {
  @override
  Future<Response<List<ClientStatement>>> getClientsStatement({
    String name = '',
  }) async {
    final db = await DatabaseHelper().database;

    try {
      final res = await db.query(
        'clients',
        where: 'business_name LIKE ?',
        whereArgs: ['%$name%'],
        orderBy: 'business_name',
      );
      if (res.isEmpty) {
        return Response.success([], message: 'No hay clientes registrados');
      }
      final clients = res
          .map(
            (client) => ClientStatementMapper.toEntity(
              ClientStatementModel.fromMap(client),
            ),
          )
          .toList();
      return Response.success(clients);
    } catch (e) {
      return Response.error(e.toString());
    }
  }

  @override
  Future<Response<IncomeStatement>> createIncomeStatement(
    IncomeStatement incomeStatement,
  ) async {
    final db = await DatabaseHelper().database;
    final incomeStatementModel = IncomeStatementMapper.toModel(incomeStatement);

    try {
      final res = await db.insert(
        'income_statements',
        incomeStatementModel.toMap(),
      );
      if (res <= 0) {
        return Response.error('No se pudo registrar el estado');
      }
      return Response.success(
        message: 'Estado registrado con éxito',
        IncomeStatementMapper.toEntity(incomeStatementModel.copyWith(id: res)),
      );
    } catch (e) {
      return Response.error(e.toString());
    }
  }
}
