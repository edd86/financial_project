import 'package:financial_project/core/response.dart';
import 'package:financial_project/core/utils.dart';
import 'package:financial_project/db/helper/db_helper.dart';
import 'package:financial_project/feature/client_managment/data/mapper/client_mapper.dart';
import 'package:financial_project/feature/client_managment/data/mapper/client_monthly_record_mapper.dart';
import 'package:financial_project/feature/client_managment/data/mapper/client_obligation_mapper.dart';
import 'package:financial_project/feature/client_managment/data/mapper/client_simplified_regime_mapper.dart';
import 'package:financial_project/feature/client_managment/data/model/client_general_regime_model.dart';
import 'package:financial_project/feature/client_managment/data/model/client_model.dart';
import 'package:financial_project/feature/client_managment/data/model/client_obligation_model.dart';
import 'package:financial_project/feature/client_managment/data/model/client_simplified_regime_model.dart';
import 'package:financial_project/feature/client_managment/domain/model/client.dart';
import 'package:financial_project/feature/client_managment/domain/model/client_monthly_record.dart';
import 'package:financial_project/feature/client_managment/domain/model/client_obligation.dart';
import 'package:financial_project/feature/client_managment/domain/model/client_simplified_regime.dart';
import 'package:financial_project/feature/client_managment/domain/model/clients_home_entity.dart';
import 'package:financial_project/feature/client_managment/domain/repo/client_repo.dart';

class ClientRepoImpl implements ClientRepo {
  @override
  Future<Response<Client>> addClient(Client client) async {
    final db = await DatabaseHelper().database;
    try {
      final clientModel = ClientMapper.toModel(client);
      final id = await db.insert(
        'clients',
        clientModel
            .copyWith(
              createdAt: DateTime.now().toIso8601String(),
              updatedAt: DateTime.now().toIso8601String(),
            )
            .toMap(),
      );
      if (id <= 0) {
        return Response.error('Error adding client');
      }
      return Response.success(
        ClientMapper.toEntity(clientModel.copyWith(id: id)),
        message: 'Cliente registrado con éxito',
      );
    } catch (e) {
      return Response.error('Error adding client: $e');
    }
  }

  @override
  Future<Response<ClientsHomeEntity>> getClientsHome() async {
    final db = await DatabaseHelper().database;
    try {
      final newClientsResponse = await db.query(
        'clients',
        orderBy: 'created_at DESC',
        limit: 10,
      );
      final simplifiedClientsResponse = await db.query(
        'clients',
        where: 'regime_type = ?',
        whereArgs: ['simplificado'],
        orderBy: 'created_at DESC',
        limit: 10,
      );
      final generalClientsResponse = await db.query(
        'clients',
        where: 'regime_type = ?',
        whereArgs: ['general'],
        orderBy: 'created_at DESC',
        limit: 10,
      );
      final simplifiedClients = simplifiedClientsResponse
          .map((e) => ClientMapper.toEntity(ClientModel.fromMap(e)))
          .toList();
      final generalClients = generalClientsResponse
          .map((e) => ClientMapper.toEntity(ClientModel.fromMap(e)))
          .toList();
      final newClients = newClientsResponse
          .map((e) => ClientMapper.toEntity(ClientModel.fromMap(e)))
          .toList();
      return Response.success(
        ClientsHomeEntity(
          newClients: newClients,
          simplifiedClients: simplifiedClients,
          generalClients: generalClients,
        ),
      );
    } catch (e) {
      return Response.error('Error getting clients home: $e');
    }
  }

  @override
  Future<Response<List<Client>>> searchClients(String nameNit) async {
    final db = await DatabaseHelper().database;

    try {
      final results = await db.query(
        'clients',
        where: 'business_name LIKE ? OR tax_id LIKE ?',
        whereArgs: ['%$nameNit%', '%$nameNit%'],
      );
      return Response.success(
        results
            .map((e) => ClientMapper.toEntity(ClientModel.fromMap(e)))
            .toList(),
      );
    } catch (e) {
      return Response.error('Error searching clients: $e');
    }
  }

  @override
  Future<Response<List<ClientObligation>>> getClientObligations(
    int clientId,
  ) async {
    final db = await DatabaseHelper().database;

    try {
      final results = await db.query(
        'client_obligations',
        where: 'client_id = ?',
        whereArgs: [clientId],
        orderBy: 'created_at DESC',
      );
      if (results.isEmpty) {
        return Response.error(
          'No se encontraron obligaciones para este cliente',
        );
      }
      return Response.success(
        results
            .map(
              (e) => ClientObligationMapper.toEntity(
                ClientObligationModel.fromMap(e),
              ),
            )
            .toList(),
      );
    } catch (e) {
      return Response.error('Error getting client obligations: $e');
    }
  }

