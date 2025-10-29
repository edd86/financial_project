import 'package:financial_project/feature/service_managment/data/model/service_model.dart';
import 'package:financial_project/feature/service_managment/domain/model/service_entity.dart';

class ServiceMapper {
  static ServiceModel toModel(ServiceEntity entity) =>
      ServiceModel(name: entity.name, amount: entity.amount);

  static ServiceEntity toEntity(ServiceModel model) =>
      ServiceEntity(name: model.name, amount: model.amount);
}
