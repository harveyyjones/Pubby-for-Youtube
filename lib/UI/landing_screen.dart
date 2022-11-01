import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
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
      decoration: const BoxDecoration(color: Color.fromARGB(255, 237, 245, 254)
          // image: DecorationImage(
          //     image: AssetImage("assetss/clouds.jpg"), fit: BoxFit.fill)),
          ),
      child: Column(children: [
        SizedBox(
          height: screenHeight / 19,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: LottieBuilder.asset(
            "assetss/fire.json",
            width: screenWidth / 1.5,
            height: screenHeight / 3,
          ),
        ),
        SizedBox(
          height: screenHeight / 38,
          width: double.infinity,
        ),
        Text("Welcome to the Pubby \n          for Youtube",
            style: TextStyle(
                height: 1.7,
                fontSize: 44.sp,
                fontFamily: "Javanese",
                wordSpacing: 12)),
        SizedBox(
          height: screenHeight / 30,
        ),
        const Text("Have an account?",
            style: TextStyle(
                height: 1.7,
                fontSize: 35,
                fontFamily: "Javanese",
                wordSpacing: 12)),
        LoginAndSignupButton(text: "Login", direction: LoginPage()),
        SizedBox(
          height: screenHeight / 200,
        ),
        Text(
          "or",
          style: TextStyle(fontFamily: "Javanese", fontSize: 38.sp),
        ),
        LoginAndSignupButton(text: "Register", direction: RegisterPage())
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
    return InkWell(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => direction,
      )),
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            offset: Offset(1, 2),
            blurRadius: 1,
            blurStyle: BlurStyle.outer,
          ),
        ], borderRadius: BorderRadius.circular(22), color: Colors.white),
        width: screenWidth / 2.5,
        height: screenHeight / 12,
        child: Center(
          child: Text(
            text,
            style: TextStyle(fontSize: 33.sp, fontFamily: "Javanese"),
          ),
        ),
      ),
    );
  }
}