  @override
  Future<Response<ClientObligation>> assignClientSimpleObligation(
    Client client,
  ) async {
    final db = await DatabaseHelper().database;
    DateTime now = DateTime.now();

    try {
      final simplifiedRegimeRes = await getClientSimplifiedRegime(
        client.capital,
      );
      if (simplifiedRegimeRes.success) {
        final simplifiedRegime = simplifiedRegimeRes.data!;
        final listDays = simplifiedRegime.duePattern;
        final dueDate = listDays.firstWhere((date) => now.isBefore(date));
        final startDate = dueDate.subtract(const Duration(days: 60));
        final endDate = dueDate.subtract(const Duration(days: 10));

        final clientObligation = ClientObligationModel(
          clientId: client.id!,
          obligationType: client.regimeType == 'simplificado'
              ? ObligationType.simplificado
              : ObligationType.general,
          simplifiedId: simplifiedRegime.id!,
          paymentAmount: simplifiedRegime.amount,
          dueDate: dueDate,
          status: ObligationStatus.pendiente,
          periodStart: startDate,
          periodEnd: endDate,
        );
        final id = await db.insert(
          'client_obligations',
          clientObligation.toMap(),
        );
        if (id <= 0) {
          return Response.error('Error adding client obligation');
        }
        return Response.success(
          ClientObligationMapper.toEntity(clientObligation),
          message: 'Obligación asignada con éxito',
        );
      } else {
        return Response.error(
          'Error asignando obligación: ${simplifiedRegimeRes.message}',
        );
      }
    } catch (e) {
      return Response.error(e.toString());
    }
  }

  @override
  Future<Response<ClientSimplifiedRegime>> getClientSimplifiedRegime(
    double capital,
  ) async {
    final db = await DatabaseHelper().database;

    try {
      final resSimplified = await db.query(
        'simplified_regime',
        where: '? BETWEEN min_capital AND max_capital',
        whereArgs: [capital],
      );
      if (resSimplified.isEmpty) {
        return Response.error(
          'No se encontró un régimen simplificado para el capital del cliente',
        );
      }
      final regimeModel = ClientSimplifiedRegimeModel.fromMap(
        resSimplified.first,
      );
      return Response.success(
        ClientSimplifiedRegimeMapper.toEntity(regimeModel),
      );
    } catch (e) {
      return Response.error(e.toString());
    }
  }

  @override
  Future<Response<bool>> updatePayedObligation(
    ClientObligation clientObligation,
  ) async {
    final db = await DatabaseHelper().database;
    final clientObligationModel = ClientObligationMapper.toModel(
      clientObligation,
    );
    final updatedClientObligation = clientObligationModel
        .copyWith(status: ObligationStatus.cumplido, updatedAt: DateTime.now())
        .toMap();

    try {
      final response = await db.update(
        'client_obligations',
        updatedClientObligation,
      );
      if (response <= 0) {
        return Response.error('No se pudo actualizar la obligación');
      }
      return Response.success(true, message: 'Obligación actualizada');
    } catch (e) {
      return Response.error(e.toString());
    }
  }

