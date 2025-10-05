import 'package:financial_project/feature/client_managment/domain/model/client.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ClientTile extends StatelessWidget {
  final Client client;
  const ClientTile({super.key, required this.client});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        width: double.infinity,
        height: 7.95.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 10.85.w,
              child: Center(
                child: Icon(
                  client.regimeType == 'simplificado'
                      ? Icons.store
                      : Icons.business,
                  color: Colors.deepPurple,
                ),
              ),
            ),
            SizedBox(
              width: 70.85.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    '${client.businessName} - ${client.taxId}',
                    style: TextStyle(
                      fontSize: 12.89.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                  ),
                  Text(
                    client.description ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 10.98.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.purple,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
