import 'package:financial_project/core/response.dart';
import 'package:financial_project/core/utils.dart';
import 'package:financial_project/db/helper/db_helper.dart';
import 'package:financial_project/feature/auth/data/mapper/user_auth_mapper.dart';
import 'package:financial_project/feature/auth/data/model/user_auth_model.dart';
import 'package:financial_project/feature/auth/data/model/user_permission_auth_model.dart';
import 'package:financial_project/feature/auth/domain/model/user_auth.dart';
import 'package:financial_project/feature/auth/domain/repo/auth_repo.dart';

class AuthRepoImp implements AuthRepo {
  @override
  Future<Response<UserAuth>> login(UserAuth userAuth) async {
    final db = await DatabaseHelper().database;

    try {
      final result = await db.query(
        'users',
        where: 'username = ?',
        whereArgs: [userAuth.username],
      );
      if (result.isNotEmpty) {
        final user = UserAuthMapper.toEntity(
          UserAuthModel.fromMap(result.first),
        );
        if (Utils.verifyPassword(userAuth.password, user.password)) {
          final resPermissions = await getUserPermissions(user.id!);
          if (resPermissions.success) {
            userLogedPermissions = resPermissions.data!;
            return Response.success(
              userAuth,
              message: 'Bienvenido ${user.username}.',
            );
          } else {
            return Response.error(resPermissions.message);
          }
        } else {
          return Response.error('Password erróneo');
        }
      } else {
        return Response.error('Usuario no registrado.');
      }
    } catch (e) {
      return Response.error(e.toString());
    }
  }

  @override
  Future<Response<List<UserPermissionAuthModel>>> getUserPermissions(
    int userId,
  ) async {
    final db = await DatabaseHelper().database;

    try {
      final result = await db.rawQuery(
        '''SELECT p.id, p.name
        FROM permissions p
        INNER JOIN user_permissions up ON p.id = up.permission_id
        INNER JOIN users u ON u.id = up.user_id
        WHERE u.id = ?''',
        [userId],
      );

      if (result.isNotEmpty) {
        return Response.success(
          result.map((e) => UserPermissionAuthModel.fromMap(e)).toList(),
          message: 'Permisos cargados correctamente',
        );
      }
      return Response.error('Error al cargar los permisos');
    } catch (e) {
      return Response.error(e.toString());
    }
  }
}
