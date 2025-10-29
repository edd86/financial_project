import 'package:financial_project/core/response.dart';
import 'package:financial_project/feature/service_managment/domain/model/service_entity.dart';

abstract class SeviceRepo {
  Future<Response<List<ServiceEntity>>> getServices();
  Future<Response<ServiceEntity>> updateService(ServiceEntity service);
  Future<Response<ServiceEntity>> findServiceByName(String name);
}
