import 'package:flutter/material.dart';
import 'common_widgets/safe_scaffold.dart';
import 'gen/assets.gen.dart';

final class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeScaffold(
      body: SafeArea(
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          //decoration: const BoxDecoration(color: AppColors.allPrimaryColor),
          child: Center(
            child: SizedBox(
              // child: shimmer(
              //   context: context,
              //   //name: Assets.lottie.loadingSpinner,
              //   name: Assets.icons.welcomeLogo.path,
              //   size: 150.sp,
              //   color: AppColors.allPrimaryColor,
              // ),
              child: Image.asset(Assets.icons.welcomeLogo.path),
            ),
          ),
        ),
      ),
    );
  }
}
