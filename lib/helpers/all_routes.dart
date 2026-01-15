// ignore_for_file: unused_element

import 'dart:io';

import 'package:flutter/cupertino.dart';

import '../navigation_screen.dart';

final class Routes {
  static final Routes _routes = Routes._internal();
  Routes._internal();
  static Routes get instance => _routes;

  static const String logInScreen = '/logIn';
  static const String signUpScreen = '/signUp';
  static const String verifyOTPScreen = '/verifyOTPScreen';
  static const String forgetPasswordScreen = '/forgetPasswordScreen';
  static const String forgetPasswordOtpVerificationScreen =
      '/otpVerificationScreen';
  static const String createNewPasswordScreen = '/createNewPasswordScreen';
  static const String navigationRoutes = '/navigationRoutes';

}

final class RouteGenerator {
  static final RouteGenerator _routeGenerator = RouteGenerator._internal();
  RouteGenerator._internal();
  static RouteGenerator get instance => _routeGenerator;

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case Routes.signUpScreen:
      //   return Platform.isAndroid
      //       ? _FadedTransitionRoute(
      //           widget: const SignUpScreen(),
      //           settings: settings,
      //         )
      //       : CupertinoPageRoute(builder: (context) => const SignUpScreen());

      // case Routes.logInScreen:
      //   return Platform.isAndroid
      //       ? _FadedTransitionRoute(
      //           widget: const LoginScreen(),
      //           settings: settings,
      //         )
      //       : CupertinoPageRoute(builder: (context) => const LoginScreen());

      // case Routes.verifyOTPScreen:
      //   final args = settings.arguments as Map;
      //   return Platform.isAndroid
      //       ? _FadedTransitionRoute(
      //           widget: VerifyOtpScreen(
      //             email: args['email'],
      //           ),
      //           settings: settings,
      //         )
      //       : CupertinoPageRoute(
      //           builder: (context) => VerifyOtpScreen(
      //             email: args['email'],
      //           ),
      //         );

      // case Routes.forgetPasswordScreen:
      //   return Platform.isAndroid
      //       ? _FadedTransitionRoute(
      //           widget: const ForgotPasswordScreen(),
      //           settings: settings,
      //         )
      //       : CupertinoPageRoute(
      //           builder: (context) => const ForgotPasswordScreen(),
      //         );

      // case Routes.forgetPasswordOtpVerificationScreen:
      //   final args = settings.arguments as Map;
      //   return Platform.isAndroid
      //       ? _FadedTransitionRoute(
      //           widget: ForgetPasswordVerifyOtpScreen(
      //             email: args['email'],
      //           ),
      //           settings: settings,
      //         )
      //       : CupertinoPageRoute(
      //           builder: (context) => ForgetPasswordVerifyOtpScreen(
      //             email: args['email'],
      //           ),
      //         );

      // case Routes.createNewPasswordScreen:
      //   final args = settings.arguments as Map;
      //   return Platform.isAndroid
      //       ? _FadedTransitionRoute(
      //           widget: CreateNewPasswordScreen(
      //             email: args['email'],
      //           ),
      //           settings: settings,
      //         )
      //       : CupertinoPageRoute(
      //           builder: (context) => CreateNewPasswordScreen(
      //             email: args['email'],
      //           ),
      //         );



      // case Routes.setPassword:
      //   final args = settings.arguments as Map;
      //   return Platform.isAndroid
      //       ? _FadedTransitionRoute(
      //           widget: SetPasswordScreen(
      //             name: args['name'],
      //             email: args['email'],
      //           ),
      //           settings: settings)
      //       : CupertinoPageRoute(
      //           builder: (context) => SetPasswordScreen(
      //                 name: args['name'],
      //                 email: args['email'],
      //               ));

      default:
        return null;
    }
  }
}

//  weenAnimationBuilder(
//   child: Widget,
//   tween: Tween<double>(begin: 0, end: 1),
//   duration: Duration(milliseconds: 1000),
//   curve: Curves.bounceIn,
//   builder: (BuildContext context, double _val, Widget child) {
//     return Opacity(
//       opacity: _val,
//       child: Padding(
//         padding: EdgeInsets.only(top: _val * 50),
//         child: child
//       ),
//     );
//   },
// );

class _FadedTransitionRoute extends PageRouteBuilder {
  final Widget widget;
  @override
  final RouteSettings settings;

  _FadedTransitionRoute({required this.widget, required this.settings})
    : super(
        settings: settings,
        reverseTransitionDuration: const Duration(milliseconds: 1),
        pageBuilder:
            (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) {
              return widget;
            },
        transitionDuration: const Duration(milliseconds: 1),
        transitionsBuilder:
            (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) {
              return FadeTransition(
                opacity: CurvedAnimation(parent: animation, curve: Curves.ease),
                child: child,
              );
            },
      );
}

class ScreenTitle extends StatelessWidget {
  final Widget widget;

  const ScreenTitle({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: .5, end: 1),
      duration: const Duration(milliseconds: 500),
      curve: Curves.bounceIn,
      builder: (context, value, child) {
        return Opacity(opacity: value, child: child);
      },
      child: widget,
    );
  }
}
