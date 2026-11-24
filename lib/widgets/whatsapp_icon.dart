import 'package:flutter/material.dart';

/// WhatsApp-style logo drawn in code (round speech bubble + phone handset),
/// so no extra package is needed.
class WhatsAppIcon extends StatelessWidget {
  final double size;
  final Color color;
  const WhatsAppIcon({super.key, this.size = 24, this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _WhatsAppPainter(color),
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(left: size * 0.04, bottom: size * 0.04),
            child: Icon(Icons.phone, size: size * 0.44, color: color),
          ),
        ),
      ),
    );
  }
}

class _WhatsAppPainter extends CustomPainter {
  final Color color;
  _WhatsAppPainter(this.color);

  @override
  void paint(Canvas canvas, Size s) {
    final stroke = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = s.width * 0.085
      ..strokeCap = StrokeCap.round;
    final fill = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // Round bubble.
    canvas.drawCircle(Offset(s.width * 0.53, s.height * 0.47), s.width * 0.40, stroke);

    // Little tail at the bottom-left.
    final tail = Path()
      ..moveTo(s.width * 0.20, s.height * 0.66)
      ..lineTo(s.width * 0.08, s.height * 0.94)
      ..lineTo(s.width * 0.37, s.height * 0.84)
      ..close();
    canvas.drawPath(tail, fill);
  }

  @override
  bool shouldRepaint(covariant _WhatsAppPainter old) => old.color != color;
}
