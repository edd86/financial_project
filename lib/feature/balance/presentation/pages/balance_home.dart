import 'package:financial_project/core/global_widgets.dart';
import 'package:financial_project/feature/balance/presentation/pages/find_client_page.dart';
import 'package:financial_project/feature/balance/presentation/provider/balance_sheet_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class BalanceHome extends StatefulWidget {
  const BalanceHome({super.key});

  @override
  State<BalanceHome> createState() => _BalanceHomeState();
}

class _BalanceHomeState extends State<BalanceHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Balance'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      drawer: GlobalWidgets.customDrawer(context),
      body: Consumer<BalanceSheetListProvider>(
        builder: (context, provider, child) {
          final balances = provider.balanceSheets;
          if (balances.isNotEmpty) {
            return ListView.builder(
              itemCount: balances.length,
              itemBuilder: (context, index) {
                final balance = balances[index].balanceSheet;
                final client = balances[index].balanceClient;
                return ListTile(
                  title: Text(client.businessName),
                  subtitle: Text(balance.period),
                );
              },
            );
          }
          return Center(child: Text('No hay balances registrados'));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        label: Row(
          children: [
            Icon(Icons.file_open),
            SizedBox(width: .85.w),
            Text('Nuevo Balance'),
          ],
        ),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FindClientPage()),
        ),
      ),
    );
  }
}
