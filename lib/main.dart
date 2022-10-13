import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pubby_for_youtube/UI/landing_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(720, 1080),
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          title: 'Pubby for Youtube',
          home: Scaffold(body: LandingScreen()),
        );
      },
    );
  }
}
