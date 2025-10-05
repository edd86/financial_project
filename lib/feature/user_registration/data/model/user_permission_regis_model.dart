class UserPermissionRegisModel {
  final int userId;
  final int permissionId;

  UserPermissionRegisModel({required this.userId, required this.permissionId});

  Map<String, dynamic> toMap() {
    return {'user_id': userId, 'permission_id': permissionId};
  }
}
