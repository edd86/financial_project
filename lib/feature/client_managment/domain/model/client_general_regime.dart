class ClientGeneralRegime {
  final int? id;
  final String name;
  final String periodicity;
  final double percentage;
  final List<DateTime> duePatterns;

  ClientGeneralRegime({
    this.id,
    required this.name,
    required this.periodicity,
    required this.percentage,
    required this.duePatterns,
  });
}
