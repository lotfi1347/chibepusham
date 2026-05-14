import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'package:flutter/material.dart';

class PoseMapper {
  static Offset torsoCenter(Pose pose) {
    final left = pose.landmarks[PoseLandmarkType.leftShoulder];
    final right = pose.landmarks[PoseLandmarkType.rightShoulder];

    if (left == null || right == null) {
      return const Offset(200, 200);
    }

    return Offset(
      (left.x + right.x) / 2,
      (left.y + right.y) / 2,
    );
  }

  static double shoulderWidth(Pose pose) {
    final left = pose.landmarks[PoseLandmarkType.leftShoulder];
    final right = pose.landmarks[PoseLandmarkType.rightShoulder];

    if (left == null || right == null) return 200;

    return (left.x - right.x).abs();
  }
}