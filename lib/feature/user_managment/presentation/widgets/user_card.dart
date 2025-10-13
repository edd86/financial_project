import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class UserCard extends StatelessWidget {
  const UserCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        width: double.infinity,
        height: 20.h,
        child: Column(mainAxisSize: MainAxisSize.min, children: []),
      ),
    );
  }
}
