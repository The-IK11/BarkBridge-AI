import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tintpin14_app/common_widgets/glow_background.dart';
import 'package:tintpin14_app/feature/home/presentations/ai_response_screen.dart';
import 'package:tintpin14_app/feature/home/presentations/home_screen.dart';
import 'package:tintpin14_app/feature/profile/presentation/screens/profile_screen.dart';
import 'package:tintpin14_app/gen/assets.gen.dart';
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
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      // backgroundColor: const Color(0xFF050511),
      // extendBody:
      //     true, // This allows the screen content to go behind the Nav Bar
      child: _screens[_selectedIndex],
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
      // height: 110.h,
      color: Colors.transparent,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 90.h,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Assets.icons.navigationBar.path),
              ),
            ),
            child: Row(
              children: [
                // Left Icon (Analytics)
                Expanded(
                  child: InkWell(
                    onTap: () => onTap(0),
                    child: Container(
                      color: Colors.transparent,
                      child: Image.asset(
                        height: 25.h,
                        width: 25.h,
                        Assets.icons.resultIcon.path,
                        color: currentIndex == 0 ? Colors.white : null,
                      ),
                    ),
                  ),
                ),

                // Spacer for the middle button
                SizedBox(width: 100.w),

                // Right Icon (Profile)
                Expanded(
                  child: InkWell(
                    onTap: () => onTap(2),
                    child: Container(
                      color: Colors.transparent,
                      child: Image.asset(
                        height: 25.h,
                        width: 25.h,
                        Assets.icons.profileIcon.path,
                        color: currentIndex == 2 ? Colors.white : null,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 2. The Floating Home Button (Diamond Shape)
          Positioned(
            top: -15.h,
            left: 114.w,
            child: Container(
              padding: EdgeInsets.only(top: 16.h),
              width: 141.w,
              height: 81.h,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Assets.icons.navigationBarMiddlePart.path),
                ),
              ),

              // Rotate the container to create the Diamond
              child: InkWell(
                onTap: () => onTap(1),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    height: 25.h,
                    width: 25.w,
                    currentIndex == 1
                        ? Assets.icons.selectedHomeIcon.path
                        : Assets.icons.homeIcon.path,
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
