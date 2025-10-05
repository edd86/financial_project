import 'package:financial_project/feature/balance/data/model/balance_equity_model.dart';
import 'package:financial_project/feature/balance/domain/model/balance_equity.dart';

class BalanceEquityMapper {
  static BalanceEquityModel toModel(BalanceEquity balanceEquity) {
    return BalanceEquityModel(
      id: balanceEquity.id,
      balanceSheetId: balanceEquity.balanceSheetId,
      name: balanceEquity.name,
      category: balanceEquity.category,
      amount: balanceEquity.amount,
      description: balanceEquity.description,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  static BalanceEquity toEntity(BalanceEquityModel balanceEquityModel) {
    return BalanceEquity(
      id: balanceEquityModel.id,
      balanceSheetId: balanceEquityModel.balanceSheetId,
      name: balanceEquityModel.name,
      category: balanceEquityModel.category,
      amount: balanceEquityModel.amount,
      description: balanceEquityModel.description,
    );
  }
}
