import 'package:financial_project/core/app_routes.dart';
import 'package:financial_project/db/helper/db_helper.dart';
import 'package:financial_project/feature/auth/presentation/provider/auth_provider.dart';
import 'package:financial_project/feature/balance/presentation/provider/balance_assets_provider.dart';
import 'package:financial_project/feature/balance/presentation/provider/balance_sheet_list_provider.dart';
import 'package:financial_project/feature/balance/presentation/provider/clients_list_provider.dart';
import 'package:financial_project/feature/client_managment/presentation/provider/clients_home_provider.dart';
import 'package:financial_project/feature/client_managment/presentation/provider/clients_obligations_provider.dart';
import 'package:financial_project/feature/client_managment/presentation/provider/search_client_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper().database;
  await dotenv.load(fileName: ".env");
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
        ChangeNotifierProvider<ClientsHomeProvider>(
          create: (_) => ClientsHomeProvider(),
        ),
        ChangeNotifierProvider<SearchClientProvider>(
          create: (_) => SearchClientProvider(),
        ),
        ChangeNotifierProvider<ClientsObligationsProvider>(
          create: (_) => ClientsObligationsProvider(),
        ),
        ChangeNotifierProvider<BalanceSheetListProvider>(
          create: (_) => BalanceSheetListProvider(),
        ),
        ChangeNotifierProvider<ClientsListProvider>(
          create: (_) => ClientsListProvider(),
        ),
        ChangeNotifierProvider<BalanceAssetsProvider>(
          create: (_) => BalanceAssetsProvider(),
        ),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, screenType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: AppRoutes.onGenerateRoute,
          initialRoute: AppRoutes.login,
        );
      },
    );
  }
}
