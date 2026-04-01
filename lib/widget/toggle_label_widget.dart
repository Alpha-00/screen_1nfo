import 'package:flutter/material.dart';

class ToggleLabelWidget extends StatefulWidget {
  final Map<String, TextStyle?> items;
  final int defaultItemIndex;
  final bool isInteractable;
  const ToggleLabelWidget({super.key,required this.items, this.isInteractable = false, this.defaultItemIndex=0});

  @override
  State<StatefulWidget> createState() 
  => ToggleLabelWidgetState();

}

class ToggleLabelWidgetState extends State<ToggleLabelWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(padding: .all(4),);
  }
}