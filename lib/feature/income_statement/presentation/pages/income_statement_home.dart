import 'package:financial_project/core/app_routes.dart';
import 'package:financial_project/core/global_widgets.dart';
import 'package:financial_project/core/utils.dart';
import 'package:flutter/material.dart';

class IncomeStatementHome extends StatefulWidget {
  const IncomeStatementHome({super.key});

  @override
  State<IncomeStatementHome> createState() => _IncomeStatementHomeState();
}

class _IncomeStatementHomeState extends State<IncomeStatementHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Estado de Resultados'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      drawer: GlobalWidgets.customDrawer(context),
      body: Center(child: Text('Estado de Resultados')),
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
