class UserAuthModel {
  int? id;
  final String username;
  final String password;

  UserAuthModel({this.id, required this.username, required this.password});

  factory UserAuthModel.fromMap(Map<String, dynamic> map) {
    return UserAuthModel(
      id: map['id'],
      username: map['name'],
      password: map['password'],
    );
  }

  UserAuthModel copyWith({int? id, String? username, String? password}) {
    return UserAuthModel(
      id: id ?? this.id,
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }
}
