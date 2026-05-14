import 'package:flutter/material.dart';
import '../ar/ar_v3_engine.dart';
import 'wardrobe_panel.dart';
import '../state/wardrobe_state.dart';
import '../models/cloth_item.dart';

class V5Home extends StatefulWidget {
  const V5Home({super.key});

  @override
  State<V5Home> createState() => _V5HomeState();
}

class _V5HomeState extends State<V5Home> {
  final WardrobeState wardrobe = WardrobeState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ARV3Engine(),
          ),

          WardrobePanel(
            onSelect: (item) {
              setState(() {
                wardrobe.select(item);
              });
            },
          ),
        ],
      ),
    );
  }
}