import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:financial_project/feature/auth/data/model/user_permission_auth_model.dart';
import 'package:financial_project/feature/income_statement/domain/model/income_statement.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

List<UserPermissionAuthModel> userLogedPermissions = [];

class Utils {
  static bool validateMasterCode(String code) {
    final masterCode = dotenv.env['CODE'];
    return code == masterCode;
  }

  static String hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  static bool verifyPassword(String password, String hashedPassword) {
    final hashedInput = hashPassword(password);
    return hashedInput == hashedPassword;
  }

  static bool hasClientAccountsPermissions() {
    final permissionNames = userLogedPermissions
        .map((permission) => permission.name)
        .toList();
    return permissionNames.contains('admin') ||
        permissionNames.contains('gestionar_clientes') ||
        permissionNames.contains('consultar_clientes');
  }

  static bool hasUserManagePermission() {
    final permissionNames = userLogedPermissions
        .map((permission) => permission.name)
        .toList();
    return (permissionNames.contains('admin') ||
        permissionNames.contains('user_management'));
  }

  static bool hasObligationsPermissions() {
    final permissionNames = userLogedPermissions
        .map((permission) => permission.name)
        .toList();
    return (permissionNames.contains('admin') ||
        permissionNames.contains('consultar_obligaciones') ||
        permissionNames.contains('gestionar_obligaciones'));
  }

  //TODO: Balance permissions!
  //TODO: Añadir cargo

  static bool hasIncomeStatementPermissions() {
    final permissionNames = userLogedPermissions
        .map((permission) => permission.name)
        .toList();
    return (permissionNames.contains('admin') ||
        permissionNames.contains('gestionar_estados'));
  }

  static DateTime transformDueDate(String dateString) {
    final dateParts = dateString.split('-');
    final year = DateTime.now().year;
    final month = int.parse(dateParts[0]);
    final day = int.parse(dateParts[1]);
    return DateTime(year, month, day);
  }

  static String dueDateString(DateTime dueDate) {
    return '${dueDate.day}-${dueDate.month}-${dueDate.year}';
  }

  static List<DateTime> createValidDates(int minDate, int maxDate) {
    List<DateTime> validDates = [];
    DateTime now = DateTime.now();

    while (minDate <= maxDate) {
      final date = DateTime(now.year, now.month, minDate);
      validDates.add(date);
      minDate++;
    }
    return validDates;
  }

  static String getActualMonthString() {
    final nowMonth = DateTime.now().month;
    switch (nowMonth) {
      case 1:
        return 'enero';
      case 2:
        return 'febrero';
      case 3:
        return 'marzo';
      case 4:
        return 'abril';
      case 5:
        return 'mayo';
      case 6:
        return 'junio';
      case 7:
        return 'julio';
      case 8:
        return 'agosto';
      case 9:
        return 'septiembre';
      case 10:
        return 'octubre';
      case 11:
        return 'noviembre';
      case 12:
        return 'diciembre';
      default:
        return 'N/A';
    }
  }

  static int monthStringToInt(String monthString) {
    switch (monthString) {
      case 'enero':
        return 1;
      case 'febrero':
        return 2;
      case 'marzo':
        return 3;
      case 'abril':
        return 4;
      case 'mayo':
        return 5;
      case 'junio':
        return 6;
      case 'julio':
        return 7;
      case 'agosto':
        return 8;
      case 'septiembre':
        return 9;
      case 'octubre':
        return 10;
      case 'noviembre':
        return 11;
      case 'diciembre':
        return 12;
      default:
        return 0;
    }
  }

  static String localDateString(DateTime date) {
    return '${date.day}-${date.month}-${date.year}';
  }

  static double utilityBrute(IncomeStatement incomeStatement) {
    return incomeStatement.netSales - incomeStatement.costOfSales;
  }

  static double utilityOp(IncomeStatement incomeStatement) {
    return utilityBrute(incomeStatement) -
        incomeStatement.salesExpenses -
        incomeStatement.adminExpenses -
        incomeStatement.depreciation;
  }

  static double utilityBefTax(IncomeStatement incomeStatement) {
    return utilityOp(incomeStatement) +
        incomeStatement.otherIncome -
        incomeStatement.financialExpenses;
  }

  static double utilityNet(IncomeStatement incomeStatement) {
    return utilityBefTax(incomeStatement) - incomeStatement.taxes;
  }
}
