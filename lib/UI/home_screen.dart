
import 'package:flutter/material.dart';

import '../UI Helpers/bottom_bar.dart';
import '../UI Helpers/card_for_fotune_tellers.dart';
import '../UI Helpers/constants.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomBar(
          selectedIndex: 0,
        ),
        body: Container(
          child: Column(
            children: [
              SizedBox(
                height: screenlHeight / 20 as double,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                ),
                child: Container(
                  width: screenWidth / 1,
                  height: screenlHeight / 1 / (12 / 10.5),
                  child: GridView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return CardForFortuneTellers();
                    },
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: 500,
                      mainAxisSpacing: 0, //screenlHeight / 20,
                      crossAxisCount: 2,
                    ),
                    itemCount: 10,
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
