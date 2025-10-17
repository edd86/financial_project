import 'package:financial_project/core/response.dart';
import 'package:financial_project/feature/user_managment/domain/model/user_regis.dart';
import 'package:financial_project/feature/user_managment/domain/model/user_regis_permission.dart';

abstract class UserRegisRepo {
  Future<Response<UserRegis>> registerUser(
    UserRegis user,
    List<UserRegisPermission> permissions,
  );
  Future<Response<List<UserRegisPermission>>> getPermissions();
  Future<bool> registerPermissionsUser(
    int userId,
    List<UserRegisPermission> permissions,
  );
  Future<Response<List<UserRegis>>> getUsers();
  Future<Response<UserRegis>> updateUser(UserRegis user);
  Future<Response<bool>> deleteUser(UserRegis user);
}
