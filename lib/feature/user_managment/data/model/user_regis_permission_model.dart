class UserRegisPermissionModel {
  final int id;
  final String name;
  final bool isActive;

  UserRegisPermissionModel({
    required this.id,
    required this.name,
    this.isActive = false,
  });

  factory UserRegisPermissionModel.fromMap(Map<String, dynamic> map) {
    return UserRegisPermissionModel(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }
}
