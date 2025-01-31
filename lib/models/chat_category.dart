class ChatCategory {
  final String id;
  final String name;
  bool isActive;

  ChatCategory({
    required this.id,
    required this.name,
    this.isActive = true,
  });

  ChatCategory copyWith({
    String? id,
    String? name,
    bool? isActive,
  }) {
    return ChatCategory(
      id: id ?? this.id,
      name: name ?? this.name,
      isActive: isActive ?? this.isActive,
    );
  }
}
