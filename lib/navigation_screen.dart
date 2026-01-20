// // ignore_for_file: must_be_immutable

// import 'package:custom_navigation_bar/custom_navigation_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import '/gen/assets.gen.dart';
// import 'common_widgets/safe_scaffold.dart';
// import 'constants/text_font_style.dart';

// import 'features/home/presentation/home_screen.dart';
// import 'gen/colors.gen.dart';
// import 'helpers/helper_methods.dart';

// final class NavigationScreen extends StatefulWidget {
//   final int? pageNum;

//   const NavigationScreen({super.key, this.pageNum});

//   @override
//   State<NavigationScreen> createState() => _NavigationScreenState();
// }

// class _NavigationScreenState extends State<NavigationScreen> {
//   late int _currentIndex = widget.pageNum ?? 0;

//   final bool _isFirstBuild = true;

//   final List _screens = [
//     const HomeScreen(),
//     const HomeScreen(),
//     const HomeScreen(),
//     const HomeScreen(),
//     const HomeScreen(),
//   ];

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Object? args;
//     StatefulWidget? screenPage;
//     if (_isFirstBuild) {
//       args = ModalRoute.of(context)!.settings.arguments;
//     }
//     if (args != null) {
//       screenPage = args as StatefulWidget;
//       var newColorindex = -1;

//       for (var element in _screens) {
//         newColorindex++;
//         if (element.toString() == screenPage.toString()) {
//           _currentIndex = newColorindex;
//           break;
//         }
//       }
//     }

//     return PopScope(
//       canPop: false,
//       onPopInvokedWithResult: (bool didPop, _) async {
//         showMaterialDialog(context);
//       },
//       child: SafeScaffold(
//         extendBody: true,

//         body: SafeArea(
//           child: Center(
//             child: (screenPage != null)
//                 ? screenPage
//                 : _screens.elementAt(_currentIndex),
//           ),
//         ),
//         bottomNavigationBar: Container(
//           height: 100.h,
//           decoration: BoxDecoration(
//             color: AppColors.cFFFFFF,
//             border: Border(
//               top: BorderSide(color: Colors.grey.shade300, width: .05),
//             ),
//           ),
//           child: BottomNavigationBar(
//             backgroundColor: AppColors.cFFFFFF,
//             type: BottomNavigationBarType.fixed,
//             selectedItemColor: AppColors.cEDA922,
//             unselectedItemColor: AppColors.c171717,
//             // showSelectedLabels: false, // hides all labels
//             // showUnselectedLabels: false,
//             // showSelectedLabels: true,
//             currentIndex: _currentIndex,
//             onTap: (index) {
//               if (index == 2) {
//                 // Handle Add button tap
//                 return;
//               }
//               setState(() => _currentIndex = index);
//             },
//             items: [
//               BottomNavigationBarItem(
//                 icon: SizedBox(
//                   height: 24.h,
//                   width: 24.h,
//                   child: Image.asset(
//                     Assets.icons.homeIcon.path,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 activeIcon: SizedBox(
//                   height: 24.h,
//                   width: 24.h,
//                   child: Image.asset(
//                     Assets.icons.homeIconActive.path,

//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 label: "Home",
//               ),
//               BottomNavigationBarItem(
//                 icon: Image.asset(
//                   Assets.icons.bookingIcon.path,
//                   height: 24.h,
//                   width: 24.h,
//                   fit: BoxFit.cover,
//                 ),
//                 activeIcon: Image.asset(
//                   Assets.icons.bookingIconActive.path,
//                   height: 24.h,
//                   width: 24.h,
//                   fit: BoxFit.cover,
//                 ),
//                 label: "Bookings",
//               ),
//               BottomNavigationBarItem(
//                 icon: Container(
//                   height: 54.h,
//                   width: 54.w,
//                   padding: EdgeInsets.all(13.5),
//                   decoration: BoxDecoration(
//                     color: Color(0xffF9F9F9),
//                     // color: Colors.red,
//                     borderRadius: BorderRadius.circular(50),
//                   ),
//                   child: Image.asset(Assets.icons.addIcon.path),
//                 ),
//                 label: "",
//               ),

//               BottomNavigationBarItem(
//                 icon: Image.asset(
//                   Assets.icons.chatIcon.path,
//                   height: 24.h,
//                   width: 24.h,
//                   fit: BoxFit.cover,
//                 ),
//                 activeIcon: Image.asset(
//                   Assets.icons.chatIconActive.path,
//                   height: 24.h,
//                   width: 24.h,
//                   fit: BoxFit.cover,
//                 ),
//                 label: "Chat",
//               ),
//               BottomNavigationBarItem(
//                 icon: Image.asset(
//                   Assets.icons.settingIcon.path,
//                   height: 24.h,
//                   width: 24.h,
//                   fit: BoxFit.cover,
//                 ),
//                 activeIcon: Image.asset(
//                   Assets.icons.settingIconActive.path,
//                   height: 24.h,
//                   width: 24.h,
//                   fit: BoxFit.cover,
//                 ),
//                 label: "Setting",
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// CustomNavigationBar(

