class BalanceSheetModel {
  final int? id;
  final int clientId;
  final DateTime balanceDate;
  final String period;
  final String status;
  final double totalAssets;
  final double totalLiabilities;
  final double totalEquity;
  final String createdAt;
  final String updatedAt;

  BalanceSheetModel({
    this.id,
    required this.clientId,
    required this.balanceDate,
    required this.period,
    required this.status,
    required this.totalAssets,
    required this.totalLiabilities,
    required this.totalEquity,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Convierte un Map (fila de SQLite) en un objeto BalanceSheet
  factory BalanceSheetModel.fromMap(Map<String, dynamic> map) {
    return BalanceSheetModel(
      id: map['id'],
      clientId: map['client_id'],
      balanceDate: DateTime.parse(map['balance_date']),
      period: map['period'],
      status: map['status'],
      totalAssets: map['total_assets'],
      totalLiabilities: map['total_liabilities'],
      totalEquity: map['total_equity'],
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
    );
  }

  /// Convierte el objeto BalanceSheet en un Map (para insertar o actualizar)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'client_id': clientId,
      'balance_date': balanceDate.toIso8601String(),
      'period': period,
      'status': status,
      'total_assets': totalAssets,
      'total_liabilities': totalLiabilities,
      'total_equity': totalEquity,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  /// Crea una copia del objeto con algunos valores modificados
  BalanceSheetModel copyWith({
    int? id,
    int? clientId,
    String? balanceDate,
    String? period,
    String? status,
    double? totalAssets,
    double? totalLiabilities,
    double? totalEquity,
    String? createdAt,
    String? updatedAt,
  }) {
    return BalanceSheetModel(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      balanceDate: DateTime.parse(
        balanceDate ?? this.balanceDate.toIso8601String(),
      ),
      period: period ?? this.period,
      status: status ?? this.status,
      totalAssets: totalAssets ?? this.totalAssets,
      totalLiabilities: totalLiabilities ?? this.totalLiabilities,
      totalEquity: totalEquity ?? this.totalEquity,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
