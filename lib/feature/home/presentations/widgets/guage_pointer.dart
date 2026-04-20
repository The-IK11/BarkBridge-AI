// --- THE PAINTER (The Magic) ---
import 'package:flutter/material.dart';
import 'dart:math' as math;

class GaugePainter extends CustomPainter {
  final double percentage; // 0 to 100

  GaugePainter({required this.percentage});

  @override
  void paint(Canvas canvas, Size size) {
    final clampedValue = percentage.clamp(0, 100).toDouble();
    final center = Offset(size.width / 2, size.height / 2 + 20);
    final radius = size.width / 2.2;
    const startAngle = math.pi * 0.75; // 135 degrees
    const totalSweep = math.pi * 1.5; // 270 degrees
    final sweepAngle = totalSweep * (clampedValue / 100);

    // 1. Draw Outer Ticks as Dots (Faint white dots with fade at ends)
    for (int i = 0; i < 24; i++) {
      double angle = startAngle + (i * (totalSweep / 24));
      double tickR = radius + 16;

      // Calculate fade opacity - full at middle, faded at edges
      double fadeOpacity = 1.0 - (((i - 11.5).abs()) / 12.0).clamp(0, 1);
      fadeOpacity = fadeOpacity * 0.35; // Scale to max 0.35 opacity

      final tickPaint = Paint()
        ..color = Colors.white.withOpacity(fadeOpacity)
        ..strokeWidth = 0;

      final tickX = center.dx + math.cos(angle) * tickR;
      final tickY = center.dy + math.sin(angle) * tickR;

      canvas.drawCircle(Offset(tickX, tickY), 1.2, tickPaint);
    }

    // 2. Draw Background Track with Gradient
    final arcRect = Rect.fromCircle(center: center, radius: radius - 15);

    final bgGradient = const SweepGradient(
      colors: [
        Color.fromRGBO(25, 60, 136, 0.087),
        Color.fromARGB(255, 25, 60, 136),
        Color.fromRGBO(25, 60, 136, 0.087),
      ],
      stops: [0.0, 0.5, 1.0],
      transform: GradientRotation(startAngle),
    ).createShader(Rect.fromCircle(center: center, radius: radius));

    final bgPaint = Paint()
      ..shader = bgGradient
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20
      ..strokeCap = StrokeCap.butt;

    canvas.drawArc(arcRect, startAngle, totalSweep, false, bgPaint);

    // 3. Draw Gradient Progress Arc (Vibrant blue to neon purple)
    final gradient = const SweepGradient(
      colors: [
        Color.fromARGB(16, 46, 60, 255),
        // Color(0xFF2E3BFF), // Vibrant blue (brighter start)
        Color.fromARGB(255, 40, 101, 255), // Vibrant blue
        Color.fromARGB(18, 46, 60, 255), // Neon purple
      ],
      stops: [0.0, 0.5, 1.0],
      transform: GradientRotation(startAngle),
    ).createShader(Rect.fromCircle(center: center, radius: radius));

    final progressPaint = Paint()
      ..shader = gradient
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20
      ..strokeCap = StrokeCap.butt;

    if (sweepAngle > 0) {
      canvas.drawArc(arcRect, startAngle, sweepAngle, false, progressPaint);
    }

    // 3.5 Draw Remaining Path with Low Opacity
    final remainingSweep = totalSweep - sweepAngle;
    if (remainingSweep > 0) {
      final remainingPaint = Paint()
        ..color = const Color.fromARGB(83, 40, 101, 255).withOpacity(0.4)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 20
        ..strokeCap = StrokeCap.butt;

      canvas.drawArc(
        arcRect,
        startAngle + sweepAngle,
        remainingSweep,
        false,
        remainingPaint,
      );
    }

    // 3.6 Draw Center Path (Inner Circle) - Static
    final centerRadius = radius - 50;
    final centerArcRect = Rect.fromCircle(center: center, radius: centerRadius);

    final centerStaticPaint = Paint()
      ..color = const Color(0xFF07152E).withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.butt;

    // Draw static circle with reduced length from both sides
    final centerStartOffset = totalSweep * 0.15; // Skip 15% from start
    final centerEndOffset = totalSweep * 0.15; // Skip 15% from end
    final centerSweep =
        totalSweep - centerStartOffset - centerEndOffset; // 70% of total
    canvas.drawArc(
      centerArcRect,
      startAngle + centerStartOffset,
      centerSweep,
      false,
      centerStaticPaint,
    );

    // 4. Draw Needle (Tapered: bottom 13 width, top 4 width, rounded tip)
    double currentAngle = startAngle + sweepAngle;

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(currentAngle);

    final needleLength = radius - 50;
    const bottomWidth = 15.0;
    const topWidth = 6.0;

    final needlePath = Path()
      ..moveTo(0, -bottomWidth / 2) // Left bottom at base
      ..lineTo(needleLength, -topWidth / 2) // Left side to tip
      ..lineTo(needleLength, topWidth / 2) // Right side to tip
      ..lineTo(0, bottomWidth / 2) // Right bottom at base
      ..close();

    canvas.drawPath(
      needlePath,
      Paint()..color = const Color.fromARGB(255, 35, 53, 247),
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant GaugePainter oldDelegate) => true;
}
