import 'dart:io';

import 'package:financial_project/core/drawer_nav.dart';
import 'package:financial_project/core/utils.dart';
import 'package:financial_project/feature/auth/presentation/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class GlobalWidgets {
  static Widget customLabelWidget(IconData icon, String message) => Row(
    children: [
      Icon(icon, size: 17.5.sp, color: Colors.deepPurple),
      SizedBox(width: 8),
      Text(message, style: TextStyle(fontSize: 13.75.sp)),
    ],
  );

  static SnackBar customSnackBar(String message, Color color) =>
      SnackBar(content: Text(message), backgroundColor: color);

  static Drawer customDrawer(BuildContext context) => Drawer(
    width: 50.w,
    child: Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: DrawerHeader(
            decoration: BoxDecoration(color: Colors.deepPurple),
            child: Column(
              children: [
                Text(
                  'Menu',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: Device.height >= 700 ? 16.75.sp : 14.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 1.35.h),
                CircleAvatar(
                  backgroundImage: AssetImage('assets/img/profile.png'),
                  radius: 20.sp,
                ),
                SizedBox(height: 1.35.h),
                Text(
                  context.watch<AuthProvider>().username,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: Device.height >= 700 ? 14.75.sp : 12.75,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: drawerElements.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Icon(
                  drawerElements[index].icon,
                  size: 18.77.sp,
                  color: Colors.deepPurple,
                ),
                title: Text(
                  drawerElements[index].title,
                  style: TextStyle(
                    fontSize: 15.85.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  drawerElements[index].description,
                  style: TextStyle(fontSize: 13.45.sp),
                ),
                trailing: Icon(Icons.arrow_forward_ios, size: 16.57.sp),
                onTap: () {
                  Navigator.pushNamed(context, drawerElements[index].route);
                },
              );
            },
          ),
        ),
        Container(
          width: double.infinity,
          height: 5.6.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(16)),
            color: Colors.deepPurple,
          ),
          child: TextButton.icon(
            icon: Icon(Icons.logout, size: 18.77.sp, color: Colors.white),
            label: Text(
              'Cerrar sesión y salir',
              style: TextStyle(
                fontSize: 15.85.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            onPressed: () {
              userLogedPermissions.clear();
              exit(0);
            },
          ),
        ),
      ],
    ),
  );
}
