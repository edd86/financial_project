import 'package:financial_project/feature/balance/data/model/balance_liability_model.dart';
import 'package:financial_project/feature/balance/domain/model/balance_liability.dart';

class BalanceLiabilityMapper {
  static BalanceLiabilityModel toModel(BalanceLiability balanceLiability) {
    return BalanceLiabilityModel(
      id: balanceLiability.id,
      balanceSheetId: balanceLiability.balanceSheetId,
      name: balanceLiability.name,
      type: balanceLiability.type,
      category: balanceLiability.category,
      amount: balanceLiability.amount,
      description: balanceLiability.description,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  static BalanceLiability toEntity(
    BalanceLiabilityModel balanceLiabilityModel,
  ) {
    return BalanceLiability(
      id: balanceLiabilityModel.id,
      balanceSheetId: balanceLiabilityModel.balanceSheetId,
      name: balanceLiabilityModel.name,
      type: balanceLiabilityModel.type,
      category: balanceLiabilityModel.category,
      amount: balanceLiabilityModel.amount,
      description: balanceLiabilityModel.description,
    );
  }
}
