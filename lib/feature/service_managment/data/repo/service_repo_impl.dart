import 'package:financial_project/core/response.dart';
import 'package:financial_project/db/helper/db_helper.dart';
import 'package:financial_project/feature/service_managment/data/mapper/service_mapper.dart';
import 'package:financial_project/feature/service_managment/data/model/service_model.dart';
import 'package:financial_project/feature/service_managment/domain/model/service_entity.dart';
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
}
