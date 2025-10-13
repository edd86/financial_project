import 'package:financial_project/core/global_widgets.dart';
import 'package:financial_project/core/response.dart';
import 'package:financial_project/feature/balance/data/repo/balance_liability_repo_impl.dart';
import 'package:financial_project/feature/balance/domain/model/balance_liability.dart';
import 'package:financial_project/feature/balance/presentation/provider/balance_liabilities_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class BalanceLiabilityModalBottom extends StatefulWidget {
  final BalanceLiability balanceLiability;
  const BalanceLiabilityModalBottom({
    required this.balanceLiability,
    super.key,
  });

  @override
  State<BalanceLiabilityModalBottom> createState() =>
      _BalanceLiabilityModalBottomState();
}

class _BalanceLiabilityModalBottomState
    extends State<BalanceLiabilityModalBottom> {
  late TextEditingController _nameController;
  late TextEditingController _amountController;
  final _spacer = SizedBox(height: 2.h);

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.balanceLiability.name);
    _amountController = TextEditingController(
      text: widget.balanceLiability.amount.toString(),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35.5.h,
      child: Form(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 5.85.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Editar cuenta',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.deepPurple),
                    onPressed: () async {
                      // Usar el método del provider para eliminar y actualizar automáticamente
                      final provider = Provider.of<BalanceLiabilitiesProvider>(
                        context,
                        listen: false,
                      );
                      final res = await provider.deleteLiability(
                        widget.balanceLiability,
                      );
                      if (res.success) {
                        _showMessage(res);
                        // Navegar a balance-home en lugar de solo cerrar el modal
                        _backPage();
                      } else {
                        _showMessage(res);
                      }
                    },
                  ),
                ],
              ),
              _spacer,
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Nombre de cuenta',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.account_balance),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un nombre de cuenta';
                  }
                  return null;
                },
              ),
              _spacer,
              TextFormField(
                controller: _amountController,
                decoration: InputDecoration(
                  labelText: 'Monto',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.monetization_on),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un monto';
                  }
                  if (double.tryParse(value) == null) {
                    return 'El monto debe ser un número';
                  }
                  return null;
                },
              ),
              _spacer,
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text('Actualizar'),
                  onPressed: () async {
                    final liablility = BalanceLiability(
                      id: widget.balanceLiability.id,
                      balanceSheetId: widget.balanceLiability.balanceSheetId,
                      name: _nameController.text,
                      type: widget.balanceLiability.type,
                      amount: double.parse(_amountController.text),
                    );

                    final res = await BalanceLiabilityRepoImpl()
                        .updateLiability(liablility);
                    if (res.success) {
                      _showMessage(res);
                      _backPage();
                    } else {
                      _showMessage(res);
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

  void _showMessage(Response res) {
    ScaffoldMessenger.of(context).showSnackBar(
      GlobalWidgets.customSnackBar(
        res.message,
        res.success ? Colors.deepPurple : Colors.redAccent,
      ),
    );
  }

  void _backPage() {
    Provider.of<BalanceLiabilitiesProvider>(context, listen: false).refreshLiabilities();
    Navigator.of(
      context,
    ).pushNamedAndRemoveUntil('/balance-home', (route) => false);
  }
}
