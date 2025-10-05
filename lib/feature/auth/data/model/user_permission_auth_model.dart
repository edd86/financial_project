class UserPermissionAuthModel {
  final String name;

  UserPermissionAuthModel({required this.name});

  factory UserPermissionAuthModel.fromMap(Map<String, dynamic> map) {
    return UserPermissionAuthModel(name: map['name']);
  }
}
