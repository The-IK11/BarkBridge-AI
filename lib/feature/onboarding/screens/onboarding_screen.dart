import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/instance_manager.dart';
import 'package:barkbridgeai/common_widgets/custom_tab_bar.dart';
import 'package:barkbridgeai/common_widgets/glow_background.dart';
import 'package:barkbridgeai/constants/app_constants.dart';
import 'package:barkbridgeai/constants/text_font_style.dart';
import 'package:barkbridgeai/feature/auth/presentation/screens/sign_in_screen.dart';
import 'package:barkbridgeai/feature/onboarding/widgets/onboarding_widget.dart';
import 'package:barkbridgeai/gen/assets.gen.dart';
import 'package:barkbridgeai/gen/colors.gen.dart';
import 'package:barkbridgeai/helpers/di.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentTab = 0;
  Widget selectBody() {
    switch (currentTab) {
      case 0:
        return OnboardingWidget(
          key: ValueKey(0),
          imageUrl: Assets.images.onboarding1Image.path,
          title: "Your Dog Is Talking to You",
          subtitle:
              "Record a howl and turn it into a message you can understand",
        );
      case 1:
        return OnboardingWidget(
          key: ValueKey(1),
          imageUrl: Assets.images.onboarding2Image.path,
          title: "Hear What Your Dog Means",
          subtitle: "Turn dog howls into real understanding",
        );
      case 2:
        return OnboardingWidget(
          key: ValueKey(2),
          imageUrl: Assets.images.onboarding3Image.path,
          title: "Every Howl Has a Meaning",
          subtitle: "Record your dog’s voice and discover what they want.",
        );
      case 3:
        return OnboardingWidget(
          key: ValueKey(3),
          imageUrl: Assets.images.onboarding4Image.path,
          title: "Dogs Speak. We Translate.",
          subtitle: "Record a howl and uncover the message behind it.",
        );
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GlowBackground(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.sp),
        child: Column(
          children: [
            //  SizedBox(height: kToolbarHeight + 20.h),
            Expanded(
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 500),
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: ScaleTransition(scale: animation, child: child),
                  );
                },
                child: selectBody(),
              ),
            ),
            SizedBox(height: 10.h),
            CustomTabBar(
              currentIndex: currentTab,
              onTap: (index) {
                setState(() {
                  currentTab = index;
                });
              },
            ),
            // SizedBox(height: 20.h),
            // HexagonButton(
            //   onPressed: () {
            //     setState(() {
            //       if (currentTab < 3) {
            //         currentTab++;
            //       } else {
            //         Get.to(() => NavigationScreen());
            //       }
            //     });
            //   },
            // ),
            InkWell(
              onTap: () {
                setState(() {
                  if (currentTab < 3) {
                    currentTab++;
                  } else {
                    appData.write(kKeyFirstTime, false);
                    Get.to(() => SignInScreen());
                  }
                });
              },
              child: Image.asset(
                Assets.icons.buttonIcon.path,
                width: 120.w,
                height: 120.h,
              ),
            ),

            SizedBox(height: 50.h),
          ],
        ),
      ),
    );
  }

  Widget _onboardingItem({required String title, required String description}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextFontStyle.textstyle28cFFFFFFManrope700,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 12.h),
        Text(
          description,
          style: TextFontStyle.textstyle16c898996Manrope400.copyWith(
            color: AppColors.cB8BBCC,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
