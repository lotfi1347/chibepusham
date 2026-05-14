import 'dart:ui';
import 'package:flutter/material.dart';

class SegmentationOverlay extends StatelessWidget {
  final Widget child;

  const SegmentationOverlay({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 🌫 Background soft blur layer (fake depth separation)
        Positioned.fill(
          child: Container(
            color: Colors.transparent,
          ),
        ),

        // 👤 Foreground content
        child,
      ],
    );
  }
}