import 'package:financial_project/feature/service_managment/data/model/service_log_model.dart';
import 'package:financial_project/feature/service_managment/domain/model/service_log_entity.dart';

class ServiceLogMapper {
  static ServiceLogModel toModel(ServiceLogEntity entity) => ServiceLogModel(
    clientId: entity.clientId,
    date: entity.date,
    datePayed: entity.datePayed,
    isPayed: entity.isPayed,
    amount: entity.amount,
  );

  static ServiceLogEntity toEntity(ServiceLogModel model) => ServiceLogEntity(
    clientId: model.clientId,
    date: model.date,
    datePayed: model.datePayed,
    isPayed: model.isPayed,
    amount: model.amount,
  );
}
