class UserRegisModel {
  final int? id;
  final String name;
  final String userName;
  final String email;
  final String phone;
  final String password;

  UserRegisModel({
    this.id,
    required this.name,
    required this.userName,
    required this.email,
    required this.phone,
    required this.password,
  });

  factory UserRegisModel.fromMap(Map<String, dynamic> map) {
    return UserRegisModel(
      id: map['id'],
      name: map['name'],
      userName: map['username'],
      email: map['email'],
      phone: map['phone'],
      password: map['password'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'username': userName,
      'email': email,
      'phone': phone,
      'password': password,
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
  }) {
    return UserRegisModel(
      id: id ?? this.id,
      name: name ?? this.name,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
    );
  }
}
