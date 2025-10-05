import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ClientDetails extends StatelessWidget {
  final String detail, subtitle;
  const ClientDetails({
    super.key,
    required this.detail,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: 44.w,
          child: Text(
            subtitle,
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 14.5.sp, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          width: 44.w,
          child: Text(
            detail,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13.45.sp, fontWeight: FontWeight.normal),
          ),
        ),
      ],
    );
  }
}
