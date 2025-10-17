import 'package:financial_project/core/app_routes.dart';
import 'package:financial_project/core/global_widgets.dart';
import 'package:financial_project/core/utils.dart';
import 'package:financial_project/feature/user_managment/domain/model/user_regis.dart';
import 'package:financial_project/feature/user_managment/presentation/provider/user_list_provider.dart';
import 'package:financial_project/feature/user_managment/presentation/widgets/user_card.dart';
import 'package:financial_project/feature/user_managment/presentation/widgets/user_update_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class UserHomePage extends StatelessWidget {
  const UserHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<UserListProvider>(
      context,
      listen: false,
    ).setUsersListResponse();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Usuarios',
          style: TextStyle(fontSize: 18.3.sp, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              if (Utils.hasUserManagePermission()) {
                Navigator.pushNamed(context, AppRoutes.userRegistration);
              } else {
                _showMessage(context);
              }
            },
          ),
        ],
      ),
      drawer: GlobalWidgets.customDrawer(context),
      body: Column(
        children: [
          Expanded(
            child: Consumer<UserListProvider>(
              builder: (context, provider, child) {
                final usersRes = provider.usersListResponse;
                if (!usersRes.success) {
                  return Center(
                    child: Text(
                      usersRes.message,
                      style: TextStyle(fontSize: 17.75.sp, color: Colors.grey),
                    ),
                  );
                }
                final users = usersRes.data!;
                if (users.isEmpty) {
                  return Center(
                    child: Text(
                      'No hay usuarios',
                      style: TextStyle(fontSize: 17.75.sp, color: Colors.grey),
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return GestureDetector(
                      child: UserCard(user: user),
                      onTap: () {
                        if (Utils.hasUserManagePermission()) {
                          _showUserUpdateBottomSheet(context, user);
                        } else {
                          _showMessage(context);
                        }
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showUserUpdateBottomSheet(BuildContext context, UserRegis user) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => UserUpdateBottomSheet(user: user),
    );
  }

  void _showMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      GlobalWidgets.customSnackBar(
        'No tienes permisos para realizar esta acción',
        Colors.redAccent,
      ),
    );
  }
}
