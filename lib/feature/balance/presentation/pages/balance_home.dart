import 'package:animated_search_bar/animated_search_bar.dart';
import 'package:financial_project/core/global_widgets.dart';
import 'package:financial_project/feature/balance/presentation/pages/balance_resume.dart';
import 'package:financial_project/feature/balance/presentation/pages/find_client_page.dart';
import 'package:financial_project/feature/balance/presentation/provider/balance_sheet_list_provider.dart';
import 'package:financial_project/feature/balance/presentation/widget/balance_client_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class BalanceHome extends StatefulWidget {
  const BalanceHome({super.key});

  @override
  State<BalanceHome> createState() => _BalanceHomeState();
}

class _BalanceHomeState extends State<BalanceHome> {
  final _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BalanceSheetListProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: AnimatedSearchBar(
          controller: _searchController,
          label: 'Balances',
          labelStyle: TextStyle(fontSize: 19.sp),
          searchStyle: TextStyle(fontSize: 17.85.sp, color: Colors.white),
          searchDecoration: InputDecoration(
            fillColor: Colors.white,
            hintText: 'Buscar por nombre',
            hintStyle: TextStyle(fontSize: 17.85.sp, color: Colors.white),
          ),
          onChanged: (value) {
            provider.findBalanceSheetByClient(value);
          },
        ),
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
                return Padding(
                  padding: EdgeInsetsGeometry.symmetric(horizontal: 12.8.sp),
                  child: GestureDetector(
                    child: BalanceClientTile(
                      balanceSheet: balance,
                      balanceClient: client,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              BalanceResume(balanceId: balance.id!),
                        ),
                      );
                    },
                  ),
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
