import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pubby_for_youtube/UI%20Helpers/constants.dart';

class CardDetailScreen extends StatefulWidget {
  CardDetailScreen({Key? key}) : super(key: key);

  @override
  State<CardDetailScreen> createState() => _CardDetailScreenState();
}

class _CardDetailScreenState extends State<CardDetailScreen> {
  String commentText =
      "With hope in your heart and you'll never walk alone aoskaksokaoskaoooooooooooooossaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaasaaaaaaaaaaaaaaaaaaaaaaaaaasaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // width: screenWidth,
        // height: screenlHeight,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            alignment: Alignment.topCenter,
                            image: AssetImage("assetss/teacherman.jpg"),
                            fit: BoxFit.cover)),
                    width: screenWidth,
                    height: screenlHeight / 2,
                  ),
                  Positioned(
                    bottom: screenlHeight / 50,
                    right: screenWidth / 20,
                    child: Image.asset('icons/flags/png/us.png',
                        package: 'country_icons'),
                  ),
                ],
              ),
              SizedBox(
                height: screenlHeight / 77,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                //  mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: screenWidth / 7,
                  ),
                  Text(
                    "James Marlon",
                    style: TextStyle(
                        fontFamily: "Cambria",
                        fontSize: 55.sp,
                        color: colorOfTitleInHomeScreen),
                  ),
                  SizedBox(
                    width: screenWidth / 6,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      width: 66,
                      height: 66,
                      child: Image(
                        fit: BoxFit.fill,
                        image: AssetImage("assetss/messageBubble.png"),
                      ),
                    ),
                  )
                ],
              ),
              // ********** BİYOGRAFİ *********
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Text(
                  "Hi, I'm an english teacher who loves teaching something to kids and fuck them. If you want me to rape your kids just let me know. 😊❤👌",
                  softWrap: true,
                  style: TextStyle(
                      fontFamily: "Cambria",
                      fontSize: 33.sp,
                      color: colorOfTitleInHomeScreen),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(
                    right: screenWidth / 3.5, left: screenWidth / 10),
                child: Row(
                  children: [
                    RatingBar.builder(
                      initialRating: 3,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: false,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                    Text(
                      "4.0",
                      softWrap: true,
                      style: TextStyle(
                          fontFamily: "Cambria",
                          fontSize: 33.sp,
                          color: colorOfTitleInHomeScreen),
                    ),
                    SizedBox(
                      width: screenWidth / 22,
                    ),
                    // TODO: Ayarlar kısmından dil seviyesi çekilip buraya atanacak. Kayıt olduktan sonrada sorulabilir.

                    Text(
                      " - Native",
                      softWrap: true,
                      style: TextStyle(
                          fontFamily: "Cambria",
                          fontSize: 40.sp,
                          color: colorOfTitleInHomeScreen),
                    ),
                  ],
                ),
              ),
// ******* ÖDEME BUTONU **********
              Row(
                children: [
                  SizedBox(
                    width: screenWidth / 11,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: screenlHeight / 45),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        "Book",
                        style: TextStyle(
                            fontSize: 30.sp,
                            fontFamily: fontFamilyCambria,
                            fontWeight: FontWeight.w700),
                      ),
                      style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all(
                            Size(screenWidth / 3, screenlHeight / 17)),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: screenWidth / 15,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: screenlHeight / 50),
                    child: Text(
                      "18\$ / Hour",
                      style: TextStyle(
                          fontSize: 35.sp,
                          fontFamily: fontFamilyCambria,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: screenlHeight / 27,
              ),
              Padding(
                padding: EdgeInsets.only(right: screenWidth / 1.5),
                child: Text(
                  "Comments",
                  softWrap: true,
                  style: TextStyle(
                      fontFamily: "Cambria",
                      fontSize: 33.sp,
                      color: Colors.grey),
                ),
              ),
              Column(
                children: [...sortComments()],
              )
            ],
          ),
        ),
      ),
    );
  }

  sortComments() {
    // Burada firebase'den gelen comment sayısını bir listeye koyarsın.
    int commentsCameFromFirebase = 100;
    List commentList = [];
    for (var i = 0; i < commentsCameFromFirebase; i++) {
      commentList.add(Column(children: [
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                  maxRadius: 47,
                  minRadius: 20,
                  backgroundImage: AssetImage("assetss/teacherman.jpg")),
              SizedBox(
                width: screenWidth / 30,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 90,
                  ),
                  Container(
                    //    color: Colors.amber,
                    padding: EdgeInsets.only(right: screenWidth / 1.7),
                    child: Text("Micheal",
                        style:
                            TextStyle(fontSize: 30.sp, fontFamily: "Calisto")),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: screenlHeight / 60),
                    width: 540,

                    //  color: Colors.blue,
                    child: Text(
                      commentText,
                      maxLines: 15,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 25.sp,
                          color: const Color.fromARGB(255, 35, 33, 33),
                          fontFamily: "Calisto"),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ]));
    }
    return commentList;
  }
}
