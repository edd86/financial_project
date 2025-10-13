import 'package:financial_project/feature/balance/domain/model/balance_liability.dart';
import 'package:financial_project/feature/balance/presentation/provider/balance_liabilities_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class BalanceLiabilitiesPage extends StatelessWidget {
  final int balanceId;
  const BalanceLiabilitiesPage({required this.balanceId, super.key});

  @override
  Widget build(BuildContext context) {
    context.read<BalanceLiabilitiesProvider>().setBalanceLiabilities(balanceId);
    return Scaffold(
      appBar: AppBar(title: Text('Balance General'), centerTitle: true),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.78.w),
        child: Column(
          children: [
            Text(
              'Pasivos',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 2.15.h),
            Expanded(
              child: Consumer<BalanceLiabilitiesProvider>(
                builder: (context, snapshot, child) {
                  final balanceLiabilitiesRes = snapshot.balanceLiabilities;
                  if (!balanceLiabilitiesRes.success) {
                    return Center(child: Text(balanceLiabilitiesRes.message));
                  }
                  final liabilities = balanceLiabilitiesRes.data ?? [];
                  return ListView.builder(
                    itemCount: liabilities.length,
                    itemBuilder: (context, index) {
                      final liability = snapshot.balanceLiabilities.data?[index];
                      return ListTile(
                        title: Text(
                          liability?.name ?? '',
                          style: TextStyle(
                            fontSize: 15.25.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Text(
                          '${liability?.amount ?? ''} bs.',
                          style: TextStyle(
                            fontSize: 14.25.sp,
                            color: Colors.black54,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.chevron_right,
                            color: Colors.black54,
                          ),
                          onPressed: () => _showBalanceForm(context, liability!),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showBalanceForm(
    BuildContext context,
    BalanceLiability balanceLiability,
  ) {
    
  }
}
