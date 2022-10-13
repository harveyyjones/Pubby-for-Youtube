import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pubby_for_youtube/UI%20Helpers/constants.dart';

import '../UI/card_details.dart';

class CardForFortuneTellers extends StatefulWidget {
  CardForFortuneTellers({super.key});

  @override
  State<CardForFortuneTellers> createState() => _CardForFortuneTellersState();
}

class _CardForFortuneTellersState extends State<CardForFortuneTellers> {
  var rating;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        InkWell(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CardDetailScreen(),
          )),
          child: Container(
            width: screenWidth / 2.5,
            height: screenlHeight / 5,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                // color: Colors.amber,
                image: const DecorationImage(
                    fit: BoxFit.cover,
                    // TODO: Firebase'den yüksek puanlı olanlar arasından random çekilecek.
                    image: AssetImage("assetss/teacherman.jpg"))),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Alica Keys",
          style: TextStyle(
              fontFamily: fontFamilyCambria,
              fontSize: 37,
              color: Color.fromARGB(255, 64, 62, 62)),
        ),
        Text(
          "Fortune Teller",
          style: TextStyle(
              fontFamily: fontFamilyCambria,
              fontSize: 30,
              color: Color.fromARGB(255, 64, 62, 62)),
        ),
        Container(
          width: 350,
          height: 100,
          //  color: Colors.purple,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RatingBar.builder(
                initialRating: 3,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
              Text(
                "18\$ / Hour  ",
                style: TextStyle(fontFamily: fontFamilyCambria, fontSize: 35),
              )
            ],
          ),
        )
      ],
    );
  }
}
