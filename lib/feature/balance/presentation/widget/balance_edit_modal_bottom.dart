import 'package:financial_project/core/response.dart';
import 'package:financial_project/core/utils.dart';
import 'package:financial_project/feature/balance/data/repo/balance_sheet_repo_impl.dart';
import 'package:financial_project/feature/balance/domain/model/balance_client.dart';
import 'package:financial_project/feature/balance/domain/model/balance_sheet.dart';
import 'package:financial_project/feature/balance/presentation/provider/balance_sheet_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class BalanceEditModalBottom extends StatefulWidget {
  final BalanceClient balanceClient;
  final BalanceSheet balanceSheet;
  const BalanceEditModalBottom({
    required this.balanceClient,
    required this.balanceSheet,
    super.key,
  });

  @override
  State<BalanceEditModalBottom> createState() => _BalanceEditModalBottomState();
}

class _BalanceEditModalBottomState extends State<BalanceEditModalBottom> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _periodController;
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    _periodController = TextEditingController(text: widget.balanceSheet.period);
    selectedDate = widget.balanceSheet.balanceDate;
  }

  @override
  Widget build(BuildContext context) {
    final balanceListProvider = Provider.of<BalanceSheetListProvider>(
      context,
      listen: false,
    );
    return Padding(
      padding: EdgeInsetsGeometry.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Editar Balance ${widget.balanceClient.businessName}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            SizedBox(height: 2.h),
            TextFormField(
              controller: _periodController,
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
                child: Text('Guardar Cambios'),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final balanceTemp = BalanceSheet(
                      id: widget.balanceSheet.id,
                      clientId: widget.balanceClient.id,
                      balanceDate: selectedDate,
                      period: _periodController.text,
                    );
                    final res = await BalanceSheetRepoImpl().updateBalanceSheet(
                      balanceTemp,
                    );
                    if (res.success) {
                      balanceListProvider.getBalanceSheets();
                      _backPage();
                    }
                    _showMessage(res);
                  }
                },
              ),
            ),
            SizedBox(height: 1.5.h),
          ],
        ),
      ),
    );
  }

  void _showMessage(Response res) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(res.message),
        backgroundColor: res.success ? Colors.deepPurple : Colors.redAccent,
      ),
    );
  }

  void _backPage() {
    Navigator.pop(context);
  }
}
