// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'dart:math' as math;

// import 'package:tintpin14_app/gen/colors.gen.dart';

// class HexagonButton extends StatelessWidget {
//   final VoidCallback? onPressed;
//   final double size;
//   final IconData icon;

//   const HexagonButton({
//     Key? key,
//     this.onPressed,
//     this.size = 60.0,
//     this.icon = Icons.arrow_outward, // Use arrow_outward for diagonal arrow
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onPressed,
//       child: Container(
//         padding: EdgeInsets.all(10.sp),
//         width: size,
//         height: size,
//         decoration: BoxDecoration(

//           border: Border.all(width: 2.w, color: AppColors.cFFFFFF),
//         ),
//         child: ClipPath(
//           clipper: HexagonClipper(),

//           child: ClipPath(
//             clipper: HexagonClipper(),
//             child: Container(
//               padding: EdgeInsets.all(10.sp),
//               decoration: const BoxDecoration(
//                 // Blue gradient
//                 gradient: LinearGradient(
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                   colors: [
//                     AppColors.c3B53FF, // Darker blue
//                     AppColors.c2400FF, // Lighter blue
//                   ],
//                 ),
//               ),
//               child: Center(
//                 child: Icon(icon, color: Colors.white, size: size * 0.5),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class HexagonClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     final path = Path();
//     final center = Offset(size.width / 2, size.height / 2);
//     final radius = size.width / 2;

//     for (int i = 0; i < 6; i++) {
//       final angle = (math.pi / 3) * i;
//       final x = center.dx + radius * math.cos(angle);
//       final y = center.dy + radius * math.sin(angle);
//       if (i == 0) {
//         path.moveTo(x, y);
//       } else {
//         path.lineTo(x, y);
//       }
//     }
//     path.close();
//     return path;
//   }

//   @override
//   bool shouldReclip(HexagonClipper oldClipper) => false;
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math' as math;
import 'package:tintpin14_app/gen/colors.gen.dart';

class HexagonButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final double size;
  final IconData icon;

  const HexagonButton({
    Key? key,
    this.onPressed,
    this.size = 60.0,
    this.icon = Icons.arrow_outward,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: SizedBox(
        width: size,
        height: size,
        child: CustomPaint(
          // 1. Draw the outer Hexagon Border here
          painter: HexagonBorderPainter(color: AppColors.c46558F, width: 4.w),
          child: Padding(
            // 2. Add padding so the inner fill doesn't touch the outer border
            padding: EdgeInsets.all(10.sp),
            child: ClipPath(
              // 3. Clip the inner content to a Hexagon
              clipper: HexagonClipper(),
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppColors.c3B53FF, AppColors.c2400FF],
                  ),
                ),
                child: Center(
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: size * 0.4, // Adjusted size to fit inner area
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Painter for the Outer Border
class HexagonBorderPainter extends CustomPainter {
  final Color color;
  final double width;

  HexagonBorderPainter({required this.color, required this.width});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle
          .stroke // Stroke means "Border only"
      ..strokeWidth = width;

    final path = Path();
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2);

    for (int i = 0; i < 6; i++) {
      final angle = (math.pi / 3) * i;
      final x = center.dx + radius * math.cos(angle);
      final y = center.dy + radius * math.sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Clipper for the Inner Fill
class HexagonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    for (int i = 0; i < 6; i++) {
      final angle = (math.pi / 3) * i;
      final x = center.dx + radius * math.cos(angle);
      final y = center.dy + radius * math.sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    return path;
  }

  @override
  bool shouldReclip(HexagonClipper oldClipper) => false;
}