//           iconSize: 24.r,
//           selectedColor: Colors.red,
//           strokeColor: AppColors.allPrimaryColor,
//           unSelectedColor: Colors.black,
//           elevation: 10,
//           backgroundColor: AppColors.cFFFDF9,
//           items: [
//             CustomNavigationBarItem(
//               icon: Image.asset(
//                 Assets.icons.homeIcon.path,
//                 color: (_currentIndex == 0)
//                     ? AppColors.cEDA922
//                     : AppColors.c838383,
//               ),
//               title: Text(
//                 "${"Home"} ",
//                 style: TextFontStyle.textStylec14c02505FChakraPetch700.copyWith(
//                   color: (_currentIndex == 0)
//                       ? AppColors.cEDA922
//                       : AppColors.c838383,
//                 ),
//               ),
//             ),
//             CustomNavigationBarItem(
//               icon: Image.asset(
//                 Assets.icons.bookingIcon.path,
//                 color: (_currentIndex == 1)
//                     ? AppColors.allPrimaryColor
//                     : AppColors.c838383,
//               ),
//               title: Text(
//                 'Food Log',
//                 style: TextFontStyle.textStylec14c02505FChakraPetch700.copyWith(
//                   color: (_currentIndex == 1)
//                       ? AppColors.allPrimaryColor
//                       : AppColors.c838383,
//                 ),
//               ),
//             ),
//             CustomNavigationBarItem(
//               icon: Image.asset(
//                 Assets.icons.addIcon.path,
//                 color: (_currentIndex == 2)
//                     ? AppColors.allPrimaryColor
//                     : AppColors.c838383,
//               ),
//               title: Text(
//                 'Analytics',
//                 style: TextFontStyle.textStylec14c02505FChakraPetch700.copyWith(
//                   color: (_currentIndex == 2)
//                       ? AppColors.allPrimaryColor
//                       : AppColors.c838383,
//                 ),
//               ),
//             ),
// CustomNavigationBarItem(
//   icon: Image.asset(
//     Assets.icons.chatIcon.path,
//     color: (_currentIndex == 3)
//         ? AppColors.allPrimaryColor
//         : AppColors.c838383,
//   ),
//   title: Text(
//     'Profile',
//     style: TextFontStyle.textStylec14c02505FChakraPetch700.copyWith(
//       color: (_currentIndex == 3)
//           ? AppColors.allPrimaryColor
//           : AppColors.c838383,
//     ),
//   ),
// ),
//           ],
//           currentIndex: _currentIndex,
//           onTap: (index) {
//             setState(() {
//               _currentIndex = index;
//             });
//           },
//         ),

// import 'package:flutter/material.dart';

// class NavigationScreen extends StatelessWidget {
//   const NavigationScreen({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold();
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tintpin14_app/common_widgets/glow_background.dart';
import 'package:tintpin14_app/feature/home/presentations/ai_response_screen.dart';
import 'package:tintpin14_app/feature/home/presentations/home_screen.dart';
import 'package:tintpin14_app/feature/profile/presentation/screens/profile_screen.dart';
import 'package:tintpin14_app/gen/colors.gen.dart';
// Import your custom clipper and bar here

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _selectedIndex = 1; // Start with Home (Center) selected

  // List of screens for the navigation
  final List<Widget> _screens = [
    const AiResponseScreen(),
    HomeScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GlowBackground(
      // backgroundColor: const Color(0xFF050511),
      // extendBody:
      //     true, // This allows the screen content to go behind the Nav Bar
      child: _screens[_selectedIndex],
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110.h,
      color: Colors.transparent,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // 1. The Wavy Background
          ClipPath(
            clipper: BottomNavClipper(),
            child: Container(
              height: 100.h,
              color: AppColors.c0E1D50, // Dark Navy
              padding: EdgeInsets.symmetric(horizontal: 45.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Analytics Icon
                  GestureDetector(
                    onTap: () => onTap(0),
                    child: Icon(
                      Icons.analytics_outlined,
                      color: currentIndex == 0 ? Colors.white : Colors.white38,
                      size: 28.sp,
                    ),
                  ),
                  // Profile Icon
                  GestureDetector(
                    onTap: () => onTap(2),
                    child: Icon(
                      Icons.person_outline,
                      color: currentIndex == 2 ? Colors.white : Colors.white38,
                      size: 28.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 2. The Floating Home Button (Diamond Shape)
          Positioned(
            top: 5.h,
            left: 190.w,
            child: GestureDetector(
              onTap: () => onTap(1),
              child: Container(
                width: 65.w,
                height: 65.w,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF2E3BFF).withOpacity(0.4),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                  gradient: const LinearGradient(
                    colors: [Color(0xFF2E3BFF), Color(0xFF0015FF)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(22.r),
                ),
                // Rotate the container to create the Diamond
                transform: Matrix4.rotationZ(0.785),
                child: Transform.rotate(
                  angle: -0.785, // Rotate icon back so it's upright
                  child: Icon(
                    Icons.home_filled,
                    color: Colors.white,
                    size: 32.sp,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BottomNavClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // Must be named getClip
    Path path = Path();
    path.moveTo(0, 25);

    // Left Peak
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 25);

    // The Center Dip (Where the Diamond sits)
    path.quadraticBezierTo(size.width * 0.5, 55, size.width * 0.65, 25);

    // Right Peak
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 25);

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
