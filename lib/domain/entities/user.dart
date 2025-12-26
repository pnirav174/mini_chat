class User {
  final String id;
  final String name;

  final bool isOnline;
  final String? lastActive;

  User({
    required this.id,
    required this.name,
    this.isOnline = false,
    this.lastActive,
  });

  String get initials {
    if (name.isEmpty) return "?";

    return name[0].toUpperCase();
  }
}
