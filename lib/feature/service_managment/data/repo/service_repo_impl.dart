import 'package:financial_project/core/response.dart';
import 'package:financial_project/db/helper/db_helper.dart';
import 'package:financial_project/feature/client_managment/data/mapper/client_mapper.dart';
import 'package:financial_project/feature/client_managment/data/model/client_model.dart';
import 'package:financial_project/feature/service_managment/data/mapper/service_log_mapper.dart';
import 'package:financial_project/feature/service_managment/data/mapper/service_mapper.dart';
import 'package:financial_project/feature/service_managment/data/model/service_log_model.dart';
import 'package:financial_project/feature/service_managment/data/model/service_model.dart';
import 'package:financial_project/feature/service_managment/domain/model/service_entity.dart';
import 'package:financial_project/feature/service_managment/domain/model/service_log_client_entity.dart';
import 'package:financial_project/feature/service_managment/domain/model/service_log_entity.dart';
import 'package:financial_project/feature/service_managment/domain/repo/sevice_repo.dart';

class ServiceRepoImpl implements SeviceRepo {
  @override
  Future<Response<List<ServiceEntity>>> getServices() async {
    final db = await DatabaseHelper().database;

    try {
      final res = await db.query('services');

      if (res.isEmpty) {
        return Response.success(
          [],
          message: 'No existen servicios registrados',
        );
      }
      return Response.success(
        res
            .map((map) => ServiceMapper.toEntity(ServiceModel.fromMap(map)))
            .toList(),
      );
    } catch (e) {
      return Response.error(e.toString());
    }
  }

  @override
  Future<Response<ServiceEntity>> updateService(ServiceEntity service) async {
    final db = await DatabaseHelper().database;
    final serviceModel = ServiceMapper.toModel(service);

    try {
      final res = await db.update(
        'services',
        serviceModel.toMap(),
        where: 'id = ?',
        whereArgs: [service.id],
      );
      if (res > 0) {
        return Response.success(service, message: 'Servicio actualizado');
      }
      return Response.error('Error al actualizar servicio');
    } catch (e) {
      return Response.error(e.toString());
    }
  }

  @override
  Future<Response<ServiceEntity>> findServiceByName(String name) async {
    final db = await DatabaseHelper().database;

    try {
      final res = await db.query(
        'services',
        where: 'name = ?',
        whereArgs: [name.toLowerCase()],
      );

      if (res.isEmpty) {
        return Response.error('Servicio no encontrado');
      }
      return Response.success(
        ServiceMapper.toEntity(ServiceModel.fromMap(res.first)),
      );
    } catch (e) {
      return Response.error(e.toString());
    }
  }

  @override
  Future<Response<List<ServiceLogClientEntity>>> getServicesLog() async {
    final db = await DatabaseHelper().database;
    List<ServiceLogClientEntity> resServiceLogClients = [];

    try {
      final resServiceLog = await db.query('service_log', orderBy: 'date DESC');
      if (resServiceLog.isEmpty) {
        return Response.success([], message: 'No existen registros');
      }
      final serviceLogTmp = resServiceLog
          .map((serviceMap) => ServiceLogModel.fromMap(serviceMap))
          .toList();
      for (var serviceLog in serviceLogTmp) {
        final resClient = await db.query(
          'clients',
          where: 'id = ?',
          whereArgs: [serviceLog.clientId],
        );
        final resService = await db.query(
          'services',
          where: 'id = ?',
          whereArgs: [serviceLog.serviceId],
        );
        if (resClient.isEmpty) {
          return Response.error('Cliente no encontrado');
        }
        if (resService.isEmpty) {
          return Response.error('Servicio no encontrado');
        }
        final client = ClientMapper.toEntity(
          ClientModel.fromMap(resClient.first),
        );
        final service = ServiceModel.fromMap(resService.first);
        final serviceLogClientEntity = ServiceLogClientEntity(
          serviceLog: ServiceLogMapper.toEntity(serviceLog),
          clientName: client.businessName,
          serviceName: service.name,
        );
        resServiceLogClients.add(serviceLogClientEntity);
      }
      return Response.success(resServiceLogClients);
    } catch (e) {
      return Response.error(e.toString());
    }
  }

  @override
  Future<Response<ServiceLogEntity>> updateServiceLogPayed(
    ServiceLogEntity serviceLog,
  ) async {
    final db = await DatabaseHelper().database;
    final serviceLogModel = ServiceLogMapper.toModel(serviceLog);

    try {
      final serviceToUpdate = serviceLogModel.copyWith(
        datePayed: DateTime.now(),
        isPayed: true,
      );
      final res = await db.update(
        'service_log',
        serviceToUpdate.toMap(),
        where: 'id = ?',
        whereArgs: [serviceToUpdate.id],
      );
      if (res > 0) {
        return Response.success(serviceLog, message: 'Registro actualizado');
      }
      return Response.error('Error al actualizar registro');
    } catch (e) {
      return Response.error(e.toString());
    }
  }

  @override
  Future<Response<ServiceLogEntity>> addServiceLog(
    int clientId,
    String serviceName,
  ) async {
    final db = await DatabaseHelper().database;

    try {
      final serviceRes = await findServiceByName(serviceName);
      if (!serviceRes.success) {
        return Response.error(serviceRes.message);
      }
      final service = serviceRes.data!;
      final serviceLogModel = ServiceLogModel(
        clientId: clientId,
        serviceId: service.id!,
        date: DateTime.now(),
        amount: service.amount,
      );
      final newServiceLog = serviceLogModel.copyWith(
        serviceId: service.id,
        amount: service.amount,
      );
      final res = await db.insert('service_log', newServiceLog.toMap());
      if (res < 0) {
        return Response.error('Error al agregar registro');
      }
      return Response.success(
        ServiceLogMapper.toEntity(newServiceLog.copyWith(id: res)),
      );
    } catch (e) {
      return Response.error(e.toString());
    }
  }
}
