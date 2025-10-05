import 'package:financial_project/feature/auth/data/model/user_auth_model.dart';
import 'package:financial_project/feature/auth/domain/model/user_auth.dart';

class UserAuthMapper {
  static UserAuth toEntity(UserAuthModel model) {
    return UserAuth(
      id: model.id,
      username: model.username,
      password: model.password,
    );
  }

  static UserAuthModel toModel(UserAuth entity) {
    return UserAuthModel(
      id: entity.id,
      username: entity.username,
      password: entity.password,
    );
  }
}
