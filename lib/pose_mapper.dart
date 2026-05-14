import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'dart:ui';

class PoseMapper {
  static Offset? leftShoulder(Pose pose) {
    final p = pose.landmarks[PoseLandmarkType.leftShoulder];
    if (p == null) return null;
    return Offset(p.x, p.y);
  }

  static Offset? rightShoulder(Pose pose) {
    final p = pose.landmarks[PoseLandmarkType.rightShoulder];
    if (p == null) return null;
    return Offset(p.x, p.y);
  }

  static Offset? torsoCenter(Pose pose) {
    final l = leftShoulder(pose);
    final r = rightShoulder(pose);

    if (l == null || r == null) return null;

    return Offset(
      (l.dx + r.dx) / 2,
      (l.dy + r.dy) / 2 + 80,
    );
  }

  static double shoulderWidth(Pose pose) {
    final l = leftShoulder(pose);
    final r = rightShoulder(pose);

    if (l == null || r == null) return 150;

    return (r.dx - l.dx).abs();
  }
}