import 'package:financial_project/feature/income_statement/data/model/income_statement_model.dart';
import 'package:financial_project/feature/income_statement/domain/model/income_statement.dart';

class IncomeStatementMapper {
  static IncomeStatementModel toModel(IncomeStatement entity) {
    return IncomeStatementModel(
      id: entity.id,
      clientId: entity.clientId,
      periodStartDate: entity.periodStartDate,
      periodEndDate: entity.periodEndDate,
      netSales: entity.netSales,
      costOfSales: entity.costOfSales,
      salesExpenses: entity.salesExpenses,
      adminExpenses: entity.adminExpenses,
      depreciation: entity.depreciation,
      otherIncome: entity.otherIncome,
      financialExpenses: entity.financialExpenses,
      taxes: entity.taxes,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  static IncomeStatement toEntity(IncomeStatementModel model) {
    return IncomeStatement(
      id: model.id,
      clientId: model.clientId,
      periodStartDate: model.periodStartDate,
      periodEndDate: model.periodEndDate,
      netSales: model.netSales,
      costOfSales: model.costOfSales,
      salesExpenses: model.salesExpenses,
      adminExpenses: model.adminExpenses,
      depreciation: model.depreciation,
      otherIncome: model.otherIncome,
      financialExpenses: model.financialExpenses,
      taxes: model.taxes,
      createdAt: model.createdAt,
      updatedAt: model.updatedAt,
    );
  }
}
