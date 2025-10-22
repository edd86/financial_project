import 'package:financial_project/feature/income_statement/domain/model/client_statement.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ClientStatementCard extends StatelessWidget {
  final ClientStatement clientStatement;
  const ClientStatementCard({super.key, required this.clientStatement});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: 10.h,
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              clientStatement.name,
              style: TextStyle(fontSize: 15.8.sp, fontWeight: FontWeight.bold),
            ),
            Text(
              clientStatement.nitCi,
              style: TextStyle(fontSize: 13.9.sp, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
