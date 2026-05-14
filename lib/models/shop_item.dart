class ShopItem {
  final String id;
  final String name;
  final String asset;
  final bool isPremium;
  final int price; // cents or yen

  const ShopItem({
    required this.id,
    required this.name,
    required this.asset,
    required this.isPremium,
    required this.price,
  });
}