import 'package:financial_project/core/utils.dart';
import 'package:financial_project/feature/income_statement/domain/model/income_statement_client.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class IncomStatementClientPage extends StatefulWidget {
  final IncomeStatementClient incomeStatementClient;
  const IncomStatementClientPage({
    super.key,
    required this.incomeStatementClient,
  });

  @override
  State<IncomStatementClientPage> createState() =>
      _IncomStatementClientPageState();
}

class _IncomStatementClientPageState extends State<IncomStatementClientPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.incomeStatementClient.clientStatement.name),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: .2.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: 10.w),
                Text(
                  Utils.dueDateString(
                    widget
                        .incomeStatementClient
                        .incomeStatement
                        .periodStartDate,
                  ),
                  style: TextStyle(
                    fontSize: 14.98.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  Utils.dueDateString(
                    widget.incomeStatementClient.incomeStatement.periodEndDate,
                  ),
                  style: TextStyle(
                    fontSize: 14.98.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 10.w),
              ],
            ),
            SizedBox(height: 2.75.h),
            SizedBox(
              width: double.infinity,
              height: 11.05.h,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ingresos',
                    style: TextStyle(
                      fontSize: 19.78.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Ventas Netas:',
                        style: TextStyle(
                          fontSize: 15.78.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        widget.incomeStatementClient.incomeStatement.netSales
                            .toStringAsFixed(2),
                        style: TextStyle(
                          fontSize: 15.78.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Otros Ingresos:',
                        style: TextStyle(
                          fontSize: 15.78.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        widget.incomeStatementClient.incomeStatement.otherIncome
                            .toStringAsFixed(2),
                        style: TextStyle(
                          fontSize: 15.78.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 1.150.h),
            SizedBox(
              width: double.infinity,
              height: 7.7.h,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Costos',
                    style: TextStyle(
                      fontSize: 19.78.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Costos de Ventas:',
                        style: TextStyle(
                          fontSize: 15.78.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        widget.incomeStatementClient.incomeStatement.costOfSales
                            .toStringAsFixed(2),
                        style: TextStyle(
                          fontSize: 15.78.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Card(
              child: SizedBox(
                height: 5.h,
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 2.w,
                    vertical: .2.h,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Utilidad Bruta:',
                        style: TextStyle(
                          fontSize: 15.78.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        Utils.utilityBrute(
                          widget.incomeStatementClient.incomeStatement,
                        ).toStringAsFixed(2),
                        style: TextStyle(
                          fontSize: 15.78.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: .150.h),
            SizedBox(
              width: double.infinity,
              height: 15.7.h,

              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Gastos operativos',
                    style: TextStyle(
                      fontSize: 19.78.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Gastos de Venta:',
                        style: TextStyle(
                          fontSize: 15.78.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        widget.incomeStatementClient.incomeStatement.costOfSales
                            .toStringAsFixed(2),
                        style: TextStyle(
                          fontSize: 15.78.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Gastos Administrativos:',
                        style: TextStyle(
                          fontSize: 15.78.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        widget
                            .incomeStatementClient
                            .incomeStatement
                            .adminExpenses
                            .toStringAsFixed(2),
                        style: TextStyle(
                          fontSize: 15.78.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Depreciación:',
                        style: TextStyle(
                          fontSize: 15.78.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        widget
                            .incomeStatementClient
                            .incomeStatement
                            .depreciation
                            .toStringAsFixed(2),
                        style: TextStyle(
                          fontSize: 15.78.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: .150.h),
            Card(
              child: SizedBox(
                height: 5.h,
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 2.w,
                    vertical: .2.h,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Utilidad Operativa:',
                        style: TextStyle(
                          fontSize: 15.78.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        Utils.utilityOp(
                          widget.incomeStatementClient.incomeStatement,
                        ).toStringAsFixed(2),
                        style: TextStyle(
                          fontSize: 15.78.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 1.150.h),
            SizedBox(
              width: double.infinity,
              height: 4.7.h,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Gastos Financiero:',
                        style: TextStyle(
                          fontSize: 15.78.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        widget.incomeStatementClient.incomeStatement.costOfSales
                            .toStringAsFixed(2),
                        style: TextStyle(
                          fontSize: 15.78.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Card(
              child: SizedBox(
                height: 5.h,
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 2.w,
                    vertical: .2.h,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Utilidad Antes de Impuestos:',
                        style: TextStyle(
                          fontSize: 15.78.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        Utils.utilityBefTax(
                          widget.incomeStatementClient.incomeStatement,
                        ).toStringAsFixed(2),
                        style: TextStyle(
                          fontSize: 15.78.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 1.150.h),
            SizedBox(
              width: double.infinity,
              height: 4.7.h,

              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Impuestos:',
                        style: TextStyle(
                          fontSize: 15.78.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        widget.incomeStatementClient.incomeStatement.taxes
                            .toStringAsFixed(2),
                        style: TextStyle(
                          fontSize: 15.78.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Card(
              child: SizedBox(
                height: 5.h,
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 2.w,
                    vertical: .2.h,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Utilidad Neta:',
                        style: TextStyle(
                          fontSize: 15.78.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        Utils.utilityNet(
                          widget.incomeStatementClient.incomeStatement,
                        ).toStringAsFixed(2),
                        style: TextStyle(
                          fontSize: 15.78.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 1.98.h),
            SizedBox(
              height: 40.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ratios Financieros',
                    style: TextStyle(
                      fontSize: 19.78.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
