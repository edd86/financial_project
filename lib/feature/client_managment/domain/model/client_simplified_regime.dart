class ClientSimplifiedRegime {
  final int? id;
  final String category;
  final double minCapital;
  final double maxCapital;
  final double amount;
  final List<DateTime> duePattern;

  ClientSimplifiedRegime({
    this.id,
    required this.category,
    required this.minCapital,
    required this.maxCapital,
    required this.amount,
    required this.duePattern,
  });
}
