class UserRegisPermission {
  final int id;
  final String name;
  bool isActive;

  UserRegisPermission({
    required this.id,
    required this.name,
    this.isActive = false,
  });
}
