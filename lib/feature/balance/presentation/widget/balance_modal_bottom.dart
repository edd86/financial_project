import 'package:financial_project/core/app_routes.dart';
import 'package:financial_project/core/global_widgets.dart';
import 'package:financial_project/core/response.dart';
import 'package:financial_project/core/utils.dart';
import 'package:financial_project/feature/balance/data/repo/balance_sheet_repo_impl.dart';
import 'package:financial_project/feature/balance/domain/model/balance_sheet.dart';
import 'package:financial_project/feature/balance/presentation/provider/balance_sheet_list_provider.dart';
import 'package:financial_project/feature/service_managment/data/repo/service_repo_impl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class BalanceModalBottom extends StatefulWidget {
  final int clientId;
  const BalanceModalBottom(this.clientId, {super.key});

  @override
  State<BalanceModalBottom> createState() => _BalanceModalBottomState();
}

class _BalanceModalBottomState extends State<BalanceModalBottom> {
  final formKey = GlobalKey<FormState>();
  final periodController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    // Obtenemos el provider correcto para actualizar la lista de balances
    final balanceListProvider = Provider.of<BalanceSheetListProvider>(
      context,
      listen: false,
    );
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Nuevo Balance',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            SizedBox(height: 2.h),
            TextFormField(
              controller: periodController,
              decoration: InputDecoration(
                labelText: 'Periodo',
                hintText: 'Ej: Enero 2023',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.calendar_today),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese el periodo';
                }
                return null;
              },
            ),
            SizedBox(height: 1.5.h),
            InkWell(
              onTap: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: selectedDate,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (picked != null && picked != selectedDate) {
                  setState(() {
                    selectedDate = picked;
                  });
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: [
                    Icon(Icons.date_range),
                    SizedBox(width: 10),
                    Text(
                      'Fecha: ${Utils.localDateString(selectedDate)}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 2.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    final balanceTemp = BalanceSheet(
                      clientId: widget.clientId,
                      balanceDate: selectedDate,
                      period: periodController.text,
                    );
                    final res = await BalanceSheetRepoImpl().addBalance(
                      balanceTemp,
                    );
                    if (res.success) {
                      balanceListProvider.getBalanceSheets();
                      final resServiceLog = await ServiceRepoImpl()
                          .addServiceLog(widget.clientId, 'balance');
                      if (!resServiceLog.success) {
                        _showMessage(Response.error(resServiceLog.message));
                      }
                      _backPage();
                    }
                    _showMessage(res);
                  }
                },
                child: Text('Guardar Balance'),
              ),
            ),
            SizedBox(height: 1.h),
          ],
        ),
      ),
    );
  }

  void _showMessage(Response res) {
    ScaffoldMessenger.of(context).showSnackBar(
      GlobalWidgets.customSnackBar(
        res.message,
        res.success ? Colors.deepPurple : Colors.redAccent,
      ),
    );
  }

  void _backPage() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.balanceHome,
      (route) => false,
    );
  }
}
