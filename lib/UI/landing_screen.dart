import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pubby_for_youtube/UI%20Helpers/constants.dart';
import 'package:pubby_for_youtube/UI/register_screen.dart';

import 'login_screen.dart';

class LandingScreen extends StatefulWidget {
  LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assetss/clouds.jpg"), fit: BoxFit.fill)),
      child: Column(children: [
        SizedBox(
          height: 180,
          width: double.infinity,
        ),
        Image(
            image: AssetImage(
              "assetss/landingFirstTitle.png",
            ),
            color: Colors.black),
        SizedBox(
          height: 70,
        ),
        Image(
          image: AssetImage(
            "assetss/secondLandingTitle.png",
          ),
          color: Colors.black,
          fit: BoxFit.fill,
          height: screenlHeight / 25,
          width: screenWidth / 1.3,
        ),
        SizedBox(
          height: 380,
        ),
        LoginAndSignupButton(text: "Login", direction: LoginPage()),
        SizedBox(
          height: 30,
        ),
        LoginAndSignupButton(text: "Sign Up", direction: RegisterPage()),
      ]),
    );
  }
}

class LoginAndSignupButton extends StatelessWidget {
  LoginAndSignupButton({Key? key, required this.text, required this.direction})
      : super(key: key);
  var direction;
  String text;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(22))),
          backgroundColor: MaterialStateProperty.all(Colors.black),
          minimumSize: MaterialStateProperty.all(
              Size(screenWidth / 3, screenlHeight / 17))),
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => direction,
        ));
      },
      child: Text(
        text,
        style: TextStyle(fontSize: 23),
      ),
    );
  }
}
