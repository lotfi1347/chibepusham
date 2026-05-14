import 'package:flutter/material.dart';
import '../state/outfit_store.dart';
import '../models/outfit.dart';

class V6ControlPanel extends StatelessWidget {
  final Outfit currentOutfit;
  final OutfitStore store;

  const V6ControlPanel({
    super.key,
    required this.currentOutfit,
    required this.store,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      padding: const EdgeInsets.all(10),
      color: Colors.black87,
      child: Row(
        children: [
          ElevatedButton(
            onPressed: () {
              store.saveOutfit(currentOutfit);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Outfit Saved")),
              );
            },
            child: const Text("Save Outfit"),
          ),

          const SizedBox(width: 10),

          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Added to Cart")),
              );
            },
            child: const Text("Add to Cart"),
          ),
        ],
      ),
    );
  }
}