  @override
  Future<Response<List<ClientObligation>>> assignClientGeneralObligation(
    ClientMonthlyRecord clientRecord,
  ) async {
    final db = await DatabaseHelper().database;
    final now = DateTime.now();
    List<ClientObligationModel> clientObligations = [];

    final resRegimes = await db.query('general_regime');
    if (resRegimes.isEmpty) {
      return Response.error('No existen regimenes registrados.');
    }
    final regimesModel = resRegimes
        .map((regimeRes) => ClientGeneralRegime.fromMap(regimeRes))
        .toList();
    for (var regime in regimesModel) {
      switch (regime.name) {
        case 'IVA':
          double amountSales = clientRecord.netSales! * regime.percentage / 100;
          double amountPurchases =
              clientRecord.netPurchases! * regime.percentage / 100;
          final dueDate = regime.duePatterns.firstWhere(
            (date) => now.isBefore(date),
            orElse: () =>
                regime.duePatterns.first.add(const Duration(days: 30)),
          );
          final clientObligationSales = ClientObligationModel(
            clientId: clientRecord.clientId,
            monthlyRecordId: clientRecord.id,
            obligationType: ObligationType.general,
            generalId: regime.id!,
            paymentAmount: amountSales,
            dueDate: dueDate,
            status: ObligationStatus.pendiente,
            periodStart: DateTime(
              now.year,
              Utils.monthStringToInt(clientRecord.recordMonth),
              1,
            ),
            periodEnd: DateTime(
              now.year,
              Utils.monthStringToInt(clientRecord.recordMonth),
              regime.duePatterns[0].subtract(const Duration(days: 13)).day,
            ),
          );
          final clientObligationPurchase = ClientObligationModel(
            clientId: clientRecord.clientId,
            monthlyRecordId: clientRecord.id,
            obligationType: ObligationType.general,
            generalId: regime.id!,
            paymentAmount: amountPurchases,
            dueDate: dueDate,
            status: ObligationStatus.pendiente,
            periodStart: DateTime(
              now.year,
              Utils.monthStringToInt(clientRecord.recordMonth),
              1,
            ),
            periodEnd: DateTime(
              now.year,
              Utils.monthStringToInt(clientRecord.recordMonth),
              regime.duePatterns[0].subtract(const Duration(days: 13)).day,
            ),
          );
          final resSales = await db.insert(
            'client_obligations',
            clientObligationSales.toMap(),
          );
          final resPurchase = await db.insert(
            'client_obligations',
            clientObligationPurchase.toMap(),
          );
          if (resSales <= 0 || resPurchase <= 0) {
            return Response.error('No se pudo guardar la obligación');
          }
          clientObligations.add(clientObligationSales);
          clientObligations.add(clientObligationPurchase);
          break;
        case 'IT':
          double amountIT = clientRecord.netSales! * regime.percentage / 100;
          final dueDate = regime.duePatterns.firstWhere(
            (date) => now.isBefore(date),
            orElse: () =>
                regime.duePatterns.first.add(const Duration(days: 30)),
          );
          final clientObligationIT = ClientObligationModel(
            clientId: clientRecord.clientId,
            monthlyRecordId: clientRecord.id,
            obligationType: ObligationType.general,
            generalId: regime.id!,
            paymentAmount: amountIT,
            dueDate: dueDate,
            status: ObligationStatus.pendiente,
            periodStart: DateTime(
              now.year,
              Utils.monthStringToInt(clientRecord.recordMonth),
              1,
            ),
            periodEnd: DateTime(
              now.year,
              Utils.monthStringToInt(clientRecord.recordMonth),
              regime.duePatterns[0].subtract(const Duration(days: 13)).day,
            ),
          );
          final resIT = await db.insert(
            'client_obligations',
            clientObligationIT.toMap(),
          );
          if (resIT <= 0) {
            return Response.error('No se pudo guardar la obligación');
          }
          clientObligations.add(clientObligationIT);
          break;
        case 'IUE':
          double amountIUE =
              (clientRecord.netSales! - clientRecord.netPurchases!) *
              regime.percentage /
              100;
          final dueDate = regime.duePatterns.firstWhere(
            (date) => now.isBefore(date),
            orElse: () =>
                regime.duePatterns.first.add(const Duration(days: 30)),
          );
          final clientObligationIUE = ClientObligationModel(
            clientId: clientRecord.clientId,
            monthlyRecordId: clientRecord.id,
            obligationType: ObligationType.general,
            generalId: regime.id!,
            paymentAmount: amountIUE,
            dueDate: dueDate,
            status: ObligationStatus.pendiente,
            periodStart: DateTime(
              now.year,
              Utils.monthStringToInt(clientRecord.recordMonth),
              1,
            ),
            periodEnd: DateTime(
              now.year,
              Utils.monthStringToInt(clientRecord.recordMonth),
              regime.duePatterns[0].subtract(const Duration(days: 13)).day,
            ),
          );
          final resIUE = await db.insert(
            'client_obligations',
            clientObligationIUE.toMap(),
          );
          if (resIUE <= 0) {
            return Response.error('No se pudo guardar la obligación');
          }
          clientObligations.add(clientObligationIUE);
          break;
        default:
          return Response.error('Regimen no encontrado');
      }
    }
    return Response.success(
      clientObligations
          .map(
            (obligationModel) =>
                ClientObligationMapper.toEntity(obligationModel),
          )
          .toList(),
      message: 'Obligaciones guardadas',
    );
  }

  @override
  Future<Response<ClientMonthlyRecord>> addClientMonthlyRecord(
    ClientMonthlyRecord clientRecord,
  ) async {
    final db = await DatabaseHelper().database;
    final clientRecordModel = ClientMonthlyRecordMapper.toModel(clientRecord);

    try {
      final existRecordResponse = await exitsRecord(
        clientRecord.recordMonth,
        clientRecord.recordYear,
      );
      if (existRecordResponse.data != null) {
        if (!existRecordResponse.data!) {
          final newClientRecord = clientRecordModel.copyWith(
            netPurchases:
                clientRecordModel.totalPurchases -
                clientRecordModel.purchaseDiscount,
            netSales:
                clientRecordModel.grossSales - clientRecordModel.salesDiscount,
          );
          final response = await db.insert(
            'monthly_business_records',
            newClientRecord.toMap(),
          );
          return Response.success(
            ClientMonthlyRecordMapper.toEntity(
              newClientRecord.copyWith(id: response),
            ),
            message: 'Registro mensual guardado',
          );
        } else {
          return Response.error('Registro ya existente');
        }
      } else {
        return Response.error(existRecordResponse.message);
      }
    } catch (e) {
      return Response.error(e.toString());
    }
  }

  @override
  Future<Response<bool>> exitsRecord(String month, int year) async {
    final db = await DatabaseHelper().database;

    try {
      final response = await db.query(
        'monthly_business_records',
        where: 'record_month = ? AND record_year = ?',
        whereArgs: [month, year],
      );
      if (response.isEmpty) {
        return Response.success(false);
      }
      return Response.success(true);
    } catch (e) {
      return Response.error(e.toString());
    }
  }
}
