import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

import '../state/wardrobe_state.dart';
import '../state/shop_state.dart';
import '../models/outfit.dart';
import '../state/outfit_store.dart';
import '../ui/v6_control_panel.dart';

class AREngine extends StatefulWidget {
  final WardrobeState wardrobe;

  const AREngine({
    super.key,
    required this.wardrobe,
  });

  @override
  State<AREngine> createState() => _AREngineState();
}

class _AREngineState extends State<AREngine> {
  CameraController? controller;
  List<CameraDescription>? cameras;

  final OutfitStore store = OutfitStore();
  final ShopState shopState = ShopState();

  PoseDetector? poseDetector;

  bool ready = false;

  Offset? bodyCenter;
  double scale = 1.0;

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  Future<void> initCamera() async {
    try {
      cameras = await availableCameras();

      controller = CameraController(
        cameras!.first,
        ResolutionPreset.medium,
        enableAudio: false,
      );

      await controller!.initialize();

      // 🧠 AR فقط روی موبایل
      if (!kIsWeb) {
        poseDetector = PoseDetector(
          options: PoseDetectorOptions(
            mode: PoseDetectionMode.stream,
          ),
        );

        controller!.startImageStream((image) async {
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

            final poses = await poseDetector!.processImage(inputImage);

            if (poses.isNotEmpty) {
              final pose = poses.first;

              final left =
                  pose.landmarks[PoseLandmarkType.leftShoulder];
              final right =
                  pose.landmarks[PoseLandmarkType.rightShoulder];

              if (left != null && right != null) {
                final dx = (left.x + right.x) / 2;
                final dy = (left.y + right.y) / 2;

                final screenSize = MediaQuery.of(context).size;

                final imageWidth = image.width.toDouble();
                final imageHeight = image.height.toDouble();

                setState(() {
                  bodyCenter = Offset(
                    dx / imageWidth * screenSize.width,
                    dy / imageHeight * screenSize.height,
                  );

                  scale = screenSize.width / imageWidth;
                });
              }
            }
          } catch (_) {
            // جلوگیری از crash
          }
        });
      }

      setState(() {
        ready = true;
      });
    } catch (e) {
      debugPrint("Camera init error: $e");
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    poseDetector?.close();
    super.dispose();
  }

  Widget _cloth(String asset, String itemId, bool isPremium) {
    if (bodyCenter == null) return const SizedBox();

    if (isPremium && !shopState.isOwned(itemId)) {
      return const SizedBox();
    }

    return Positioned(
      left: bodyCenter!.dx - 60,
      top: bodyCenter!.dy - 120,
      child: Transform.scale(
        scale: scale,
        child: Image.asset(asset),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!ready || controller == null || !controller!.value.isInitialized) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                CameraPreview(controller!),

                _cloth(
                  widget.wardrobe.shirt?.asset ??
                      "assets/clothes/shirts/shirt1.png",
                  "shirt1",
                  false,
                ),

                _cloth(
                  widget.wardrobe.pants?.asset ??
                      "assets/clothes/pants/pants1.png",
                  "pants1",
                  false,
                ),

                _cloth(
                  widget.wardrobe.shoes?.asset ??
                      "assets/clothes/shoes/shoes1.png",
                  "shoes1",
                  false,
                ),

                if (kIsWeb)
                  Positioned(
                    top: 50,
                    left: 20,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      color: Colors.black54,
                      child: const Text(
                        "WEB MODE (AR LIMITED)",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          V6ControlPanel(
            currentOutfit: Outfit(
              shirt: widget.wardrobe.shirt,
              pants: widget.wardrobe.pants,
              shoes: widget.wardrobe.shoes,
            ),
            store: store,
          ),
        ],
      ),
    );
  }
}