import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pubby_for_youtube/UI%20Helpers/constants.dart';

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
  List _pagesToNavigateTo = [
    HomeScreen(),
    NotificationsScreen(),
    NotificationsScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenlHeight / 14,
      child: BottomNavigationBar(
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
          items: const [
            BottomNavigationBarItem(
                activeIcon: Icon(
                  Icons.home,
                  size: 60,
                ),
                label: "Home",
                icon: Icon(
                  size: 50,
                  Icons.home,
                  color: Colors.black,
                )),
            BottomNavigationBarItem(
                activeIcon: Icon(
                  Icons.notifications_none_outlined,
                  size: 60,
                ),
                label: "Notifications",
                icon: Icon(
                  size: 50,
                  Icons.notifications_none_outlined,
                  color: Colors.black,
                )),
            BottomNavigationBarItem(
                activeIcon: Icon(
                  Icons.person,
                  size: 60,
                ),
                label: "Profile",
                icon: Icon(
                  size: 50,
                  Icons.person,
                  color: Colors.black,
                )),
          ]),
    );
  }
}
