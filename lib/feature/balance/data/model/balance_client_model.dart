import 'package:financial_project/feature/balance/data/model/balance_sheet_model.dart';

class BalanceClientModel {
  final int id;
  final String businessName;
  final String nitCi;
  final BalanceSheetModel? balanceSheet;

  BalanceClientModel({
    required this.id,
    required this.businessName,
    required this.nitCi,
    this.balanceSheet,
  });

  factory BalanceClientModel.fromMap(Map<String, dynamic> map) {
    return BalanceClientModel(
      id: map['id'],
      businessName: map['business_name'],
      nitCi: map['tax_id'],
      balanceSheet: map['balance_sheet'] != null
          ? BalanceSheetModel.fromMap(map['balance_sheet'])
          : null,
    );
  }
}
