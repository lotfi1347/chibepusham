class ClothItem {
  final String id;
  final String asset;
  final String title;
  final ClothType type;

  const ClothItem({
    required this.id,
    required this.asset,
    required this.title,
    required this.type,
  });
}

enum ClothType {
  shirt,
  pants,
  shoes,
  hat,
  glasses,
}