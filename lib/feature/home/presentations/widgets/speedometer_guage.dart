// --- CUSTOM GAUGE WIDGET ---
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:barkbridgeai/feature/home/presentations/widgets/guage_pointer.dart';

class SpeedometerGauge extends StatelessWidget {
  final double value; // 0 to 100

  const SpeedometerGauge({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250.w,
      height: 200.h, // Adjusted height for semi-circle look
      child: CustomPaint(painter: GaugePainter(percentage: value)),
    );
  }
}
