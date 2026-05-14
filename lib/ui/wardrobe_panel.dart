import 'package:flutter/material.dart';
import '../data/wardrobe_data.dart';
import '../models/cloth_item.dart';

class WardrobePanel extends StatelessWidget {
  final Function(ClothItem item) onSelect;

  const WardrobePanel({
    super.key,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: WardrobeData.items.length,
        itemBuilder: (context, i) {
          final item = WardrobeData.items[i];

          return GestureDetector(
            onTap: () => onSelect(item),
            child: Container(
              width: 120,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    item.asset,
                    width: 60,
                    height: 60,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.title,
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}