import '../models/cloth_item.dart';

class WardrobeState {
  ClothItem? shirt;
  ClothItem? pants;
  ClothItem? shoes;
  ClothItem? hat;
  ClothItem? glasses;

  void select(ClothItem item) {
    switch (item.type) {
      case ClothType.shirt:
        shirt = item;
        break;
      case ClothType.pants:
        pants = item;
        break;
      case ClothType.shoes:
        shoes = item;
        break;
      case ClothType.hat:
        hat = item;
        break;
      case ClothType.glasses:
        glasses = item;
        break;
    }
  }
}