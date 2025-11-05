import 'package:financial_project/core/global_widgets.dart';
import 'package:financial_project/core/response.dart';
import 'package:financial_project/core/utils.dart';
import 'package:financial_project/feature/income_statement/data/repo/income_statement_repo_impl.dart';
import 'package:financial_project/feature/income_statement/domain/model/income_statement.dart';
import 'package:financial_project/feature/income_statement/presentation/provider/client_statement_provider.dart';
import 'package:financial_project/feature/income_statement/presentation/provider/income_statement_clients_provider.dart';
import 'package:financial_project/feature/income_statement/presentation/widgets/client_statement_card.dart';
import 'package:financial_project/feature/income_statement/presentation/widgets/search_client_statement.dart';
import 'package:financial_project/feature/service_managment/data/repo/service_repo_impl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class IncomeStatementForm extends StatefulWidget {
  const IncomeStatementForm({super.key});

  @override
  State<IncomeStatementForm> createState() => _IncomeStatementFormState();
}

class _IncomeStatementFormState extends State<IncomeStatementForm> {
  final _formKey = GlobalKey<FormState>();
  final _netSalesController = TextEditingController();
  final _costOfSalesController = TextEditingController();
  final _salesExpensesController = TextEditingController();
  final _adminExpensesController = TextEditingController();
  final _depreciationController = TextEditingController();
  final _otherIncomeController = TextEditingController();
  final _financialExpenseController = TextEditingController();
  final _taxesController = TextEditingController();
  final _spacer = SizedBox(height: 3.45.h);
  DateTime _periodStartDate = DateTime.now();
  DateTime _periodEndDate = DateTime.now();

  @override
  dispose() {
    _netSalesController.dispose();
    _costOfSalesController.dispose();
    _salesExpensesController.dispose();
    _adminExpensesController.dispose();
    _depreciationController.dispose();
    _otherIncomeController.dispose();
    _financialExpenseController.dispose();
    _taxesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nuevo Estado de Resultados')),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 10.75.w, vertical: 1.5.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Consumer<ClientStatementProvider>(
                builder: (context, provider, child) {
                  final client = provider.client;
                  return client != null
                      ? ClientStatementCard(clientStatement: client)
                      : TextButton(
                          child: Text('Seleccione Cliente'),
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SearchClientStatement(),
                            ),
                          ),
                        );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    child: Text(
                      'Inicio: ${Utils.dueDateString(_periodStartDate)}',
                    ),
                    onPressed: () => _showCalendar(true),
                  ),
                  TextButton(
                    child: Text('Fin: ${Utils.dueDateString(_periodEndDate)}'),
                    onPressed: () => _showCalendar(false),
                  ),
                ],
              ),
              TextFormField(
                controller: _netSalesController,
                decoration: const InputDecoration(labelText: 'Ventas Netas'),
                keyboardType: TextInputType.number,
                validator: _validateNumberField,
              ),
              _spacer,
              TextFormField(
                controller: _costOfSalesController,
                decoration: const InputDecoration(labelText: 'Costo de Ventas'),
                keyboardType: TextInputType.number,
                validator: _validateNumberField,
              ),
              _spacer,
              TextFormField(
                controller: _salesExpensesController,
                decoration: const InputDecoration(
                  labelText: 'Gastos de Ventas',
                ),
                keyboardType: TextInputType.number,
                validator: _validateNumberField,
              ),
              _spacer,
              TextFormField(
                controller: _adminExpensesController,
                decoration: const InputDecoration(
                  labelText: 'Gastos Administrativos',
                ),
                keyboardType: TextInputType.number,
                validator: _validateNumberField,
              ),
              _spacer,
              TextFormField(
                controller: _depreciationController,
                decoration: const InputDecoration(labelText: 'Depreciación'),
                keyboardType: TextInputType.number,
                validator: _validateNumberField,
              ),
              _spacer,
              TextFormField(
                controller: _otherIncomeController,
                decoration: const InputDecoration(labelText: 'Ingresos Otros'),
                keyboardType: TextInputType.number,
                validator: _validateNumberField,
              ),
              _spacer,
              TextFormField(
                controller: _financialExpenseController,
                decoration: const InputDecoration(
                  labelText: 'Gastos Financieros',
                ),
                keyboardType: TextInputType.number,
                validator: _validateNumberField,
              ),
              _spacer,
              TextFormField(
                controller: _taxesController,
                decoration: const InputDecoration(labelText: 'Impuestos'),
                keyboardType: TextInputType.number,
                validator: _validateNumberField,
              ),
              _spacer,
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text('Registrar Estado'),
                  onPressed: () async {
                    final client = Provider.of<ClientStatementProvider>(
                      context,
                      listen: false,
                    ).client;
                    if (_formKey.currentState!.validate() && client != null) {
                      final state = IncomeStatement(
                        clientId: client.id,
                        periodStartDate: _periodStartDate,
                        periodEndDate: _periodEndDate,
                        netSales: double.parse(_netSalesController.text),
                        costOfSales: double.parse(_costOfSalesController.text),
                        salesExpenses: double.parse(
                          _salesExpensesController.text,
                        ),
                        adminExpenses: double.parse(
                          _adminExpensesController.text,
                        ),
                        depreciation: double.parse(
                          _depreciationController.text,
                        ),
                        otherIncome: double.parse(_otherIncomeController.text),
                        financialExpenses: double.parse(
                          _financialExpenseController.text,
                        ),
                        taxes: double.parse(_taxesController.text),
                        createdAt: DateTime.now(),
                        updatedAt: DateTime.now(),
                      );
                      final res = await IncomeStatementRepoImpl()
                          .createIncomeStatement(state);
                      if (res.success) {
                        final resServiceLog = await ServiceRepoImpl()
                            .addServiceLog(client.id, 'resultados');
                        Provider.of<IncomeStatementClientsProvider>(
                          context,
                          listen: false,
                        ).setStatementClientRes(name: '');
                        if (!resServiceLog.success) {
                          _showSnackBar(Response.error(resServiceLog.message));
                        }
                        _backPage();
                      }
                      _showSnackBar(res);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? _validateNumberField(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese un número';
    }
    if (double.tryParse(value) == null) {
      return 'Por favor, ingrese un número válido';
    }
    return null;
  }

  void _showCalendar(bool serie) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _periodStartDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now().add(Duration(days: 30)),
    );
    if (picked != null &&
        (picked != _periodStartDate || picked != _periodEndDate)) {
      setState(() {
        serie ? _periodStartDate = picked : _periodEndDate = picked;
      });
    }
  }

  void _showSnackBar(Response res) {
    ScaffoldMessenger.of(context).showSnackBar(
      GlobalWidgets.customSnackBar(
        res.message,
        res.success ? Colors.deepPurple : Colors.redAccent,
      ),
    );
  }

  void _backPage() {
    Navigator.pop(context);
  }
}
