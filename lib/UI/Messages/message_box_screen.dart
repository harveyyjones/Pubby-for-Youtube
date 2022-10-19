// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pubby_for_youtube/main.dart';

import '../../UI Helpers/bottom_bar.dart';

class MessageScreen extends StatefulWidget {
  MessageScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  ScaffoldMessengerState snackBar = ScaffoldMessengerState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomBar(
          selectedIndex: 3,
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 22.h),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return MyApp();
                      },
                    )),
                    child: Column(
                      children: [
                        Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 9.h),
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 18.w),
                                  child: CircleAvatar(
                                      maxRadius: 47,
                                      minRadius: 20,
                                      backgroundImage:
                                          AssetImage("assetss/teacherman.jpg")),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: 20.w, bottom: 12.h),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(right: 370.w),
                                        //    color: Colors.amber,
                                        child: Text("Ömer",
                                            style: TextStyle(
                                                fontSize: 30.sp,
                                                fontFamily: "Calisto")),
                                      ),
                                      Container(
                                        width: 540,
                                        //  color: Colors.blue,
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 20.h),
                                          child: const Text(
                                            "With hope in your heart and you'll never walk alone ",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 25,
                                                color: Color.fromARGB(
                                                    255, 117, 113, 113),
                                                fontFamily: "Calisto"),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        Divider(
                          color: Colors.black.withOpacity(0.4),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
