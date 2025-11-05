// ignore_for_file: use_build_context_synchronously

import 'package:financial_project/core/utils.dart';
import 'package:financial_project/feature/income_statement/data/repo/income_statement_repo_impl.dart';
import 'package:financial_project/feature/income_statement/domain/model/income_statement_client.dart';
import 'package:financial_project/feature/income_statement/presentation/provider/income_statement_clients_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class HomeStatementsCard extends StatelessWidget {
  final IncomeStatementClient client;
  const HomeStatementsCard({super.key, required this.client});

  @override
  Widget build(BuildContext context) {
    final periodStart = Utils.dueDateString(
      client.incomeStatement.periodStartDate,
    );
    final periodEnd = Utils.dueDateString(client.incomeStatement.periodEndDate);
    return Card(
      child: Padding(
        padding: EdgeInsets.all(2.8.w),
        child: SizedBox(
          height: 11.75.h,
          width: 75.w,
          child: Column(
            children: [
              Text(
                client.clientStatement.name,
                style: TextStyle(
                  fontSize: 15.7.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(client.clientStatement.nitCi),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    periodStart,
                    style: TextStyle(
                      fontSize: 12.7.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54,
                    ),
                  ),
                  Text(
                    periodEnd,
                    style: TextStyle(
                      fontSize: 12.7.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    color: Colors.deepPurple,
                    onPressed: () async {},
                    icon: Icon(Icons.edit),
                  ),
                  IconButton(
                    color: Colors.deepPurple,
                    onPressed: () async {
                      final res = await IncomeStatementRepoImpl()
                          .deleteClientStatement(client.incomeStatement);
                      if (res.success) {
                        Provider.of<IncomeStatementClientsProvider>(
                          context,
                          listen: false,
                        ).setStatementClientRes();
                      }
                    },
                    icon: Icon(Icons.delete),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
