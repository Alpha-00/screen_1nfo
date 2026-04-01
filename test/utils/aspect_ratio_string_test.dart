import 'package:flutter_test/flutter_test.dart';
import 'package:screen_s1ze/config/utils/aspect_ratio_string.dart';

void main() {
  group("Aspect Ratio String", () {
    test("Basic Test", () {
      final aspectRatio = AspectRatioGuess.nearest(3/2, useInvert: true);
      expect(aspectRatio, "3:2");
      
    });
  });
}