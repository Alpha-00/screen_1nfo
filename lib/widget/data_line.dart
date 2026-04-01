import 'package:flutter/material.dart';
import 'package:screen_s1ze/widget/toggle_label_widget.dart';

class DataLine extends StatelessWidget {
  final String label;
  final DataValue value;

  const DataLine({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
            _buildValueWidget(value)
          ],
        ),
      );
  }
  Widget _buildValueWidget(DataValue value) {
    switch (value) {
      case BooleanValue(value: var value):
        return ToggleLabelWidget(items: {
          "No": TextStyle(color: Colors.red),
          "Yes": TextStyle(color: Colors.green),
        }, defaultItemIndex: value?0:1, isInteractable: false,);
      default :
        return Text(value.toString());
    }
  }
  
}
sealed class DataValue {
}

class StringValue extends DataValue {
  final String value;

  StringValue({required this.value});
  @override
  String toString() {
    return value;
  }
}

class NumberValue extends DataValue {
  final double value;
  final int? fixedRound;
  NumberValue(this.value, {this.fixedRound});
  @override
  String toString() {
    if (fixedRound != null) return value.toStringAsFixed(fixedRound!);
    return value.toString();
  }
}
class SizeValue extends DataValue {
  final double valueA;
  final double valueB;
  final int? fixedRound;
  SizeValue(this.valueA,this.valueB, {this.fixedRound});
  SizeValue.fromSize(Size size, {this.fixedRound}): valueA = size.width, valueB = size.height; 
  
  @override
  String toString() {
    if (fixedRound == null) return '$valueA × $valueB';
    return '${valueA.toStringAsFixed(fixedRound!)} × ${valueB.toStringAsFixed(fixedRound!)}';
  }

}

class IntSizeValue extends DataValue {
  final int valueA;
  final int valueB;

  IntSizeValue(this.valueA,this.valueB);
  IntSizeValue.fromSize(Size size): valueA = size.width.round(), valueB = size.height.round(); 
  
  @override
  String toString() {
    return '$valueA × $valueB';
  }
}
class BooleanValue extends DataValue {
  final bool value;

  BooleanValue({required this.value});
  @override
  String toString() {
    return value.toString();
  }
}