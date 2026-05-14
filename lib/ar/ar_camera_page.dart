import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

import '../utils/pose_mapper.dart';
import '../utils/pose_smoother.dart';

class ARCameraPage extends StatefulWidget {
  const ARCameraPage({super.key});

  @override
  State<ARCameraPage> createState() => _ARCameraPageState();
}

class _ARCameraPageState extends State<ARCameraPage> {
  CameraController? controller;
  List<CameraDescription>? cameras;

  final PoseDetector detector =
      PoseDetector(options: PoseDetectorOptions());

  final PoseSmoother smoother = PoseSmoother();

  Offset? shirtPos;
  double scale = 1.0;

  bool busy = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
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
            size: Size(image.width.toDouble(), image.height.toDouble()),
            rotation: InputImageRotation.rotation0deg,
            format: InputImageFormat.nv21,
            bytesPerRow: image.planes[0].bytesPerRow,
          ),
        );

        final poses = await detector.processImage(inputImage);

        if (poses.isNotEmpty) {
          final pose = poses.first;

          final center = PoseMapper.torsoCenter(pose);
          final width = PoseMapper.shoulderWidth(pose);

          setState(() {
            shirtPos = smoother.smooth(center);
            scale = width / 220;
          });
        }
      } catch (_) {}

      await Future.delayed(const Duration(milliseconds: 40));
      busy = false;
    });

    setState(() {});
  }

  @override
  void dispose() {
    controller?.dispose();
    detector.close();
    super.dispose();
  }

  Widget cloth() {
    if (shirtPos == null) return const SizedBox();

    return Positioned(
      left: shirtPos!.dx - 80,
      top: shirtPos!.dy - 80,
      child: Transform.scale(
        scale: scale,
        child: Image.asset(
          "assets/clothes/shirts/shirt1.png",
          width: 160,
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
          cloth(),
        ],
      ),
    );
  }
}