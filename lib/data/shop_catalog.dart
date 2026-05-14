import '../models/shop_item.dart';

final List<ShopItem> shopItems = [
  ShopItem(
    id: "shirt1",
    name: "Basic Shirt",
    asset: "assets/clothes/shirts/shirt1.png",
    isPremium: false,
    price: 0,
  ),
  ShopItem(
    id: "shirt2",
    name: "Luxury Shirt",
    asset: "assets/clothes/shirts/shirt2.png",
    isPremium: true,
    price: 300,
  ),
  ShopItem(
    id: "pants1",
    name: "Basic Pants",
    asset: "assets/clothes/pants/pants1.png",
    isPremium: false,
    price: 0,
  ),
  ShopItem(
    id: "pants2",
    name: "Designer Pants",
    asset: "assets/clothes/pants/pants2.png",
    isPremium: true,
    price: 400,
  ),
];