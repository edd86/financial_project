import 'package:financial_project/feature/income_statement/domain/model/income_statement.dart';

class FianancialRatios {
  static double liquidityRatio(double totalAssets, double totalLiabilities) {
    return totalAssets / totalLiabilities;
  }

  static double debtRatio(double totalLiabilities, double totalEquity) {
    return totalLiabilities / totalEquity;
  }

  static double quickRatio(
    double totalAssets,
    double inventory,
    double totalLiabilities,
  ) {
    return (totalAssets - inventory) / totalLiabilities;
  }

  static double debtEquityRatio(double totalLiabilities, double totalEquity) {
    return totalLiabilities / totalEquity;
  }

  static double roe(double utilNeta, double equity) {
    return utilNeta / equity;
  }

  static double roa(double utilNeta, double assets) {
    return utilNeta / assets;
  }

  static double grossProfit(double netSales, double costOfSales) =>
      netSales - costOfSales;

  static double operatingExpenses(
    double salesExpenses,
    double adminExpenses,
    double depreciation,
  ) => salesExpenses + adminExpenses + depreciation;

  static double operatingProfit(double grossProfit, double operatingExpenses) =>
      grossProfit - operatingExpenses;

  static double profitBeforeTax(
    double operatingProfit,
    double otherIncome,
    double financialExpenses,
  ) => operatingProfit + otherIncome - financialExpenses;

  static double netIncome(double profileBeforeTax, double taxes) =>
      profileBeforeTax - taxes;

  //Margen de utilidad bruta
  static double grossMargin(IncomeStatement incomeStatement) {
    if (incomeStatement.netSales == 0) return 0.0;
    return (grossProfit(incomeStatement.netSales, incomeStatement.costOfSales) /
            incomeStatement.netSales) *
        100;
  }

  //Margen de utilidad operativa
  static double operatingMargin(IncomeStatement incomeStatement) {
    if (incomeStatement.netSales == 0) return 0.0;
    return (operatingProfit(
              grossProfit(
                incomeStatement.netSales,
                incomeStatement.costOfSales,
              ),
              operatingExpenses(
                incomeStatement.salesExpenses,
                incomeStatement.adminExpenses,
                incomeStatement.depreciation,
              ),
            ) /
            incomeStatement.netSales) *
        100;
  }

  //Margen de utilidad Neta
  static double netMargin(IncomeStatement incomeStatement) {
    if (incomeStatement.netSales == 0) return 0.0;
    return (netIncome(
              profitBeforeTax(
                operatingProfit(
                  grossProfit(
                    incomeStatement.netSales,
                    incomeStatement.costOfSales,
                  ),
                  operatingExpenses(
                    incomeStatement.salesExpenses,
                    incomeStatement.adminExpenses,
                    incomeStatement.depreciation,
                  ),
                ),
                incomeStatement.otherIncome,
                incomeStatement.financialExpenses,
              ),
              incomeStatement.taxes,
            ) /
            incomeStatement.netSales) *
        100;
  }

  //Ratio de cobertura de interes
  static double interesCoverageRatio(IncomeStatement incomeStatement) {
    if (incomeStatement.financialExpenses == 0) {
      return (operatingProfit(
                grossProfit(
                  incomeStatement.netSales,
                  incomeStatement.costOfSales,
                ),
                operatingExpenses(
                  incomeStatement.salesExpenses,
                  incomeStatement.adminExpenses,
                  incomeStatement.depreciation,
                ),
              ) >
              0
          ? double.infinity
          : 0.0);
    }
    if (operatingProfit(
          grossProfit(incomeStatement.netSales, incomeStatement.costOfSales),
          operatingExpenses(
            incomeStatement.salesExpenses,
            incomeStatement.adminExpenses,
            incomeStatement.depreciation,
          ),
        ) <=
        0) {
      return 0.0;
    }
    return operatingProfit(
          grossProfit(incomeStatement.netSales, incomeStatement.costOfSales),
          operatingExpenses(
            incomeStatement.salesExpenses,
            incomeStatement.adminExpenses,
            incomeStatement.depreciation,
          ),
        ) /
        incomeStatement.financialExpenses;
  }
}
