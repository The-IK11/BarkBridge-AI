// --- THE PAINTER (The Magic) ---
import 'package:flutter/material.dart';
import 'dart:math' as math;

class GaugePainter extends CustomPainter {
  final double percentage; // 0 to 100

  GaugePainter({required this.percentage});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2 + 20);
    final radius = size.width / 2.2;

    // 1. Draw Ticks (The dashed lines outside)
    final tickPaint = Paint()
      ..color = Colors.white12
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < 40; i++) {
      // Angle range: roughly 140 degrees to 400 degrees (spanning 260 deg)
      double angle = (math.pi * 0.8) + (i * (math.pi * 1.4) / 40);
      double outerR = radius + 15;
      double innerR = radius + 5;

      canvas.drawLine(
        Offset(
          center.dx + math.cos(angle) * innerR,
          center.dy + math.sin(angle) * innerR,
        ),
        Offset(
          center.dx + math.cos(angle) * outerR,
          center.dy + math.sin(angle) * outerR,
        ),
        tickPaint,
      );
    }

    // 2. Draw Background Arc (Dark Track)
    final trackPaint = Paint()
      ..color = const Color(0xFF0F1125)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 30
      ..strokeCap = StrokeCap.round;

    // Start at 135 deg, sweep 270 deg
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - 15),
      math.pi * 0.75, // Start angle
      math.pi * 1.5, // Sweep angle (270 deg)
      false,
      trackPaint,
    );

    // 3. Draw Gradient Progress Arc
    final gradient = const SweepGradient(
      colors: [Color(0xFF0015FF), Color(0xFF2E3BFF), Color(0xFF5E81FF)],
      stops: [0.0, 0.5, 1.0],
      transform: GradientRotation(math.pi * 0.75), // Rotate gradient start
    ).createShader(Rect.fromCircle(center: center, radius: radius));

    final progressPaint = Paint()
      ..shader = gradient
      ..style = PaintingStyle.stroke
      ..strokeWidth = 30
      ..strokeCap = StrokeCap.round;

    // Calculate sweep based on percentage
    double sweepAngle = (math.pi * 1.5) * (percentage / 100);

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - 15),
      math.pi * 0.75,
      sweepAngle,
      false,
      progressPaint,
    );

    // 4. Draw Needle
    double currentAngle = (math.pi * 0.75) + sweepAngle;

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(currentAngle);

    final needlePath = Path();
    needlePath.moveTo(0, -10); // Center thickness
    needlePath.lineTo(radius - 35, 0); // Tip
    needlePath.lineTo(0, 10);
    needlePath.close();

    canvas.drawPath(needlePath, Paint()..color = const Color(0xFF2E3BFF));

    // Draw Center Dot over needle
    canvas.drawCircle(Offset.zero, 8, Paint()..color = Colors.black);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant GaugePainter oldDelegate) => true;
}
