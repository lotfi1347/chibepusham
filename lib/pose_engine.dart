import 'dart:io';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

class PoseEngine {
  final PoseDetector _detector = PoseDetector(
    options: PoseDetectorOptions(
      mode: PoseDetectionMode.single,
    ),
  );

  Future<Pose?> detectPose(File file) async {
    try {
      final inputImage = InputImage.fromFile(file);
      final poses = await _detector.processImage(inputImage);

      if (poses.isEmpty) return null;

      return poses.first;
    } catch (_) {
      return null;
    }
  }

  void dispose() {
    _detector.close();
  }
}