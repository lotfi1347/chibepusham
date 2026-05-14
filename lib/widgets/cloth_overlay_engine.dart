import 'package:flutter/material.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

class ClothOverlayEngine extends StatelessWidget {
  final Pose? pose;
  final Image clothImage;

  const ClothOverlayEngine({
    super.key,
    required this.pose,
    required this.clothImage,
  });

  Offset _getPoint(PoseLandmarkType type) {
    final p = pose?.landmarks[type];
    if (p == null) return const Offset(0, 0);
    return Offset(p.x, p.y);
  }

  @override
  Widget build(BuildContext context) {
    if (pose == null) return const SizedBox();

    final leftShoulder = _getPoint(PoseLandmarkType.leftShoulder);
    final rightShoulder = _getPoint(PoseLandmarkType.rightShoulder);

    final width = (rightShoulder.dx - leftShoulder.dx).abs();

    return Positioned(
      left: leftShoulder.dx - width * 0.25,
      top: leftShoulder.dy - 20,
      child: Transform.scale(
        scale: 1.0,
        child: SizedBox(
          width: width * 1.5,
          child: clothImage,
        ),
      ),
    );
  }
}