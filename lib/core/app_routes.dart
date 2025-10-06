import 'package:financial_project/feature/auth/presentation/page/login_page.dart';
import 'package:financial_project/feature/balance/presentation/pages/balance_home.dart';
import 'package:financial_project/feature/client_managment/domain/model/client.dart';
import 'package:financial_project/feature/client_managment/presentation/pages/client_form.dart';
import 'package:financial_project/feature/client_managment/presentation/pages/client_general_form.dart';
import 'package:financial_project/feature/client_managment/presentation/pages/client_page.dart';
import 'package:financial_project/feature/client_managment/presentation/pages/clients_home.dart';
import 'package:financial_project/feature/client_managment/presentation/pages/search_client_page.dart';
import 'package:financial_project/feature/home/presentation/page/home_page.dart';
import 'package:financial_project/feature/user_managment/presentation/pages/user_home_page.dart';
import 'package:financial_project/feature/user_registration/presentation/pages/user_registration_form.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String login = '/login';
  static const String home = '/home';
  static const String userRegistration = '/user-registration';
  static const String clientsHome = '/clients-home';
  static const String clientForm = '/client-form';
  static const String searchClient = '/search-client';
  static const String clientPage = '/client-page';
  static const String clientGeneralForm = '/client-general-form';
  static const String balanceHome = '/balance-home';
  static const String userHome = '/user-home';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (context) => const LoginPage());
      case home:
        return MaterialPageRoute(builder: (context) => const HomePage());
      case userRegistration:
        return MaterialPageRoute(
          builder: (context) => const UserRegistrationForm(),
        );
      case clientsHome:
        return MaterialPageRoute(builder: (context) => const ClientsHome());
      case clientForm:
        return MaterialPageRoute(builder: (context) => const ClientForm());
      case searchClient:
        return MaterialPageRoute(
          builder: (context) => const SearchClientPage(),
        );
      case clientPage:
        final client = settings.arguments as Client;
        return MaterialPageRoute(
          builder: (context) => ClientPage(client: client),
        );
      case clientGeneralForm:
        final client = settings.arguments as Client;
        return MaterialPageRoute(
          builder: (context) => ClientGeneralForm(client: client),
        );
      case balanceHome:
        return MaterialPageRoute(builder: (context) => const BalanceHome());
      case userHome:
        return MaterialPageRoute(builder: (context) => const UserHomePage());
      default:
        return null;
    }
  }
}
