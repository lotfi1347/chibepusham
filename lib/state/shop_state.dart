import 'package:flutter/material.dart';

class ShopState extends ChangeNotifier {
  final Set<String> _ownedItems = {};

  bool isOwned(String id) => _ownedItems.contains(id);

  void unlock(String id) {
    _ownedItems.add(id);
    notifyListeners();
  }
}