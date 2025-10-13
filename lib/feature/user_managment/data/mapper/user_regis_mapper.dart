import 'package:financial_project/feature/user_managment/data/model/user_regis_model.dart';
import 'package:financial_project/feature/user_managment/domain/model/user_regis.dart';

class UserRegisMapper {
  static UserRegisModel toModel(UserRegis entity) {
    return UserRegisModel(
      name: entity.name,
      userName: entity.userName,
      email: entity.email,
      phone: entity.phone,
      password: entity.password,
    );
  }

  static UserRegis toEntity(UserRegisModel model) {
    return UserRegis(
      name: model.name,
      userName: model.userName,
      email: model.email,
      phone: model.phone,
      password: model.password,
    );
  }
}
