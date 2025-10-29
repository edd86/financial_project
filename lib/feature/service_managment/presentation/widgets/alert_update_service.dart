import 'package:financial_project/core/global_widgets.dart';
import 'package:financial_project/core/response.dart';
import 'package:financial_project/feature/service_managment/domain/model/service_entity.dart';
import 'package:financial_project/feature/service_managment/presentation/provider/services_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AlertUpdateService extends StatefulWidget {
  final ServiceEntity service;
  const AlertUpdateService({super.key, required this.service});

  @override
  State<AlertUpdateService> createState() => _AlertUpdateServiceState();
}

class _AlertUpdateServiceState extends State<AlertUpdateService> {
  final _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ServicesProvider>(context);
    _amountController.text = widget.service.amount.toString();

    return AlertDialog(
      title: Text(widget.service.name.toUpperCase()),
      content: TextField(
        controller: _amountController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(labelText: 'Nuevo monto'),
      ),
      actions: [
        TextButton(
          child: Text('Cancelar'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        TextButton(
          onPressed: () async {
            final newAmount = double.tryParse(_amountController.text);
            if (newAmount == null) {
              final error = Response.error('Monto inválido');
              _showMessage(error);
            }
            final updatedService = ServiceEntity(
              id: widget.service.id,
              name: widget.service.name,
              amount: newAmount!,
            );
            final res = await provider.updateService(updatedService);
            if (res.success) {
              _backPage();
            }
            _showMessage(res);
          },
          child: Text('Aceptar'),
        ),
      ],
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
