import 'package:financial_project/feature/user_managment/domain/model/user_regis.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class UserCard extends StatelessWidget {
  final UserRegis user;
  const UserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        width: double.infinity,
        height: 15.8.h,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              user.rol,
              style: TextStyle(fontSize: 16.8.sp, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 11.75.h,
                  child: Center(
                    child: Image.asset(
                      'assets/img/profile.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: 48.7.w,
                  height: 11.74.h,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          user.name,
                          style: TextStyle(
                            fontSize: 18.59.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          user.email,
                          style: TextStyle(
                            fontSize: 14.66.sp,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Text(
                          user.phone,
                          style: TextStyle(
                            fontSize: 13.2.sp,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
