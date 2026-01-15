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
