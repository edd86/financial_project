import 'package:financial_project/core/response.dart';
import 'package:financial_project/feature/user_managment/data/repo/user_regis_repo_imp.dart';
import 'package:financial_project/feature/user_managment/domain/model/user_regis.dart';
import 'package:flutter/material.dart';

class UserListProvider extends ChangeNotifier {
  Response<List<UserRegis>> _usersListResponse = Response.success([]);

  Response<List<UserRegis>> get usersListResponse => _usersListResponse;

  void setUsersListResponse() async {
    _usersListResponse = await UserRegisRepoImp().getUsers();
    notifyListeners();
  }

  void updateUsers() async {
    _usersListResponse = await UserRegisRepoImp().getUsers();
    notifyListeners();
  }
}
