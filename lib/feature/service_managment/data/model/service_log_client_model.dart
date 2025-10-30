import 'package:financial_project/feature/service_managment/data/model/service_log_model.dart';

class ServiceLogClientModel {
  final ServiceLogModel service;
  final String clientName;
  final String serviceName;

  ServiceLogClientModel({
    required this.service,
    required this.clientName,
    required this.serviceName,
  });
}
