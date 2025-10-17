import 'package:financial_project/core/utils.dart';

class ClientGeneralRegimeModel {
  final int? id;
  final String name;
  final String periodicity;
  final double percentage;
  final List<DateTime> duePatterns;

  ClientGeneralRegimeModel({
    this.id,
    required this.name,
    required this.periodicity,
    required this.percentage,
    required this.duePatterns,
  });

  factory ClientGeneralRegimeModel.fromMap(Map<String, dynamic> map) {
    final dueDateTemp = map['due_pattern'].toString().split(',');

    if (map['periodicity'] == 'mensual') {
      final validDates = Utils.createValidDates(
        int.parse(dueDateTemp[0]),
        int.parse(dueDateTemp[1]),
      );
      return ClientGeneralRegimeModel(
        id: map['id'],
        name: map['name'],
        periodicity: map['periodicity'],
        percentage: map['percentage'],
        duePatterns: validDates,
      );
    } else {
      List<DateTime> duePatternList = [];
      for (var date in dueDateTemp) {
        duePatternList.add(Utils.transformDueDate(date));
      }
      return ClientGeneralRegimeModel(
        id: map['id'],
        name: map['name'],
        periodicity: map['periodicity'],
        percentage: map['percentage'],
        duePatterns: duePatternList,
      );
    }
  }
}
