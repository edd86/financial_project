import 'package:financial_project/core/app_routes.dart';
import 'package:financial_project/core/global_widgets.dart';
import 'package:financial_project/feature/auth/data/repo/auth_repo_imp.dart';
import 'package:financial_project/feature/auth/domain/model/user_auth.dart';
import 'package:financial_project/feature/auth/presentation/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _spacer = SizedBox(height: 2.85.h);
  bool _isPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AuthProvider>();
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
        child: Column(
          children: [
            Text(
              'Bienvenido',
              style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            _spacer,
            Image.asset(
              'assets/img/oficina-contable.png',
              height: 35.h,
              fit: BoxFit.contain,
            ),
            _spacer,
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                label: GlobalWidgets.customLabelWidget(
                  Icons.person_2,
                  'Nombre de usuario',
                ),
              ),
            ),
            _spacer,
            TextField(
              controller: _passwordController,
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                label: GlobalWidgets.customLabelWidget(
                  Icons.lock,
                  'Contraseña',
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
            ),
            _spacer,
            ElevatedButton.icon(
              icon: Icon(Icons.login),
              label: Text('Iniciar Sesión'),
              onPressed: () async {
                if (_usernameController.text.isNotEmpty &&
                    _passwordController.text.isNotEmpty) {
                  final credentials = UserAuth(
                    username: _usernameController.text.trim(),
                    password: _passwordController.text.trim(),
                  );
                  final res = await AuthRepoImp().login(credentials);
                  if (res.success) {
                    _showMessage(
                      'Bienvenido ${res.data?.username}',
                      res.success,
                    );
                    provider.setUsername(res.data?.username ?? '');
                    _nextPage();
                  } else {
                    _showMessage(res.message, res.success);
                  }
                } else {
                  _showMessage('Ingrese sus credenciales', false);
                }
              },
            ),
            _spacer,
            TextButton(
              child: Text(
                'Registrar Usuario',
                style: TextStyle(color: Colors.purple),
              ),
              onPressed: () =>
                  Navigator.pushNamed(context, AppRoutes.userRegistration),
            ),
          ],
        ),
      ),
    );
  }

  void _nextPage() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.home,
      (route) => false,
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
}
