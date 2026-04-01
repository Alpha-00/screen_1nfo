import 'package:flutter/material.dart';
final debugHash = DateTime.now().hashCode.toString().substring(4);
class DebugChangeBannerWidget extends StatelessWidget {
  final Widget child;
  DebugChangeBannerWidget({super.key,required this.child});
  @override
  Widget build(BuildContext context) {
    return Directionality(
      
      textDirection: .ltr,
      child: Banner(
        message: '$debugHash', location: .topEnd,
        child: child,
      ),
    );
  }

}