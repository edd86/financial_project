import 'package:financial_project/core/global_widgets.dart';
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
    );
  }
}
