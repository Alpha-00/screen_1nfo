import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'main.dart';

class ListenerScreen extends StatefulWidget {
  const ListenerScreen({super.key});

  @override
  State<StatefulWidget> createState() => ListenerScreenState();
}

class ListenerScreenState extends State<ListenerScreen> {
  PointerEvent? _event;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (event) {
        talker.info(
          'PointerDown: pos: ${event.position}, pressure: ${event.pressure.toStringAsFixed(2)}, radMajor: ${event.radiusMajor.toStringAsFixed(2)}, radMinor: ${event.radiusMinor.toStringAsFixed(2)}',
        );
        setState(() {
          _event = event;
        });
      },
      onPointerMove: (event) {
        talker.info(
          'PointerMove: pos: ${event.position}, pressure: ${event.pressure.toStringAsFixed(2)}, radMajor: ${event.radiusMajor.toStringAsFixed(2)}, radMinor: ${event.radiusMinor.toStringAsFixed(2)}',
        );
        setState(() {
          _event = event;
        });
      },
      onPointerUp: (event) {
        talker.info('PointerUp');
        setState(() {
          _event = null;
        });
      },
      child: CustomPaint(
        painter: ListenerPainter(event: _event),
        child: const SizedBox.expand(),
      ),
    );
  }
}

class ListenerPainter extends CustomPainter {
  final PointerEvent? event;

  ListenerPainter({this.event});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.red;

    if (event != null) {
      final rect = Rect.fromCenter(
        center: event!.position,
        width: event!.radiusMajor * 2,
        height: event!.radiusMinor * 2,
      );
      canvas.drawOval(rect, paint);
    }
  }

  @override
  bool shouldRepaint(covariant ListenerPainter oldDelegate) {
    return oldDelegate.event != event;
  }
}
