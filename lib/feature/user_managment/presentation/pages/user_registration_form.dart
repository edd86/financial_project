import 'package:email_validator/email_validator.dart';
import 'package:financial_project/core/global_widgets.dart';
import 'package:financial_project/core/utils.dart';
import 'package:financial_project/feature/user_managment/data/repo/user_regis_repo_imp.dart';
import 'package:financial_project/feature/user_managment/domain/model/user_regis.dart';
import 'package:financial_project/feature/user_managment/domain/model/user_regis_permission.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class UserRegistrationForm extends StatefulWidget {
  const UserRegistrationForm({super.key});

  @override
  State<UserRegistrationForm> createState() => _UserRegistrationFormState();
}

class _UserRegistrationFormState extends State<UserRegistrationForm> {
  List<UserRegisPermission>? _permissions;
  final List<UserRegisPermission> _selectedPermissions = [];

  @override
  void initState() {
    super.initState();
    _loadingPermissions();
  }

  void _loadingPermissions() async {
    final permissionResponse = await UserRegisRepoImp().getPermissions();
    setState(() {
      _permissions = permissionResponse.data;
    });
  }

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _rolController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _adminCodeController = TextEditingController();
  final _spacer = SizedBox(height: 2.75.h);
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nuevo Usuario'),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 13.75.w, vertical: 2.75.h),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  label: GlobalWidgets.customLabelWidget(
                    Icons.person,
                    'Nombre completo',
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese su nombre completo';
                  }
                  return null;
                },
              ),
              _spacer,
              TextFormField(
                controller: _usernameController,
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.none,
                decoration: InputDecoration(
                  label: GlobalWidgets.customLabelWidget(
                    Icons.person_2,
                    'Nombre de usuario',
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese su nombre de usuario';
                  }
                  return null;
                },
              ),
              _spacer,
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                textCapitalization: TextCapitalization.none,
                decoration: InputDecoration(
                  label: GlobalWidgets.customLabelWidget(
                    Icons.email,
                    'Correo electrónico',
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese su correo electrónico';
                  }
                  if (!EmailValidator.validate(value)) {
                    return 'Por favor, ingrese un correo electrónico válido';
                  }
                  return null;
                },
              ),
              _spacer,
              TextFormField(
                controller: _rolController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  label: GlobalWidgets.customLabelWidget(
                    Icons.person_3_rounded,
                    'Cargo o Rol',
                  ),
                ),
              ),
              _spacer,
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  label: GlobalWidgets.customLabelWidget(
                    Icons.phone,
                    'Número de teléfono',
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese su número de teléfono';
                  }
                  return null;
                },
              ),
              _spacer,
              TextFormField(
                controller: _passwordController,
                obscureText: !_isPasswordVisible,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  label: GlobalWidgets.customLabelWidget(
                    Icons.lock,
                    'Contraseña',
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese su contraseña';
                  }
                  return null;
                },
              ),
              _spacer,
              TextFormField(
                controller: _adminCodeController,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  label: GlobalWidgets.customLabelWidget(
                    Icons.code,
                    'Código maestro',
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese el código maestro';
                  }
                  if (!Utils.validateMasterCode(value)) {
                    return 'Código maestro incorrecto';
                  }
                  return null;
                },
              ),
              _spacer,
              Text(
                'Seleccione los permisos que desea asignar al usuario',
                style: TextStyle(fontSize: 13.sp),
              ),
              (_permissions == null)
                  ? CircularProgressIndicator()
                  : SizedBox(
                      height: 23.8.h,
                      child: GridView.count(
                        crossAxisCount: 3,
                        shrinkWrap: true,
                        children: _permissions!
                            .map(
                              (permission) => Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Checkbox(
                                    value: permission.isActive,
                                    onChanged: (value) {
                                      if (value!) {
                                        _selectedPermissions.add(permission);
                                      } else {
                                        _selectedPermissions.remove(permission);
                                      }
                                      setState(() {
                                        permission.isActive = value;
                                      });
                                    },
                                  ),
                                  SizedBox(
                                    width: 15.5.w,
                                    child: Text(
                                      permission.name,
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 13.sp),
                                    ),
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  label: Text('Registrar usuario'),
                  icon: Icon(Icons.save),
                  onPressed: () async {
                    if (_formKey.currentState!.validate() &&
                        _selectedPermissions.isNotEmpty) {
                      final userRegis = UserRegis(
                        name: _nameController.text,
                        userName: _usernameController.text,
                        email: _emailController.text,
                        rol: _rolController.text,
                        phone: _phoneController.text,
                        password: _passwordController.text,
                      );
                      final response = await UserRegisRepoImp().registerUser(
                        userRegis,
                        _selectedPermissions,
                      );
                      if (response.success) {
                        _showMessage(response.message, response.success);
                        _backPage();
                      } else {
                        _showMessage(response.message, response.success);
                      }
                    } else {
                      _showMessage('Seleccione al menos un permiso', false);
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
