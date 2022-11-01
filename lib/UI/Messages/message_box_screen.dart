// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pubby_for_youtube/main.dart';

import '../../UI Helpers/bottom_bar.dart';
import '../../UI Helpers/constants.dart';

class MessageScreen extends StatefulWidget {
  MessageScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  String messageToDisplay =
      ' \n you accept the Xogggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg';
  ScaffoldMessengerState snackBar = ScaffoldMessengerState();

  @override
  Widget build(BuildContext context) {
    String _name = "Jack Mallon";
    return Scaffold(
        bottomNavigationBar: BottomBar(
          selectedIndex: 3,
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 22.h),
          child: Container(
            color: Color.fromARGB(255, 227, 239, 252),
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(
                      height: screenHeight / 55,
                    ),
                    itemCount: 5,
                    itemBuilder: (context, index) => InkWell(
                        onTap: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return MyApp();
                              },
                            )),
                        child: Container(
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade400,
                                  offset: Offset(1, 2),
                                  blurRadius: 1,
                                  blurStyle: BlurStyle.outer,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(22),
                              color: Colors.white),
                          width: screenWidth / 1.1,
                          height: screenHeight / 7,
                          child: Row(
                            children: [
                              SizedBox(
                                width: screenWidth / 33,
                              ),
                              CircleAvatar(
                                maxRadius: screenWidth / 11,
                                minRadius: 20,
                                backgroundImage:
                                    AssetImage("assetss/teacherman.jpg"),
                              ),
                              SizedBox(
                                width: screenWidth / 32,
                              ),
                              Flexible(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: screenHeight / 55,
                                    ),
                                    Container(
                                      width: screenWidth / 1.6,
                                      height: screenHeight / 10,
                                      // color: Color.fromARGB(255, 196, 19, 19),
                                      child: RichText(
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.start,
                                        softWrap: true,
                                        text: TextSpan(
                                          text: '${_name}',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 33.sp,
                                              fontFamily: fontFamilyJavanese),
                                          children: [
                                            TextSpan(
                                              text: messageToDisplay.length >=
                                                      30
                                                  ? '${messageToDisplay.substring(0, 30)}...'
                                                  : messageToDisplay,
                                              style: TextStyle(
                                                  color: Colors.grey.shade600,
                                                  fontSize: 24.sp,
                                                  fontFamily: "Javanese",
                                                  height: 1),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
