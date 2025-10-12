import 'package:financial_project/core/global_widgets.dart';
import 'package:financial_project/core/response.dart';
import 'package:financial_project/feature/balance/data/repo/balance_asset_repo_impl.dart';
import 'package:financial_project/feature/balance/domain/model/balance_asset.dart';
import 'package:financial_project/feature/balance/presentation/provider/balance_assets_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class BalanceAssetModalBottom extends StatefulWidget {
  final BalanceAsset balanceAsset;
  const BalanceAssetModalBottom({required this.balanceAsset, super.key});

  @override
  State<BalanceAssetModalBottom> createState() =>
      _BalanceAssetModalBottomState();
}

class _BalanceAssetModalBottomState extends State<BalanceAssetModalBottom> {
  late TextEditingController _nameController;
  late TextEditingController _amountController;
  final _spacer = SizedBox(height: 2.h);

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.balanceAsset.name);
    _amountController = TextEditingController(
      text: widget.balanceAsset.amount.toString(),
    );
  }

  @override
  dispose() {
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
          padding: EdgeInsets.symmetric(horizontal: 5.85.w, vertical: 2.5.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                      final provider = Provider.of<BalanceAssetsProvider>(
                        context,
                        listen: false,
                      );
                      final res = await provider.deleteAsset(
                        widget.balanceAsset,
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
                    final asset = BalanceAsset(
                      id: widget.balanceAsset.id,
                      balanceSheetId: widget.balanceAsset.balanceSheetId,
                      name: _nameController.text,
                      type: widget.balanceAsset.type,
                      amount: double.parse(_amountController.text),
                    );
                    final res = await BalanceAssetRepoImpl().updateBalanceAsset(
                      asset,
                    );
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
    Provider.of<BalanceAssetsProvider>(context, listen: false).refreshAssets();
    Navigator.of(
      context,
    ).pushNamedAndRemoveUntil('/balance-home', (route) => false);
  }
}
