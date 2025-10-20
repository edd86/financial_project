import 'package:email_validator/email_validator.dart';
import 'package:financial_project/feature/user_managment/domain/model/user_regis.dart';
import 'package:financial_project/feature/user_managment/presentation/provider/user_list_provider.dart'
    show UserListProvider;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class UserUpdateBottomSheet extends StatefulWidget {
  final UserRegis user;
  const UserUpdateBottomSheet({required this.user, super.key});

  @override
  State<UserUpdateBottomSheet> createState() => _UserUpdateBottomSheetState();
}

class _UserUpdateBottomSheetState extends State<UserUpdateBottomSheet> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _passwordController;
  late TextEditingController _usernameController;
  final _spacer = SizedBox(height: 1.82.h);
  bool _obscurePassword = true;
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.name);
    _emailController = TextEditingController(text: widget.user.email);
    _phoneController = TextEditingController(text: widget.user.phone);
    _passwordController = TextEditingController();
    _usernameController = TextEditingController(text: widget.user.userName);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65.h,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 1.82.h),
        child: Form(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Editar usuario ${widget.user.userName}',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.deepPurple),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              _spacer,
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Nombre completo',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
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
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Correo electrónico',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
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
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Número de teléfono',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
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
                keyboardType: TextInputType.visiblePassword,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: 'Nueva contraseña',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese su nueva contraseña';
                  }
                  return null;
                },
              ),
              _spacer,
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Nuevo nombre de usuario',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese su nuevo nombre de usuario';
                  }
                  return null;
                },
              ),
              _spacer,
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    final userToUpdate = UserRegis(
                      name: _nameController.text,
                      userName: _usernameController.text,
                      email: _emailController.text,
                      phone: _phoneController.text,
                      password: _passwordController.text,
                    );
                    Provider.of<UserListProvider>(
                      context,
                      listen: false,
                    ).updateUsers(userToUpdate);
                  },
                  child: Text('Actualizar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
