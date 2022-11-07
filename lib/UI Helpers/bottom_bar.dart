import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pubby_for_youtube/UI%20Helpers/constants.dart';
import 'package:pubby_for_youtube/UI/Messages/message_box_screen.dart';
import 'package:pubby_for_youtube/UI/admin_panel.dart';
import 'package:pubby_for_youtube/UI/deneme.dart';
import 'package:pubby_for_youtube/UI/own_profile_screen.dart';
import 'package:pubby_for_youtube/UI/video_playing_screen.dart';
import '../UI/home_screen.dart';
import '../UI/notifications_screen.dart';

class BottomBar extends StatefulWidget {
  int selectedIndex;

  BottomBar({super.key, required this.selectedIndex});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  var _index = 0;
  final List _pagesToNavigateTo = [
    HomeScreen(),
    NotificationsScreen(),
    // AdminPanel(),
    OwnProfileScreen(),
    MessageScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight / 14,
      child: BottomNavigationBar(
          selectedItemColor: Colors.blue,
          selectedFontSize: 0,
          currentIndex: widget.selectedIndex,
          onTap: (value) {
            _index = value;
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => _pagesToNavigateTo[value],
                ),
                (route) => false);
            setState(() {});
          },
          items: [
            BottomNavigationBarItem(
                activeIcon: Icon(
                  Icons.home,
                  size: 60.sp,
                ),
                label: "Home",
                icon: Icon(
                  size: 50.sp,
                  Icons.home,
                  color: Colors.black,
                )),
            BottomNavigationBarItem(
                activeIcon: Icon(
                  Icons.notifications_none_outlined,
                  size: 60.sp,
                ),
                label: "Notifications",
                icon: Icon(
                  size: 50.sp,
                  Icons.notifications_none_outlined,
                  color: Colors.black,
                )),
            BottomNavigationBarItem(
                activeIcon: Icon(
                  Icons.person,
                  size: 60.sp,
                ),
                label: "Profile",
                icon: Icon(
                  size: 50.sp,
                  Icons.person,
                  color: Colors.black,
                )),
            BottomNavigationBarItem(
                activeIcon: Icon(
                  Icons.message,
                  size: 60.sp,
                ),
                label: "Profile",
                icon: Icon(
                  size: 50.sp,
                  Icons.message,
                  color: Colors.black,
                )),
          ]),
    );
  }
}
