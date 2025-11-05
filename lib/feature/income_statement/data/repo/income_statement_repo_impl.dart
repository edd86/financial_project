import 'package:financial_project/core/response.dart';
import 'package:financial_project/db/helper/db_helper.dart';
import 'package:financial_project/feature/income_statement/data/mapper/client_statement_mapper.dart';
import 'package:financial_project/feature/income_statement/data/mapper/income_statement_mapper.dart';
import 'package:financial_project/feature/income_statement/data/model/client_statement_model.dart';
import 'package:financial_project/feature/income_statement/data/model/income_statement_model.dart';
import 'package:financial_project/feature/income_statement/domain/model/client_statement.dart';
import 'package:financial_project/feature/income_statement/domain/model/income_statement.dart';
import 'package:financial_project/feature/income_statement/domain/model/income_statement_client.dart';
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

  @override
  Future<Response<List<IncomeStatementClient>>> getIncomeStatementClient({
    String name = '',
  }) async {
    final db = await DatabaseHelper().database;
    List<IncomeStatementClient> incomeStamentClients = [];

    try {
      if (name == '') {
        final res = await db.query('income_statements', orderBy: 'updated_at');
        if (res.isEmpty) {
          return Response.success(
            [],
            message: 'No existen Estados registrados',
          );
        }
        final incomeStatements = res
            .map(
              (incomeStatement) => IncomeStatementMapper.toEntity(
                IncomeStatementModel.fromMap(incomeStatement),
              ),
            )
            .toList();
        for (var incomeStatement in incomeStatements) {
          final clientRes = await getClientsStatementById(
            incomeStatement.clientId,
          );
          if (clientRes.data != null) {
            incomeStamentClients.add(
              IncomeStatementClient(
                incomeStatement: incomeStatement,
                clientStatement: clientRes.data!,
              ),
            );
          } else {
            return Response.error(clientRes.message);
          }
        }
        return Response.success(incomeStamentClients);
      }
      final res = await db.query(
        'clients',
        where: 'business_name LIKE ?',
        whereArgs: ['%$name%'],
      );
      if (res.isEmpty) {
        return Response.error('No se encontro al Cliente');
      }
      final clientStatement = ClientStatementMapper.toEntity(
        ClientStatementModel.fromMap(res.first),
      );

      final incomeStatementsRes = await db.query(
        'income_statements',
        where: 'client_id = ?',
        whereArgs: [clientStatement.id],
      );
      final incomeStatements = incomeStatementsRes.map(
        (income) => IncomeStatementMapper.toEntity(
          IncomeStatementModel.fromMap(income),
        ),
      );
      for (var incomeStatement in incomeStatements) {
        incomeStamentClients.add(
          IncomeStatementClient(
            incomeStatement: incomeStatement,
            clientStatement: clientStatement,
          ),
        );
      }
      return Response.success(incomeStamentClients);
    } catch (e) {
      return Response.error(e.toString());
    }
  }

  @override
  Future<Response<ClientStatement>> getClientsStatementById(int id) async {
    final db = await DatabaseHelper().database;

    try {
      final res = await db.query('clients', where: 'id = ?', whereArgs: [id]);

      if (res.isEmpty) {
        return Response.error('No se encontró el cliente');
      }
      final client = ClientStatementMapper.toEntity(
        ClientStatementModel.fromMap(res.first),
      );
      return Response.success(client);
    } catch (e) {
      return Response.error(e.toString());
    }
  }

  //Construccion de los métodos de actualizar y eliminar
  @override
  Future<Response<IncomeStatement>> deleteClientStatement(
    IncomeStatement incomeStatement,
  ) async {
    final db = await DatabaseHelper().database;

    final incomeStatementModel = IncomeStatementMapper.toModel(incomeStatement);

    try {
      final res = await db.delete(
        'income_statements',
        where: 'client_id = ?',
        whereArgs: [incomeStatementModel.id],
      );
      if (res <= 0) {
        return Response.error('No se pudo eliminar el estado');
      }
      return Response.success(
        message: 'Estado eliminado con éxito',
        incomeStatement,
      );
    } catch (e) {
      return Response.error(e.toString());
    }
  }
}
