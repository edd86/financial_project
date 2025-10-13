import 'package:financial_project/feature/user_managment/data/model/user_regis_permission_model.dart';
import 'package:financial_project/feature/user_managment/domain/model/user_regis_permission.dart';

class UserRegisPermissionMapper {
  static UserRegisPermission toEntity(UserRegisPermissionModel model) {
    return UserRegisPermission(
      id: model.id,
      name: model.name,
      isActive: model.isActive,
    );
  }

  static UserRegisPermissionModel toModel(UserRegisPermission entity) {
    return UserRegisPermissionModel(id: entity.id, name: entity.name);
  }
}
