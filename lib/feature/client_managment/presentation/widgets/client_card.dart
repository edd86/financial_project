import 'package:financial_project/feature/client_managment/domain/model/client.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ClientCard extends StatelessWidget {
  final Client client;
  ClientCard({super.key, required this.client});

  final widthCard = 100.w / 2.5;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widthCard,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              client.businessName,
              style: TextStyle(fontSize: 13.95.sp, fontWeight: FontWeight.bold),
            ),
            Text(
              client.taxId,
              style: TextStyle(fontSize: 13.8.sp, fontWeight: FontWeight.w500),
            ),
            Text(
              client.regimeType.toUpperCase(),
              style: TextStyle(fontSize: 13.8.sp, fontWeight: FontWeight.w500),
            ),
            client.activity == null
                ? Text('')
                : Text(
                    client.activity!.toUpperCase(),
                    style: TextStyle(
                      fontSize: 13.8.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
