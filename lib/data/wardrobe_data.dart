import '../models/cloth_item.dart';

class WardrobeData {
  static final List<ClothItem> items = [
    ClothItem(
      id: "shirt_1",
      asset: "assets/clothes/shirts/shirt1.png",
      title: "Blue Shirt",
      type: ClothType.shirt,
    ),
    ClothItem(
      id: "pants_1",
      asset: "assets/clothes/pants/pants1.png",
      title: "Black Pants",
      type: ClothType.pants,
    ),
    ClothItem(
      id: "shoes_1",
      asset: "assets/clothes/shoes/shoes1.png",
      title: "White Shoes",
      type: ClothType.shoes,
    ),
    ClothItem(
      id: "hat_1",
      asset: "assets/clothes/hats/hat1.png",
      title: "Cap",
      type: ClothType.hat,
    ),
    ClothItem(
      id: "glasses_1",
      asset: "assets/clothes/glasses/glasses1.png",
      title: "Glasses",
      type: ClothType.glasses,
    ),
  ];
}