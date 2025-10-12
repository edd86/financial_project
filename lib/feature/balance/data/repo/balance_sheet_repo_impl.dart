import 'package:financial_project/core/response.dart';
import 'package:financial_project/db/helper/db_helper.dart';
import 'package:financial_project/feature/balance/data/mapper/balance_client_mapper.dart';
import 'package:financial_project/feature/balance/data/mapper/balance_sheet_mapper.dart';
import 'package:financial_project/feature/balance/data/model/balance_asset_model.dart';
import 'package:financial_project/feature/balance/data/model/balance_client_model.dart';
import 'package:financial_project/feature/balance/data/model/balance_equity_model.dart';
import 'package:financial_project/feature/balance/data/model/balance_liability_model.dart';
import 'package:financial_project/feature/balance/data/model/balance_sheet_model.dart';
import 'package:financial_project/feature/balance/domain/model/balance_client.dart';
import 'package:financial_project/feature/balance/domain/model/balance_resume_entity.dart';
import 'package:financial_project/feature/balance/domain/model/balance_sheet.dart';
import 'package:financial_project/feature/balance/domain/model/balance_sheets_client.dart';
import 'package:financial_project/feature/balance/domain/repo/balance_sheet_repo.dart';

class BalanceSheetRepoImpl implements BalanceSheetRepo {
  @override
  Future<Response<BalanceSheet>> addBalance(BalanceSheet balance) async {
    final db = await DatabaseHelper().database;
    final balanceModel = BalanceSheetMapper.toModel(balance);

    try {
      final id = await db.insert('balance_sheets', balanceModel.toMap());
      if (id <= 0) {
        return Response.error('No se pudo registrar el balance');
      }
      return Response.success(
        BalanceSheetMapper.toEntity(balanceModel.copyWith(id: id)),
        message: 'Balance registrado',
      );
    } catch (e) {
      return Response.error(e.toString());
    }
  }

  @override
  Future<Response<List<BalanceSheet>>> getAllBalances() async {
    final db = await DatabaseHelper().database;

    try {
      final List<Map<String, dynamic>> maps = await db.query(
        'balance_sheets',
        orderBy: 'updated_at DESC',
      );
      if (maps.isEmpty) {
        return Response.success([], message: 'No se encontraron balances');
      }
      return Response.success(
        maps
            .map(
              (map) =>
                  BalanceSheetMapper.toEntity(BalanceSheetModel.fromMap(map)),
            )
            .toList(),
        message: 'Balances encontrados',
      );
    } catch (e) {
      return Response.error(e.toString());
    }
  }

  @override
  Future<Response<List<BalanceClient>>> getClientByName(String name) async {
    final db = await DatabaseHelper().database;

    try {
      final clientsModel = await db.query(
        'clients',
        where: 'business_name LIKE ?',
        whereArgs: ['%$name%'],
      );
      if (clientsModel.isEmpty) {
        return Response.success([], message: 'No se encontró el cliente');
      }
      return Response.success(
        clientsModel
            .map(
              (map) =>
                  BalanceClientMapper.toEntity(BalanceClientModel.fromMap(map)),
            )
            .toList(),
        message: 'Clientes encontrados',
      );
    } catch (e) {
      return Response.error(e.toString());
    }
  }

  @override
  Future<Response<List<BalanceSheetsClient>>> getClientBalanceSheets() async {
    final db = await DatabaseHelper().database;
    List<BalanceSheetsClient> balanceSheetsClient = [];

    try {
      final resBalanceSheet = await db.query(
        'balance_sheets',
        orderBy: 'created_at DESC',
      );
      if (resBalanceSheet.isEmpty) {
        return Response.success([], message: 'No se encontraron balances');
      }
      final balanceSheets = resBalanceSheet
          .map(
            (map) =>
                BalanceSheetMapper.toEntity(BalanceSheetModel.fromMap(map)),
          )
          .toList();

      for (var balance in balanceSheets) {
        final resBalanceClient = await db.query(
          'clients',
          where: 'id = ?',
          whereArgs: [balance.clientId],
        );
        if (resBalanceClient.isEmpty) {
          continue;
        }
        final clientFound = BalanceClientMapper.toEntity(
          BalanceClientModel.fromMap(resBalanceClient.first),
        );
        balanceSheetsClient.add(
          BalanceSheetsClient(
            balanceSheet: balance,
            balanceClient: clientFound,
          ),
        );
      }
      return Response.success(
        balanceSheetsClient,
        message: 'Balances encontrados',
      );
    } catch (e) {
      return Response.error(e.toString());
    }
  }

