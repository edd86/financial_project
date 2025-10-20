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
}
