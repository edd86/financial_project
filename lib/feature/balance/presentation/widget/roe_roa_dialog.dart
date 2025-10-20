import 'package:financial_project/feature/balance/presentation/provider/roa_provider.dart';
import 'package:financial_project/feature/balance/presentation/provider/roe_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RoeRoaDialog extends StatefulWidget {
  final double? totalAssets;
  final double? totalEquity;
  const RoeRoaDialog({this.totalAssets, this.totalEquity, super.key});

  @override
  State<RoeRoaDialog> createState() => _RoeRoaDialogState();
}

class _RoeRoaDialogState extends State<RoeRoaDialog> {
  final _utiliNetaController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Ingrese utilidad neta'),
      content: TextField(
        controller: _utiliNetaController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: 'Utilidad neta',
          border: OutlineInputBorder(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            final utiliNeta = double.tryParse(_utiliNetaController.text);
            if (utiliNeta == null) {
              return;
            }
            if (widget.totalEquity != null) {
              Provider.of<RoeProvider>(
                context,
                listen: false,
              ).setRoe(utiliNeta, widget.totalEquity!);
            } else if (widget.totalAssets != null) {
              Provider.of<RoaProvider>(
                context,
                listen: false,
              ).setRoa(utiliNeta, widget.totalAssets!);
            }
            Navigator.pop(context);
          },
          child: Text('Aceptar'),
        ),
      ],
    );
  }
}
