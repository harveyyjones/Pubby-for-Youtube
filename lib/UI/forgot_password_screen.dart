import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 10.h),
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Color.fromARGB(255, 255, 255, 255),
              Color.fromARGB(255, 255, 255, 255)
            ])),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Enter Your E Mail",
                  style: TextStyle(
                      fontFamily: "Calisto",
                      fontSize: 35.sp,
                      color: Color.fromARGB(255, 0, 0, 0))),
              SizedBox(
                height: 40.h,
              ),
              _buildEmailField(),
              SizedBox(
                height: 40.h,
              ),
              _buildSignInButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return Container(
      width: 300.w,
      height: 80.h,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 1),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            color: Colors.white.withOpacity(0.6),
          ),
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              labelText: "Email",
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignInButton() {
    return Container(
      width: 200,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            onPrimary: Colors.black,
            primary: Colors.black,
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            minimumSize: const Size(double.infinity, 50)),
        onPressed: () {
          CoolAlert.show(
            text:
                "We've sent a verification link to your e mail. Please check your inbox.",
            context: context,
            type: CoolAlertType.success,
            barrierDismissible: false,
            onConfirmBtnTap: () {
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                builder: (context) {
                  return MyApp();
                },
              ), (route) => false);
            },
          );
        },
        child: Text("Submit",
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            )),
      ),
    );
  }
}
