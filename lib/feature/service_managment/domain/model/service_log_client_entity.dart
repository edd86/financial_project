import 'package:financial_project/feature/service_managment/domain/model/service_log_entity.dart';

class ServiceLogClientEntity {
  final ServiceLogEntity serviceLog;
  final String clientName;
  final String serviceName;

  ServiceLogClientEntity({
    required this.serviceLog,
    required this.clientName,
    required this.serviceName,
  });
}
