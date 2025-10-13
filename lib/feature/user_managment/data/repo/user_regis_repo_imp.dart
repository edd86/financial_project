import 'package:financial_project/core/response.dart';
import 'package:financial_project/core/utils.dart';
import 'package:financial_project/db/helper/db_helper.dart';
import 'package:financial_project/feature/user_managment/data/mapper/user_regis_mapper.dart';
import 'package:financial_project/feature/user_managment/data/mapper/user_regis_permission_mapper.dart';
import 'package:financial_project/feature/user_managment/data/model/user_permission_regis_model.dart';
import 'package:financial_project/feature/user_managment/data/model/user_regis_permission_model.dart';
import 'package:financial_project/feature/user_managment/domain/model/user_regis.dart';
import 'package:financial_project/feature/user_managment/domain/model/user_regis_permission.dart';
import 'package:financial_project/feature/user_managment/domain/repo/user_regis_repo.dart';

class UserRegisRepoImp implements UserRegisRepo {
  @override
  Future<Response<UserRegis>> registerUser(
    UserRegis user,
    List<UserRegisPermission> permissions,
  ) async {
    final db = await DatabaseHelper().database;
    final newUser = UserRegisMapper.toModel(user);
    try {
      final resUser = await db.insert(
        'users',
        newUser.copyWith(password: Utils.hashPassword(user.password)).toMap(),
      );
      if (resUser > 0) {
        final resPermission = await registerPermissionsUser(
          resUser,
          permissions,
        );
        if (resPermission) {
          return Response.success(
            user,
            message: 'Usuario y permisos registrados con éxito',
          );
        } else {
          return Response.error('Error al registrar los permisos del usuario');
        }
      } else {
        return Response.error('Error al registrar el usuario');
      }
    } catch (e) {
      return Response.error(e.toString());
    }
  }

  @override
  Future<Response<List<UserRegisPermission>>> getPermissions() async {
    final db = await DatabaseHelper().database;

    try {
      final res = await db.query('permissions');
      if (res.isNotEmpty) {
        final permissions = res
            .map(
              (permission) => UserRegisPermissionMapper.toEntity(
                UserRegisPermissionModel.fromMap(permission),
              ),
            )
            .toList();
        return Response.success(permissions, message: 'Permisos Encontrados');
      }
      return Response.success(
        List<UserRegisPermission>.empty(),
        message: 'No existen permisos registrados',
      );
    } catch (e) {
      return Response.error(e.toString());
    }
  }

  @override
  Future<bool> registerPermissionsUser(
    int userId,
    List<UserRegisPermission> permissions,
  ) async {
    int countPermissionRegistered = 0;
    final db = await DatabaseHelper().database;

    try {
      for (var permission in permissions) {
        final res = await db.insert(
          'user_permissions',
          UserPermissionRegisModel(
            userId: userId,
            permissionId: permission.id,
          ).toMap(),
        );
        if (res > 0) {
          countPermissionRegistered++;
        }
      }
      if (countPermissionRegistered == permissions.length) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
