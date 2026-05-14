import 'package:google_mlkit_selfie_segmentation/google_mlkit_selfie_segmentation.dart';

class BodySegmentationService {
  final _segmenter = SelfieSegmenter(
    mode: SegmenterMode.stream,
  );

  Future<Mask?> process(InputImage image) async {
    return await _segmenter.processImage(image);
  }

  void close() {
    _segmenter.close();
  }
}