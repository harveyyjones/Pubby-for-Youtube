import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pubby_for_youtube/UI%20Helpers/constants.dart';
import 'package:pubby_for_youtube/UI/Messages/chat_screen.dart';
import 'package:pubby_for_youtube/UI/steppers.dart';
import 'package:pubby_for_youtube/business_logic/firestore_database_service.dart';
import 'package:pubby_for_youtube/business_logic/user_model.dart';

import '../UI Helpers/bottom_bar.dart';

class NotificationsScreen extends StatefulWidget {
  NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  late FirestoreDatabaseService _service = FirestoreDatabaseService();
  _getUserDatas() async {
    List? _usersList;
    _usersList = await _service.getUserDataViaUId();
    print(await _usersList![0].userId);
    return _usersList;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomBar(selectedIndex: 1),
      body: FutureBuilder(
          future: _getUserDatas(),
          builder: (context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              return Container(
                color: Color.fromARGB(255, 234, 243, 252),
                child: Column(children: [
                  const SizedBox(
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
                      itemCount: snapshot.data.length + 1,
                      itemBuilder: (BuildContext context, int index) {
                        return index == 0
                            ? Column(
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    height: screenHeight / 15,
                                  ),
                                  Text(
                                    "Something",
                                    style: TextStyle(
                                        fontFamily: fontFamilyCambria,
                                        fontSize: 70.sp,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  SizedBox(
                                    height: screenHeight / 22,
                                  ),
                                ],
                              )
                            : CardsForNotifications(
                                name: snapshot.data[index - 1].name,
                                profilePhotoUrl:
                                    snapshot.data[index - 1].profilePhotoURL,
                                index: index - 1,
                                userId: snapshot.data[index - 1].userId,
                              );
                      },
                    ),
                  ),
                ]),
              );
            } else {
              //TODO: Buralara daha güzel gözüken bir loading ekranı ayarlanacak.
              return Center(
                  child: CircularProgressIndicator(
                color: Colors.black,
              ));
            }
          }),
    );
  }
}

class CardsForNotifications extends StatefulWidget {
  var name;
  var profilePhotoUrl;
  var index;
  String userId;
  CardsForNotifications({
    super.key,
    required this.name,
    required this.profilePhotoUrl,
    required this.index,
    required this.userId,
  });

  @override
  State<CardsForNotifications> createState() => _CardsFornyificationsState();
}

class _CardsFornyificationsState extends State<CardsForNotifications> {
  FirestoreDatabaseService _firestoreDatabaseService =
      FirestoreDatabaseService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _firestoreDatabaseService.getTheMutualSongViaUId(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return InkWell(
            onTap: () => Navigator.of(context, rootNavigator: false)
                .push(MaterialPageRoute(
              builder: (context) => ChatScreen(
                
                  userToChatWith: widget.userId),
            )),
            // onTap: () => Navigator.of(context).push(MaterialPageRoute(
            //   builder: (context) => ChatScreen(),
            // )),
            child: Container(
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
                      backgroundImage: NetworkImage(widget.profilePhotoUrl)),
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
                        child: Text(
                          softWrap: true,
                          "${widget.name} ile aynı anda  \"${snapshot.data![widget.index].toString()}\" dinlediniz .",
                          style: TextStyle(
                              fontSize: 33.sp,
                              fontFamily: fontFamilyCambria,
                              height: 1.2),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}
