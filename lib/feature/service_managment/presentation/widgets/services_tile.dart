import 'package:financial_project/feature/service_managment/domain/model/service_entity.dart';
import 'package:financial_project/feature/service_managment/presentation/widgets/alert_update_service.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ServicesTile extends StatelessWidget {
  final ServiceEntity service;
  const ServicesTile({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        width: 80.w,
        height: 9.5.h,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(Icons.room_service, color: Colors.deepPurple),
            Text(service.name.toUpperCase()),
            TextButton(
              child: Text(service.amount.toStringAsFixed(2)),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertUpdateService(service: service),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
