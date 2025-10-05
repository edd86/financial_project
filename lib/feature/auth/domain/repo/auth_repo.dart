import 'package:financial_project/core/response.dart';
import 'package:financial_project/feature/auth/data/model/user_permission_auth_model.dart';
import 'package:financial_project/feature/auth/domain/model/user_auth.dart';

abstract class AuthRepo {
  Future<Response<UserAuth>> login(UserAuth userAuth);
  Future<Response<List<UserPermissionAuthModel>>> getUserPermissions(
    int userId,
  );
}
