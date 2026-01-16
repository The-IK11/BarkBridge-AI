import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'constants/custom_theme.dart';
import 'gen/colors.gen.dart';
import 'helpers/all_routes.dart';
import 'helpers/di.dart';
import 'helpers/helper_methods.dart';
import 'helpers/navigation_service.dart';
import 'loading_screen.dart';
import 'networks/dio/dio.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //await _requestPermissions();
  await GetStorage.init();
  diSetup();

  DioSingleton.instance.create();

  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    rotation();
    setInitValue();
    return AnimateIfVisibleWrapper(
      child: PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) async {
          showMaterialDialog(context);
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            return const UtilScreenMobile();
          },
        ),
      ),
    );
  }
}

class UtilScreenMobile extends StatelessWidget {
  const UtilScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (bool didPop, _) async {
            showMaterialDialog(context);
          },
          child: GetMaterialApp(
            //    showPerformanceOverlay: true,
            theme: ThemeData(
              checkboxTheme: const CheckboxThemeData(
                checkColor: WidgetStatePropertyAll(Colors.white),
              ),
              unselectedWidgetColor: Colors.white,
              primarySwatch: CustomTheme.kToDark,
              useMaterial3: false,
              scaffoldBackgroundColor: AppColors.cFFFFFF,
              appBarTheme: const AppBarTheme(
                backgroundColor: AppColors.cFFFFFF,
                elevation: 0,
              ),
            ),
            debugShowCheckedModeBanner: false,
            builder: (context, widget) {
              //return MediaQuery(data: MediaQuery.of(context), child: widget!);
              return AnnotatedRegion<SystemUiOverlayStyle>(
                value: const SystemUiOverlayStyle(
                  statusBarColor: Colors.transparent,
                  statusBarIconBrightness:
                      Brightness.light, // Android: White icons
                  statusBarBrightness: Brightness.dark, // iOS: White icons
                ),
                child: MediaQuery(data: MediaQuery.of(context), child: widget!),
              );
            },
            navigatorKey: NavigationService.navigatorKey,
            onGenerateRoute: RouteGenerator.generateRoute,
            home: const Loading(), //
          ),
        );
      },
    );
  }
}
