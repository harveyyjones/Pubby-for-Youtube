import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pubby_for_youtube/UI%20Helpers/constants.dart';
import 'package:pubby_for_youtube/UI/Messages/message_box_screen.dart';
import 'package:pubby_for_youtube/UI/profile_settings_screen.dart';
import 'package:pubby_for_youtube/main.dart';

import '../UI Helpers/bottom_bar.dart';

class OwnProfileScreen extends StatefulWidget {
  OwnProfileScreen({Key? key}) : super(key: key);

  @override
  State<OwnProfileScreen> createState() => _OwnProfileScreenState();
}

class _OwnProfileScreenState extends State<OwnProfileScreen> {
  String get text => "Message";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomBar(selectedIndex: 2),
      body: Container(
        height: double.infinity,
        color: Color(0xffeef3f8),
        // width: screenWidth,
        // height: screenlHeight,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: screenlHeight / 10,
              ),
              Stack(
                children: [
                  CircleAvatar(
                      maxRadius: screenWidth / 3.3,
                      minRadius: 20,
                      backgroundImage: AssetImage("assetss/teacherman.jpg")),
                  Positioned(
                      bottom: screenlHeight / 220,
                      right: screenWidth / 15,
                      child: InkWell(
                        onTap: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ProfileSettings(),
                        )),
                        child: Hero(
                          tag: "Profile Screen",
                          child: SvgPicture.asset(
                            "assetss/settings.svg",
                            width: screenWidth / 80,
                            height: screenlHeight / 15,
                          ),
                        ),
                      )),
                ],
              ),
              SizedBox(
                height: screenlHeight / 30,
              ),

              Text(
                "James Marlon",
                style: TextStyle(
                    fontFamily: "Javanese",
                    fontSize: 55.sp,
                    color: Color(0xff707070)),
              ),
              // ********** BİYOGRAFİ *********
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 55),
                child: Text(
                  "Hi, I'm an english teacher who loves teaching something to kids and fuck them. If you want me to rape your kids just let me know. 😊❤👌",
                  softWrap: true,
                  style: TextStyle(
                      fontFamily: "Javanese",
                      height: 1.3,
                      fontSize: 36.sp,
                      color: Color(0xff707070)),
                ),
              ),
              SizedBox(
                height: screenlHeight / 25,
              ),
              InkWell(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MessageScreen(),
                )),
                child: Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          offset: Offset(1, 2),
                          blurRadius: 9,
                          blurStyle: BlurStyle.inner,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(33),
                      color: Colors.white),
                  width: screenWidth / 2.5,
                  height: screenlHeight / 12,
                  child: Center(
                    child: Text(
                      text,
                      style: TextStyle(fontSize: 36, fontFamily: "Javanese"),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
