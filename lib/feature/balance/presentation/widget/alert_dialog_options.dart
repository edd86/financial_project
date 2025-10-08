import 'package:financial_project/core/global_widgets.dart';
import 'package:financial_project/core/response.dart';
import 'package:financial_project/feature/balance/data/repo/balance_asset_repo_impl.dart';
import 'package:financial_project/feature/balance/data/repo/balance_liability_repo_impl.dart';
import 'package:financial_project/feature/balance/domain/model/balance_asset.dart';
import 'package:financial_project/feature/balance/domain/model/balance_liability.dart';
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
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                DropdownButton<String>(
                  value: _selectedAccount,
                  hint: Text('Tipo de cuenta'),
                  items: _accounts
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (value) =>
                      setState(() => _selectedAccount = value!),
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
                  hint: Text('Naturaleza de la cuenta'),
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
                    onPressed: () async {
                      if (_formKey.currentState!.validate() &&
                          _selectedAccount != null &&
                          _selectedAccountType != null) {
                        switch (_selectedAccount!.toLowerCase()) {
                          case 'activos':
                            final newBalanceAsset = BalanceAsset(
                              balanceSheetId: widget.balanceSheetId,
                              name: _nameController.text,
                              type: _selectedAccountType!.toLowerCase(),
                              amount: double.parse(_amountController.text),
                              description: _descriptionConroller.text,
                            );
                            final balanceAssetRes = await BalanceAssetRepoImpl()
                                .addBalanceAsset(newBalanceAsset);
                            if (balanceAssetRes.success) {
                              _showMessage(balanceAssetRes);
                              _backPage();
                            } else {
                              _showMessage(balanceAssetRes);
                            }
                            break;
                          case 'pasivos':
                            final newBalanceLiability = BalanceLiability(
                              balanceSheetId: widget.balanceSheetId,
                              name: _nameController.text,
                              type: _selectedAccountType!.toLowerCase(),
                              amount: double.parse(_amountController.text),
                              description: _descriptionConroller.text,
                            );
                            final balanceLiabilityRes =
                                BalanceLiabilityRepoImpl().addBalanceLiability(
                                  newBalanceLiability,
                                );
                          default:
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showMessage(Response balanceAssetRes) {
    ScaffoldMessenger.of(context).showSnackBar(
      GlobalWidgets.customSnackBar(
        balanceAssetRes.message,
        balanceAssetRes.success ? Colors.deepPurple : Colors.redAccent,
      ),
    );
  }

  void _backPage() {
    Navigator.pop(context);
  }
}
