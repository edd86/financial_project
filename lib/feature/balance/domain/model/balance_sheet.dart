class BalanceSheet {
  final int? id;
  final int clientId;
  final DateTime balanceDate;
  final String period;
  final String status;
  final double totalAssets;
  final double totalLiabilities;
  final double totalEquity;

  BalanceSheet({
    this.id,
    required this.clientId,
    required this.balanceDate,
    required this.period,
    this.status = 'borrador',
    this.totalAssets = 0.0,
    this.totalLiabilities = 0.0,
    this.totalEquity = 0.0,
  });
}
