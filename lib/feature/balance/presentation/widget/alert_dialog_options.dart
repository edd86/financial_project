import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AlertDialogOptions extends StatefulWidget {
  final int balanceSheetId;
  const AlertDialogOptions({required this.balanceSheetId, super.key});

  @override
  State<AlertDialogOptions> createState() => _AlertDialogOptionsState();
}

List<String> _accounts = ['Activos', 'Pasivos', 'Patrimonio'];
List<String> _accountTypes = ['Corriente', 'No corriente'];

class _AlertDialogOptionsState extends State<AlertDialogOptions> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  final _descriptionConroller = TextEditingController();
  String? _selectedAccount;
  String? _selectedAccountType;
  final _spacer = SizedBox(height: 1.29.h);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Agregar cuentas', textAlign: TextAlign.center),
      content: SizedBox(
        height: 48.75.h,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButton<String>(
                value: _selectedAccount,
                hint: Text('Seleccione el tipo de cuenta'),
                items: _accounts
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) => setState(() => _selectedAccount = value!),
              ),
              _spacer,
              TextFormField(
                controller: _nameController,
                style: TextStyle(fontSize: 14.75.sp),
                decoration: InputDecoration(
                  labelText: 'Nombre',
                  labelStyle: TextStyle(fontSize: 14.75.sp),
                  hintStyle: TextStyle(fontSize: 15.sp),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un nombre';
                  }
                  return null;
                },
              ),
              _spacer,
              DropdownButton<String>(
                value: _selectedAccountType,
                hint: Text('Seleccione naturaleza de la cuenta'),
                items: _accountTypes
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) =>
                    setState(() => _selectedAccountType = value!),
              ),
              _spacer,
              TextFormField(
                controller: _amountController,
                style: TextStyle(fontSize: 14.75.sp),
                decoration: InputDecoration(
                  labelText: 'Monto',
                  labelStyle: TextStyle(fontSize: 14.75.sp),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un monto';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Por favor ingrese un monto válido';
                  }
                  return null;
                },
              ),
              _spacer,
              TextFormField(
                controller: _descriptionConroller,
                style: TextStyle(fontSize: 14.75.sp),
                decoration: InputDecoration(
                  labelText: 'Descripción',
                  labelStyle: TextStyle(fontSize: 14.75.sp),
                  hintStyle: TextStyle(fontSize: 15.sp),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese una descripción';
                  }
                  return null;
                },
              ),
              _spacer,
              _spacer,
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text('Registrar Cuenta'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      print('Hello');
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
}
