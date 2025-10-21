import 'package:financial_project/core/global_widgets.dart';
import 'package:financial_project/feature/client_managment/data/repo/client_repo_impl.dart';
import 'package:financial_project/feature/client_managment/domain/model/client.dart';
import 'package:financial_project/feature/client_managment/presentation/provider/clients_home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ClientForm extends StatefulWidget {
  const ClientForm({super.key});

  @override
  State<ClientForm> createState() => _ClientFormState();
}

class _ClientFormState extends State<ClientForm> {
  final _formKey = GlobalKey<FormState>();
  final _reasonNameController = TextEditingController();
  final _nitCiController = TextEditingController();
  final _capitalController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _productPriceController = TextEditingController();
  final _spacer = SizedBox(height: 2.35.h);
  String? regimenSelected;
  String? activitySelected;
  final List<String> _regimens = ['Simplificado', 'General'];
  final List<String> _actives = ['Artesanias', 'Minorista', 'Vivandero'];

  bool _isActivityDropdownEnabled() => regimenSelected == 'Simplificado';
  bool _isProductPriceEnabled() => regimenSelected == 'Simplificado';

  void _cleanDisabledFields() {
    if (!_isProductPriceEnabled()) {
      _productPriceController.clear();
    }
    if (!_isActivityDropdownEnabled()) {
      activitySelected = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final clientsHomeProvider = context.watch<ClientsHomeProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro de cliente'),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 3.85.h, horizontal: 9.87.w),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _reasonNameController,
                decoration: InputDecoration(
                  label: GlobalWidgets.customLabelWidget(
                    Icons.business_center_outlined,
                    'Nombre razón social',
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el nombre razón social';
                  }
                  return null;
                },
              ),
              _spacer,
              TextFormField(
                controller: _nitCiController,
                decoration: InputDecoration(
                  label: GlobalWidgets.customLabelWidget(
                    Icons.person_outlined,
                    'NIT o CI',
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el NIT o CI';
                  }
                  return null;
                },
              ),
              _spacer,
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 2.5.w),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10.sp),
                ),
                child: DropdownButton<String>(
                  value: regimenSelected,
                  hint: Text('Seleccione el régimen'),
                  isExpanded: true,
                  underline: SizedBox(),
                  items: _regimens
                      .map(
                        (regimen) => DropdownMenuItem<String>(
                          value: regimen,
                          child: Text(regimen),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        regimenSelected = value;
                      });
                      _cleanDisabledFields();
                    }
                  },
                ),
              ),
              _spacer,
              TextFormField(
                controller: _capitalController,
                decoration: InputDecoration(
                  label: GlobalWidgets.customLabelWidget(
                    Icons.monetization_on,
                    'Monto de capital',
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el monto de capital';
                  }
                  final capital = double.tryParse(value);
                  if (capital == null) {
                    return 'Por favor ingrese un monto válido';
                  }
                  if (regimenSelected == 'Simplificado' &&
                      (capital < 12001 || capital > 60000)) {
                    return 'El capital del régimen debe estar entre 12001 y 60000';
                  }
                  return null;
                },
              ),
              _spacer,
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 2.5.w),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10.sp),
                ),
                child: DropdownButton<String>(
                  value: activitySelected,
                  hint: Text('Seleccione la actividad'),
                  isExpanded: true,
                  underline: SizedBox(),
                  items: _isActivityDropdownEnabled()
                      ? _actives
                            .map(
                              (activity) => DropdownMenuItem<String>(
                                value: activity,
                                child: Text(activity),
                              ),
                            )
                            .toList()
                      : null,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        activitySelected = value;
                      });
                    }
                  },
                ),
              ),
              _spacer,
              TextFormField(
                controller: _descriptionController,
                maxLength: 70,
                decoration: InputDecoration(
                  label: GlobalWidgets.customLabelWidget(
                    Icons.comment,
                    'Descripción',
                  ),
                ),
                maxLines: 2,
              ),
              _spacer,
              TextFormField(
                controller: _productPriceController,
                decoration: InputDecoration(
                  label: GlobalWidgets.customLabelWidget(
                    Icons.price_change,
                    'Precio Promedio de productos',
                  ),
                  fillColor: _isProductPriceEnabled()
                      ? null
                      : Colors.grey.shade200,
                  filled: !_isProductPriceEnabled(),
                  enabled: _isProductPriceEnabled(),
                  helperText:
                      !_isProductPriceEnabled() && regimenSelected != null
                      ? 'Solo se permite si el régimen es Simplificado'
                      : null,
                ),
                validator: (value) {
                  if (regimenSelected == 'simplificado' &&
                      (value == null || value.isEmpty)) {
                    if (double.tryParse(value!) == null) {
                      return 'Por favor ingrese un precio válido';
                    }
                    return 'Por favor ingrese el precio promedio de productos';
                  }
                  return null;
                },
              ),
              _spacer,
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  label: Text('Registrar Cliente'),
                  icon: Icon(Icons.save),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final client = Client(
                        businessName: _reasonNameController.text,
                        taxId: _nitCiController.text,
                        capital: double.parse(_capitalController.text),
                        activity: activitySelected?.toLowerCase(),
                        regimeType: regimenSelected!.toLowerCase(),
                        description: _descriptionController.text,
                        baseProductPrice: _isProductPriceEnabled()
                            ? double.parse(_productPriceController.text)
                            : null,
                      );
                      final response = await ClientRepoImpl().addClient(client);
                      if (response.success) {
                        clientsHomeProvider.setClientsHome();
                        _showMessage(response.message, response.success);
                        _backPage();
                      } else {
                        _showMessage(response.message, response.success);
                      }
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

  void _showMessage(String message, bool success) {
    ScaffoldMessenger.of(context).showSnackBar(
      GlobalWidgets.customSnackBar(
        message,
        success ? Colors.deepPurple : Colors.redAccent,
      ),
    );
  }

  void _backPage() {
    Navigator.pop(context);
  }
}
