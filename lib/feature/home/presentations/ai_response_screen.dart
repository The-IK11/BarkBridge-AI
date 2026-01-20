// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:tintpin14_app/common_widgets/custom_app_bar.dart';
// import 'package:tintpin14_app/common_widgets/glow_background.dart';
// import 'package:tintpin14_app/constants/text_font_style.dart';
// import 'package:tintpin14_app/gen/colors.gen.dart';
// import 'package:tintpin14_app/navigation_screen.dart';

// class AiResponseScreen extends StatelessWidget {
//   const AiResponseScreen({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return GlowBackground(
//       appBar: CustomAppBar(
//         title: "AI Response",
//         backgroundColor: Colors.transparent,
//       ),
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 20.w),
//         child: Column(
//           children: [
//             SizedBox(height: kToolbarHeight + 20.h),
//             Text(
//               "By observing a dog’s body movements, you can understand what it is trying to say without hearing a single word. A relaxed posture, loose tail wag, and soft eyes usually mean the dog feels safe, friendly, or happy. A stiff body, raised tail, or frozen stance can signal alertness, fear, or discomfort. When a dog lowers its body, avoids eye contact, or tucks its tail, it may be feeling anxious or asking for reassurance. Jumping, spinning, or quick movements often show excitement or a desire to play, while pacing or repeated glances toward something can mean the dog wants attention, food, or to go outside. Every small movement—ears, tail, posture, and motion—works together to express what the dog is feeling and what it wants in that moment.",
//               style: TextFontStyle.textstyle14cFFFFFFManrope500.copyWith(
//                 fontWeight: FontWeight.w300,
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: CustomBottomNavBar(
//         currentIndex: 0,
//         onTap: (index) {},
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tintpin14_app/common_widgets/custom_app_bar.dart';
import 'package:tintpin14_app/common_widgets/glow_background.dart';
import 'package:tintpin14_app/constants/text_font_style.dart';
import 'package:tintpin14_app/gen/colors.gen.dart';
import 'package:tintpin14_app/navigation_screen.dart';

class AiResponseScreen extends StatelessWidget {
  const AiResponseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GlowBackground(
      appBar: CustomAppBar(
        title: "AI Response",
        backgroundColor: Colors.transparent,
      ),
      // Use extendBody if your Nav Bar is transparent/curved
      child: SafeArea(
        child: SingleChildScrollView(
          // Fix 1: Prevents overflow
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Fix 2: Removed kToolbarHeight as AppBar handles that space
              Text(
                "By observing a dog’s body movements, you can understand what it is trying to say without hearing a single word. A relaxed posture, loose tail wag, and soft eyes usually mean the dog feels safe, friendly, or happy. A stiff body, raised tail, or frozen stance can signal alertness, fear, or discomfort. When a dog lowers its body, avoids eye contact, or tucks its tail, it may be feeling anxious or asking for reassurance. Jumping, spinning, or quick movements often show excitement or a desire to play, while pacing or repeated glances toward something can mean the dog wants attention, food, or to go outside. Every small movement—ears, tail, posture, and motion—works together to express what the dog is feeling and what it wants in that moment.",
                style: TextFontStyle.textstyle14cFFFFFFManrope500.copyWith(
                  fontWeight: FontWeight.w300,
                  height: 1.6, // Fix 3: Better readability
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
              // Add extra space at the bottom so text isn't hidden by the Nav Bar
              SizedBox(height: 100.h),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: CustomBottomNavBar(
      //   currentIndex: 0,
      //   onTap: (index) {},
      // ),
    );
  }
}
