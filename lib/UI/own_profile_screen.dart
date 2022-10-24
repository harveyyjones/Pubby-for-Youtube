import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pubby_for_youtube/UI%20Helpers/constants.dart';
import 'package:pubby_for_youtube/UI/profile_settings_screen.dart';
import 'package:pubby_for_youtube/UI/steppers.dart';
import '../UI Helpers/bottom_bar.dart';
import '../business_logic/firestore_database_service.dart';

class OwnProfileScreen extends StatefulWidget {
  OwnProfileScreen({Key? key}) : super(key: key);

  @override
  State<OwnProfileScreen> createState() => _OwnProfileScreenState();
}

class _OwnProfileScreenState extends State<OwnProfileScreen> {
  String get text => "Message";

  @override
  Widget build(BuildContext context) {
    FirestoreDatabaseService _serviceForSnapshot = FirestoreDatabaseService();
    return Scaffold(
      bottomNavigationBar: BottomBar(selectedIndex: 2),
      body: StreamBuilder(
          stream: _serviceForSnapshot.getProfileData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                width: double.infinity,
                height: double.infinity,
                color: Color(0xffeef3f8),
                // width: screenWidth,
                // height: screenHeight,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: screenHeight / 7,
                      ),
                      Stack(
                        children: [
                          CircleAvatar(
                              maxRadius: screenWidth / 3.3,
                              minRadius: 20,
                              backgroundImage: NetworkImage(
                                  snapshot.data!["profilePhotoURL"] ?? "")),
                          Positioned(
                              bottom: screenHeight / 220,
                              right: screenWidth / 15,
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          ProfileSettings() //ProfileSettings(),
                                      ));
                                },
                                child: Hero(
                                  tag: "Profile Screen",
                                  child: SvgPicture.asset(
                                    "assetss/settings.svg",
                                    width: screenWidth / 80,
                                    height: screenHeight / 15,
                                  ),
                                ),
                              )),
                        ],
                      ),
                      SizedBox(
                        height: screenHeight / 30,
                      ),

                      Text(
                        snapshot.data!["name"] ?? currentUser!.displayName,
                        style: TextStyle(
                            fontFamily: "Javanese",
                            fontSize: 55.sp,
                            color: Color(0xff707070)),
                      ),
                      // ********** BİYOGRAFİ *********
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 55),
                        child: Text(
                          snapshot.data!["biography"] ??
                              "That'd be just okay if you listen Rock.",
                          softWrap: true,
                          style: TextStyle(
                              fontFamily: "Javanese",
                              height: 1.3,
                              fontSize: 36.sp,
                              color: Color(0xff707070)),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight / 25,
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }
}
