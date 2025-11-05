import 'package:animated_search_bar/animated_search_bar.dart';
import 'package:financial_project/core/app_routes.dart';
import 'package:financial_project/core/global_widgets.dart';
import 'package:financial_project/core/utils.dart';
import 'package:financial_project/feature/income_statement/presentation/pages/incom_statement_client_page.dart';
import 'package:financial_project/feature/income_statement/presentation/provider/income_statement_clients_provider.dart';
import 'package:financial_project/feature/income_statement/presentation/widgets/home_statements_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class IncomeStatementHome extends StatefulWidget {
  const IncomeStatementHome({super.key});

  @override
  State<IncomeStatementHome> createState() => _IncomeStatementHomeState();
}

class _IncomeStatementHomeState extends State<IncomeStatementHome> {
  final _searchNameController = TextEditingController();
  String name = '';
  @override
  Widget build(BuildContext context) {
    Provider.of<IncomeStatementClientsProvider>(
      context,
      listen: false,
    ).setStatementClientRes(name: name);
    return Scaffold(
      appBar: AppBar(
        title: AnimatedSearchBar(
          controller: _searchNameController,
          label: 'Estados',
          labelStyle: TextStyle(fontSize: 17.8.sp, fontWeight: FontWeight.bold),
          searchStyle: TextStyle(color: Colors.white),
          onChanged: (value) {
            Provider.of<IncomeStatementClientsProvider>(
              context,
              listen: false,
            ).setStatementClientRes(name: value);
          },
        ),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      drawer: GlobalWidgets.customDrawer(context),
      body: Consumer<IncomeStatementClientsProvider>(
        builder: (context, provider, child) {
          final response = provider.statementClientRes;
          if (!response.success) {
            return Center(child: Text(response.message));
          }
          final clients = response.data!;
          if (clients.isEmpty) {
            return Center(
              child: Text('No se encontraron estados de resultados'),
            );
          }
          return ListView.builder(
            itemCount: clients.length,
            itemBuilder: (context, index) {
              final client = clients[index];
              return Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 0.5.h,
                  horizontal: 5.2.w,
                ),
                child: GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => IncomStatementClientPage(
                        incomeStatementClient: client,
                      ),
                    ),
                  ),
                  child: HomeStatementsCard(client: client),
                ),
              );
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Crear Nuevo'),
        icon: const Icon(Icons.new_label_outlined),
        onPressed: () {
          if (Utils.hasIncomeStatementPermissions()) {
            Navigator.pushNamed(context, AppRoutes.incomeStatementForm);
          } else {
            _showSnackBar();
          }
        },
      ),
    );
  }

  void _showSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      GlobalWidgets.customSnackBar(
        'No tienes permisos para crear un estado de resultados',
        Colors.redAccent,
      ),
    );
  }
}
