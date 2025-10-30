import 'package:financial_project/core/response.dart';
import 'package:financial_project/feature/service_managment/domain/model/service_entity.dart';
import 'package:financial_project/feature/service_managment/domain/model/service_log_client_entity.dart';
import 'package:financial_project/feature/service_managment/domain/model/service_log_entity.dart';

abstract class SeviceRepo {
  Future<Response<List<ServiceEntity>>> getServices();
  Future<Response<ServiceEntity>> updateService(ServiceEntity service);
  Future<Response<ServiceEntity>> findServiceByName(String name);
  Future<Response<List<ServiceLogClientEntity>>> getServicesLog();
  Future<Response<ServiceLogEntity>> updateServiceLogPayed(
    ServiceLogEntity serviceLog,
  );
  Future<Response<ServiceLogEntity>> addServiceLog(
    int clientId,
    String serviceName,
  );
}
