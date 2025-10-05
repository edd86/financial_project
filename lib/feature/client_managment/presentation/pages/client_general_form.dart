import 'package:financial_project/core/global_widgets.dart';
import 'package:financial_project/core/response.dart';
import 'package:financial_project/core/utils.dart';
import 'package:financial_project/feature/client_managment/data/repo/client_repo_impl.dart';
import 'package:financial_project/feature/client_managment/domain/model/client.dart';
import 'package:financial_project/feature/client_managment/domain/model/client_monthly_record.dart';
import 'package:financial_project/feature/client_managment/presentation/provider/clients_obligations_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ClientGeneralForm extends StatefulWidget {
  final Client client;
  const ClientGeneralForm({super.key, required this.client});

  @override
  State<ClientGeneralForm> createState() => _ClientGeneralFormState();
}

class _ClientGeneralFormState extends State<ClientGeneralForm> {
  final _formSalesKey = GlobalKey<FormState>();
  final _formPurchaseKey = GlobalKey<FormState>();
  final _totalSalesController = TextEditingController();
  final _discountSalesController = TextEditingController();
  final _salesInvoiceCount = TextEditingController();
  final _totalPurchaseController = TextEditingController();
  final _discountPurchaseController = TextEditingController();
  final _purchaseInvoiceCount = TextEditingController();
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ClientsObligationsProvider>(
      context,
      listen: false,
    );
    return Scaffold(
      body: Stepper(
        currentStep: _index,
        onStepCancel: () {
          if (_index > 0) {
            setState(() {
              _index--;
            });
          }
        },
        onStepContinue: () async {
          if (_index <= 2) {
            switch (_index) {
              case 0:
                if (_formSalesKey.currentState!.validate()) {
                  setState(() {
                    _index++;
                  });
                }
                break;
              case 1:
                if (_formPurchaseKey.currentState!.validate()) {
                  setState(() {
                    _index++;
                  });
                }
                break;
              default:
                final clientRecord = ClientMonthlyRecord(
                  clientId: widget.client.id!,
                  recordMonth: Utils.getActualMonthString(),
                  recordYear: DateTime.now().year,
                  totalPurchases: double.parse(_totalPurchaseController.text),
                  purchaseDiscount: double.parse(
                    _discountPurchaseController.text,
                  ),
                  purchaseInvoiceCount: int.parse(_purchaseInvoiceCount.text),
                  grossSales: double.parse(_totalSalesController.text),
                  salesDiscount: double.parse(_discountSalesController.text),
                  salesInvoiceCount: int.parse(_salesInvoiceCount.text),
                  status: 'borrador',
                );
                final res = await ClientRepoImpl().addClientMonthlyRecord(
                  clientRecord,
                );
                if (res.success) {
                  _showMessage(res);
                  final resObligation = await ClientRepoImpl()
                      .assignClientGeneralObligation(res.data!);
                  if (resObligation.success) {
                    _showMessage(resObligation);
                    provider.setClientObligations(widget.client.id!);
                    _backPage();
                  } else {
                    _showMessage(resObligation);
                  }
                } else {
                  _showMessage(res);
                }
                break;
            }
          }
        },
        onStepTapped: (value) {
          setState(() {
            _index = value;
          });
        },
        steps: [
          Step(
            title: Text(
              'Registro de ventas',
              style: TextStyle(fontSize: 13.75.sp),
            ),
            content: SizedBox(
              height: 25.75.h,
              width: 50.w,
              child: Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 2.85.w),
                child: Form(
                  key: _formSalesKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: _totalSalesController,
                        decoration: InputDecoration(
                          label: GlobalWidgets.customLabelWidget(
                            Icons.money,
                            'Total Ventas',
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Complete este campo';
                          }
                          if (double.tryParse(value) == null) {
                            return 'Ingrese un monto válido';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: _discountSalesController,
                        decoration: InputDecoration(
                          label: GlobalWidgets.customLabelWidget(
                            Icons.discount,
                            'Descuento Ventas',
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Complete este campo';
                          }
                          if (double.tryParse(value) == null) {
                            return 'Ingrese un monto válido';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: _salesInvoiceCount,
                        decoration: InputDecoration(
                          label: GlobalWidgets.customLabelWidget(
                            Icons.format_indent_increase,
                            'Cant. facturas Ventas',
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Complete este campo';
                          }
                          if (int.tryParse(value) == null) {
                            return 'Ingrese una cantidad válida';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Step(
            title: Text(
              'Registro de compras',
              style: TextStyle(fontSize: 13.75.sp),
            ),
            content: SizedBox(
              height: 25.75.h,
              width: 50.w,
              child: Form(
                key: _formPurchaseKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _totalPurchaseController,
                      decoration: InputDecoration(
                        label: GlobalWidgets.customLabelWidget(
                          Icons.money,
                          'Total Compras',
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Complete este campo';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Ingrese un monto válido';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _discountPurchaseController,
                      decoration: InputDecoration(
                        label: GlobalWidgets.customLabelWidget(
                          Icons.discount,
                          'Descuento Compras',
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Complete este campo';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Ingrese un monto válido';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _purchaseInvoiceCount,
                      decoration: InputDecoration(
                        label: GlobalWidgets.customLabelWidget(
                          Icons.format_indent_increase,
                          'Cant. facturas Compras',
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Complete este campo';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Ingrese una cantida válida';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Step(
            title: Text('Finalizar', style: TextStyle(fontSize: 13.75.sp)),
            content: Center(
              child: Text(
                'Continuar para guardar el registro, confirme sus valores',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.7.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
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
    Navigator.pop(context);
  }
}
