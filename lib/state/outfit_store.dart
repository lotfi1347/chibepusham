import '../models/outfit.dart';

class OutfitStore {
  final List<Outfit> savedOutfits = [];

  void saveOutfit(Outfit outfit) {
    savedOutfits.add(outfit);
  }

  void remove(int index) {
    savedOutfits.removeAt(index);
  }
}