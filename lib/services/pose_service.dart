import 'dart:io';

import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

class PoseService {

  final PoseDetector poseDetector = PoseDetector(
    options: PoseDetectorOptions(),
  );

  Future<Pose?> detectPose(File imageFile) async {

    final inputImage = InputImage.fromFile(imageFile);

    final poses = await poseDetector.processImage(inputImage);

    if (poses.isEmpty) {
      return null;
    }

    return poses.first;
  }

  void dispose() {
    poseDetector.close();
  }
}