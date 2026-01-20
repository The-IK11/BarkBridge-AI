import 'package:flutter/material.dart';
import 'package:tintpin14_app/feature/auth/presentation/screens/sign_in_screen.dart';
import 'package:tintpin14_app/feature/onboarding/screens/onboarding_screen.dart';
import 'package:tintpin14_app/navigation_screen.dart';

import 'constants/app_constants.dart';
import 'feature/home/presentations/home_screen.dart';
import 'helpers/di.dart';
import 'helpers/helper_methods.dart';
import 'helpers/post_login.dart';
import 'networks/dio/dio.dart';
import 'welcome_screen.dart';

final class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  bool _isLoading = true;
  bool isFirstTime = true;
  bool isLoggedIn = appData.read(kKeyAccessToken) != null;
  bool isScanValue = appData.read(isScan) ?? false;
  @override
  void initState() {
    loadInitialData();
    performPostLoginActions();
    super.initState();
  }

  loadInitialData() async {
    //AutoAppUpdateUtil.instance.checkAppUpdate();
    await setInitValue();

    if (isLoggedIn) {
      final String token = appData.read(kKeyAccessToken);
      DioSingleton.instance.update(token);
      // await performPostLoginActions();
    } else {
      //  NotificationService().cancelAllNotifications();
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const WelcomeScreen();
    } else {
      return isLoggedIn
          ? const HomeScreen()
          : appData.read(kKeyFirstTime)
          ? const OnboardingScreen()
          : const NavigationScreen();
    }
  }
}
