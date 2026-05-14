import 'dart:ui';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'package:google_mlkit_selfie_segmentation/google_mlkit_selfie_segmentation.dart';

import 'pose_mapper.dart';
import 'pose_smoother.dart';

class PoseCameraPage extends StatefulWidget {
  const PoseCameraPage({super.key});

  @override
  State<PoseCameraPage> createState() => _PoseCameraPageState();
}

class _PoseCameraPageState extends State<PoseCameraPage> {
  CameraController? controller;
  List<CameraDescription>? cameras;

  final PoseDetector _poseDetector =
      PoseDetector(options: PoseDetectorOptions());

  final SelfieSegmenter _segmenter =
      SelfieSegmenter(mode: SegmenterMode.stream);

  final PoseSmoother shirtSmooth = PoseSmoother();
  final PoseSmoother pantsSmooth = PoseSmoother();

  Offset? shirtPos;
  Offset? pantsPos;

  double shirtScale = 1.0;
  double pantsScale = 1.0;

  double light = 1.0;

  bool busy = false;

  String status = "V2 loading...";

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
            size: Size(image.width.toDouble(), image.height.toDouble()),
            rotation: InputImageRotation.rotation0deg,
            format: InputImageFormat.nv21,
            bytesPerRow: image.planes[0].bytesPerRow,
          ),
        );

        // 🧠 POSE
        final poses = await _poseDetector.processImage(inputImage);

        // 👤 SEGMENTATION (body mask)
        final mask = await _segmenter.processImage(inputImage);

        if (poses.isNotEmpty) {
          final pose = poses.first;

          final center = PoseMapper.torsoCenter(pose);
          final hip = pose.landmarks[PoseLandmarkType.leftHip];
          final width = PoseMapper.shoulderWidth(pose);

          setState(() {
            shirtPos = shirtSmooth.smooth(center);
            pantsPos = hip != null
                ? pantsSmooth.smooth(Offset(hip.x, hip.y))
                : pantsPos;

            shirtScale = width / 220;
            pantsScale = width / 200;

            // 💡 LIGHT ADAPTATION (fake but effective)
            light = (width / 300).clamp(0.85, 1.15);

            status = "V2 COMMERCIAL ACTIVE ✔";
          });
        }
      } catch (e) {
        setState(() {
          status = "Error: $e";
        });
      }

      await Future.delayed(const Duration(milliseconds: 50));
      busy = false;
    });

    setState(() {});
  }

  @override
  void dispose() {
    controller?.dispose();
    _poseDetector.close();
    _segmenter.close();
    super.dispose();
  }

  Widget cloth({
    required String asset,
    required Offset? pos,
    required double scale,
    required double w,
  }) {
    if (pos == null) return const SizedBox();

    return Positioned(
      left: pos.dx - (w / 2),
      top: pos.dy - (w / 2),
      child: Transform.scale(
        scale: scale,
        child: ColorFiltered(
          colorFilter: ColorFilter.mode(
            Colors.white.withOpacity(light),
            BlendMode.modulate,
          ),
          child: Opacity(
            opacity: 0.97,
            child: Image.asset(asset, width: w),
          ),
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

          cloth(
            asset: "assets/clothes/shirts/shirt1.png",
            pos: shirtPos,
            scale: shirtScale,
            w: 160,
          ),

          cloth(
            asset: "assets/clothes/pants/pants1.png",
            pos: pantsPos,
            scale: pantsScale,
            w: 150,
          ),

          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(14),
              color: Colors.black87,
              child: Text(
                status,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}