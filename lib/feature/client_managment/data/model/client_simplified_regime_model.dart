import 'package:financial_project/core/utils.dart';

class ClientSimplifiedRegimeModel {
  final int? id;
  final String category;
  final double minCapital;
  final double maxCapital;
  final double amount;
  final List<DateTime> duePattern;

  ClientSimplifiedRegimeModel({
    this.id,
    required this.category,
    required this.minCapital,
    required this.maxCapital,
    required this.amount,
    required this.duePattern,
  });

  factory ClientSimplifiedRegimeModel.fromMap(Map<String, dynamic> map) {
    final datesPattern = map['due_pattern'].toString().split(',');

    List<DateTime> duePatternList = [];
    for (var date in datesPattern) {
      duePatternList.add(Utils.transformDueDate(date));
    }

    return ClientSimplifiedRegimeModel(
      id: map['id'],
      category: map['category_number'],
      minCapital: map['min_capital'],
      maxCapital: map['max_capital'],
      amount: map['taxable_amount'],
      duePattern: duePatternList,
    );
  }
}
