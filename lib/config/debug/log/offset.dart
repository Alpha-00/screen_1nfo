import 'package:flutter/material.dart';

extension OffsetExtension on Offset {
  String toDebugString() {
    return "(${dx.toStringAsFixed(2)}, ${dy.toStringAsFixed(2)})";
  }
}
