import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pubby_for_youtube/UI%20Helpers/constants.dart';

import '../UI Helpers/bottom_bar.dart';

class NotificationsScreen extends StatefulWidget {
  NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomBar(selectedIndex: 1),
      body: Container(
        color: Color(0xffeef3f8),
        child: Column(children: [
          SizedBox(
            width: double.infinity,
          ),
          Container(
            width: screenWidth - 30,
            height: screenHeight /
                (13 /
                    12), // Bu şekilde ondalık sayı yerine kesirli sayı kullanmanız sayıların değerlerini orantılı olarak yükselterek hassas ölçümler yapmanızı sağlar.
            //  color: Colors.black,
            child: ListView.separated(
              separatorBuilder: (context, index) => SizedBox(
                height: screenHeight / 45,
              ),
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return index == 0
                    ? Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: screenHeight / 15,
                          ),
                          Text(
                            "Eşleşmelerin!",
                            style: TextStyle(
                                fontFamily: fontFamilyCambria,
                                fontSize: 70,
                                fontWeight: FontWeight.w300),
                          ),
                          SizedBox(
                            height: screenHeight / 22,
                          ),
                        ],
                      )
                    : CardsForNotifications();
              },
            ),
          ),
        ]),
      ),
    );
  }
}

class CardsForNotifications extends StatefulWidget {
  const CardsForNotifications({super.key});

  @override
  State<CardsForNotifications> createState() => _CardsFornyificationsState();
}

class _CardsFornyificationsState extends State<CardsForNotifications> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey.shade400,
          offset: Offset(1, 2),
          blurRadius: 1,
          blurStyle: BlurStyle.outer,
        ),
      ], borderRadius: BorderRadius.circular(22), color: Colors.white),
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
            backgroundImage: AssetImage("assetss/teacherman.jpg"),
          ),
          SizedBox(
            width: screenWidth / 32,
          ),
          Column(
            children: [
              SizedBox(
                height: screenHeight / 55,
              ),
              Container(
                width: screenWidth / 1.6,
                height: screenHeight / 10,
                color: Colors.white,
                child: const Text(
                  softWrap: true,
                  "Jack Mallon ile aynı anda \"Azer bülbül - sigarayı bıraktım\" dinlediniz",
                  style: TextStyle(
                      fontSize: 33, fontFamily: "Javanese", height: 1.2),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
