import 'dart:ui';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

class PoseDetectorService {
  final PoseDetector _detector = PoseDetector(
    options: PoseDetectorOptions(mode: PoseDetectionMode.stream),
  );

  Future<List<Pose>> detectPose(InputImage inputImage) async {
    final poses = await _detector.processImage(inputImage);
    return poses;
  }

  void close() {
    _detector.close();
  }
}