  @override
  Future<Response<List<BalanceSheetsClient>>> findBalanceSheetByClient(
    String clientName,
  ) async {
    final db = await DatabaseHelper().database;
    List<BalanceSheetsClient> balanceSheetsClient = [];
    try {
      final clientRes = await db.query(
        'clients',
        where: 'business_name LIKE ?',
        whereArgs: ['%$clientName%'],
      );
      if (clientRes.isEmpty) {
        return Response.success([], message: 'No se encontró el cliente');
      }
      final clientFound = BalanceClientMapper.toEntity(
        BalanceClientModel.fromMap(clientRes.first),
      );
      final resBalanceSheet = await db.query(
        'balance_sheets',
        where: 'client_id = ?',
        whereArgs: [clientFound.id],
        orderBy: 'created_at DESC',
      );
      if (resBalanceSheet.isEmpty) {
        return Response.success([], message: 'No se encontraron balances');
      }
      final balanceSheets = resBalanceSheet
          .map(
            (map) =>
                BalanceSheetMapper.toEntity(BalanceSheetModel.fromMap(map)),
          )
          .toList();
      for (var balance in balanceSheets) {
        final resBalanceClient = await db.query(
          'clients',
          where: 'id = ?',
          whereArgs: [balance.clientId],
        );
        if (resBalanceClient.isEmpty) {
          continue;
        }
        final clientFound = BalanceClientMapper.toEntity(
          BalanceClientModel.fromMap(resBalanceClient.first),
        );
        balanceSheetsClient.add(
          BalanceSheetsClient(
            balanceSheet: balance,
            balanceClient: clientFound,
          ),
        );
      }
      return Response.success(
        balanceSheetsClient,
        message: 'Balances encontrados',
      );
    } catch (e) {
      return Response.error(e.toString());
    }
  }

  @override
  Future<Response<BalanceResumeEntity>> getBalanceResume(int balanceId) async {
    final db = await DatabaseHelper().database;

    try {
      final assetsRes = await db.query(
        'assets',
        where: 'balance_sheet_id = ?',
        whereArgs: [balanceId],
      );
      final liabilitiesRes = await db.query(
        'liabilities',
        where: 'balance_sheet_id = ?',
        whereArgs: [balanceId],
      );
      final equityRes = await db.query(
        'equity',
        where: 'balance_sheet_id = ?',
        whereArgs: [balanceId],
      );
      if (assetsRes.isEmpty && liabilitiesRes.isEmpty && equityRes.isEmpty) {
        return Response.error('No existen cuentas registradas');
      }
      final assetsModel = assetsRes
          .map((asset) => BalanceAssetModel.fromMap(asset))
          .toList();
      final liabilitiesModel = liabilitiesRes
          .map((liability) => BalanceLiabilityModel.fromMap(liability))
          .toList();
      final equitiesModel = equityRes
          .map((equity) => BalanceEquityModel.fromMap(equity))
          .toList();
      final totalAssets = assetsModel.fold(
        0.0,
        (sum, element) => sum + element.amount,
      );
      final totalLiabilities = liabilitiesModel.fold(
        0.0,
        (sum, element) => sum + element.amount,
      );
      final totalequities = equitiesModel.fold(
        0.0,
        (sum, element) => sum + element.amount,
      );
      return Response.success(
        BalanceResumeEntity(
          totalAssets: totalAssets,
          totalLiabilities: totalLiabilities,
          totalEquity: totalequities,
        ),
      );
    } catch (e) {
      return Response.error(e.toString());
    }
  }
}
