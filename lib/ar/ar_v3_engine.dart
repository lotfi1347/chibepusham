import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'package:google_mlkit_selfie_segmentation/google_mlkit_selfie_segmentation.dart';

import '../utils/pose_mapper.dart';
import '../utils/pose_smoother.dart';
import '../state/wardrobe_state.dart';
import '../models/cloth_item.dart';

class ARV3Engine extends StatefulWidget {
  const ARV3Engine({super.key});

  @override
  State<ARV3Engine> createState() => _ARV3EngineState();
}

class _ARV3EngineState extends State<ARV3Engine> {
  CameraController? controller;
  List<CameraDescription>? cameras;

  final PoseDetector poseDetector =
      PoseDetector(options: PoseDetectorOptions());

  final SelfieSegmenter segmenter =
      SelfieSegmenter(mode: SegmenterMode.stream);

  final PoseSmoother shirtSmooth = PoseSmoother();
  final PoseSmoother pantsSmooth = PoseSmoother();

  final WardrobeState wardrobe = WardrobeState();

  Offset? shirtPos;
  Offset? pantsPos;

  double shirtScale = 1.0;
  double pantsScale = 1.0;

  bool busy = false;

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  Future<void> initCamera() async {
    cameras = await availableCameras();

    controller = CameraController(
      cameras!.first,
      ResolutionPreset.medium,
      enableAudio: false,
    );

    await controller!.initialize();

    controller!.startImageStream((image) async {
      if (busy) return;
      busy = true;

      try {
        final inputImage = InputImage.fromBytes(
          bytes: image.planes[0].bytes,
          metadata: InputImageMetadata(
            size: Size(
              image.width.toDouble(),
              image.height.toDouble(),
            ),
            rotation: InputImageRotation.rotation0deg,
            format: InputImageFormat.nv21,
            bytesPerRow: image.planes[0].bytesPerRow,
          ),
        );

        // 👤 SEGMENTATION (background separation)
        await segmenter.processImage(inputImage);

        // 🧠 POSE DETECTION
        final poses = await poseDetector.processImage(inputImage);

        if (poses.isNotEmpty) {
          final pose = poses.first;

          final leftShoulder =
              pose.landmarks[PoseLandmarkType.leftShoulder];
          final rightShoulder =
              pose.landmarks[PoseLandmarkType.rightShoulder];

          final leftHip =
              pose.landmarks[PoseLandmarkType.leftHip];

          if (leftShoulder != null && rightShoulder != null) {
            final center = Offset(
              (leftShoulder.x + rightShoulder.x) / 2,
              (leftShoulder.y + rightShoulder.y) / 2,
            );

            final width =
                (leftShoulder.x - rightShoulder.x).abs();

            setState(() {
              // 👕 SHIRT POSITION
              shirtPos = shirtSmooth.smooth(center);
              shirtScale = width / 220;

              // 👖 PANTS POSITION
              if (leftHip != null) {
                pantsPos = pantsSmooth.smooth(
                  Offset(leftHip.x, leftHip.y),
                );
                pantsScale = width / 200;
              }
            });
          }
        }
      } catch (_) {
        // silent fail for stability
      }

      await Future.delayed(const Duration(milliseconds: 45));
      busy = false;
    });

    setState(() {});
  }

  @override
  void dispose() {
    controller?.dispose();
    poseDetector.close();
    segmenter.close();
    super.dispose();
  }

  Widget clothLayer({
    required String asset,
    required Offset? pos,
    required double scale,
    required double width,
  }) {
    if (pos == null) return const SizedBox();

    return Positioned(
      left: pos.dx - (width / 2),
      top: pos.dy - (width / 2),
      child: Transform.scale(
        scale: scale,
        child: Opacity(
          opacity: 0.97,
          child: Image.asset(asset, width: width),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller!.value.isInitialized) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          CameraPreview(controller!),

          // 🧥 LAYERS (V4 wardrobe ready)
          clothLayer(
            asset: wardrobe.shirt?.asset ??
                "assets/clothes/shirts/shirt1.png",
            pos: shirtPos,
            scale: shirtScale,
            width: 160,
          ),

          clothLayer(
            asset: wardrobe.pants?.asset ??
                "assets/clothes/pants/pants1.png",
            pos: pantsPos,
            scale: pantsScale,
            width: 150,
          ),
        ],
      ),
    );
  }
}