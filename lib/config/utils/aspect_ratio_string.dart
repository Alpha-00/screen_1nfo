class AspectRatioGuess {
  static Map<String, double> example = {
    "3:2": 3/2,
    "3:4": 3/4,
    "16:9": 16/9,
    "20:9": 20/9,
    "21:9": 21/9,
    "21.5:9": 21.5/9
  };

  static String? nearest(double ratioValue, {double tolerance = 1e-5, bool useInvert = true}) {
    final candidates = example.entries.toList();
    if (useInvert) {
      candidates.addAll(candidates.map((e) => MapEntry(e.key, 1/ e.value)));
    } 
    final delta = candidates.map((e) => (e.key, e.value, (e.value - ratioValue).abs()));
    final lastCandidate = delta.reduce((a, b) => a.$3 < b.$3? a : b);
    return lastCandidate.$3.abs() < tolerance ? lastCandidate.$1 : null;
  }
}

extension AspectRatioString on double {
  String? get aspectRatioString => AspectRatioGuess.nearest(this);
}
