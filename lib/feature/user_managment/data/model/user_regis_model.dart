class UserRegisModel {
  final int? id;
  final String name;
  final String userName;
  final String email;
  final String phone;
  final String password;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserRegisModel({
    this.id,
    required this.name,
    required this.userName,
    required this.email,
    required this.phone,
    required this.password,
    this.createdAt,
    this.updatedAt,
  });

  factory UserRegisModel.fromMap(Map<String, dynamic> map) {
    return UserRegisModel(
      id: map['id'],
      name: map['name'],
      userName: map['username'],
      email: map['email'],
      phone: map['phone'],
      password: map['password'],
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'username': userName,
      'email': email,
      'phone': phone,
      'password': password,
      'created_at': createdAt!.toIso8601String(),
      'updated_at': updatedAt!.toIso8601String(),
    };
  }

  // Método copyWith para crear una nueva instancia con campos actualizados
  UserRegisModel copyWith({
    int? id,
    String? name,
    String? userName,
    String? email,
    String? phone,
    String? password,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserRegisModel(
      id: id ?? this.id,
      name: name ?? this.name,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
