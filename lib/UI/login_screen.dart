import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pubby_for_youtube/UI/register_screen.dart';

import '../UI Helpers/blur_screen_maker.dart';
import '../UI Helpers/constants.dart';
import '../UI Helpers/sign_in_social.dart';
import '../main.dart';
import 'forgot_password_screen.dart';
import 'home_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController(text: "omergencbtf@gmail.com");
  final passwordController = TextEditingController(text: "1234567");
  bool isVisible = false;
  // late FirebaseAuth auth;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            InkWell(onTap: () {}, child: MyApp()),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 55.h),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: BlueScreenMaker(
                              xAxis: 15.0,
                              yAxis: 15.0,
                              height: screenlHeight / 1.7,
                              width: screenWidth / 1.2,
                              child: _buildForm(context),
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Form _buildForm(BuildContext context) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text("Login",
                style: GoogleFonts.poppins(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.black54,
                )),
            SizedBox(
              height: screenlHeight / 20,
            ),
            _buildEmailField(),
            SizedBox(
              height: 16.h,
            ),
            _buildPasswordField(),
            SizedBox(height: 16.h),
            _buildSignInButton(context),
            SizedBox(
              height: 48,
            ),
            _buildDivider(),
            SizedBox(
              height: 48,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // iconlarin basladigi yer

                  SignInSocial.buildSocial(
                      context,
                      const FaIcon(
                        FontAwesomeIcons.apple,
                        color: Colors.black,
                      )),
                  SizedBox(width: 16.w),
                  SignInSocial.buildSocial(
                      context,
                      const FaIcon(
                        FontAwesomeIcons.google,
                        color: Colors.black,
                      )),
                ],
              ),
            ),
            SizedBox(
              height: 90,
            ),
            _buildForgotPassword(context),
            SizedBox(height: 16.h),
            buildNoAccount(context)
          ],
        ),
      ),
    );
  }

  Divider _buildDivider() {
    return Divider(
      height: 2,
      thickness: 0.5,
      indent: 10,
      endIndent: 0,
      color: Colors.black,
    );
  }

  bool isValidEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  Widget _buildEmailField() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 1.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          color: Colors.white.withOpacity(0.6),
        ),
        child: TextFormField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          validator: (value) {
            if (value!.isEmpty) {
              callSnackbar('Email boş olamaz.');
              return '';
            } else if (!isValidEmail(value)) {
              callSnackbar('Email formatı hatalı');
              return '';
            }
            return null;
          },
          decoration: const InputDecoration(
            labelText: "Email",
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  callSnackbar(String error, [Color? color, VoidCallback? onVisible]) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
      //padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      backgroundColor: color ?? Colors.red,
      duration: Duration(milliseconds: 500),
      onVisible: onVisible,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      content: SizedBox(
        width: 40.w,
        height: 40.h,
        child: Center(
          child: Text(error, style: const TextStyle(color: Colors.white)),
        ),
      ),
    ));
  }

  Widget _buildPasswordField() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 20),
        child: TextFormField(
          controller: passwordController,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
              border: InputBorder.none,
              label: Padding(
                padding: EdgeInsets.only(left: 22.w),
                child: Text("Password"),
              ),
              suffixIcon: InkWell(
                  onTap: () {
                    setState(() {
                      isVisible = !isVisible;
                    });
                  },
                  child: Icon(
                      isVisible ? Icons.visibility : Icons.visibility_off))),
          obscureText: !isVisible,
        ),
      ),
    );
  }

  GestureDetector _buildForgotPassword(BuildContext context) {
    return GestureDetector(
        child: const Text(
          "Forgot Password?",
          style: TextStyle(
              fontSize: 23,
              decoration: TextDecoration.underline,
              color: Colors.black54),
        ),
        // şifre unuttum kismi burda birazdan yap
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ForgotPassword()));
        });
  }

  RichText buildNoAccount(BuildContext context) {
    return RichText(
        text: TextSpan(
            style: const TextStyle(color: Colors.black54, fontSize: 24),
            text: "No Account? ",
            children: [
          TextSpan(
              // hesabın olmaması burda
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterPage(),
                      ),
                      (route) => true);
                },
              text: 'Sign Up',
              style: const TextStyle(
                decoration: TextDecoration.underline,
                color: Colors.black54,
              )),
        ]));
  }

  ElevatedButton _buildSignInButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          onPrimary: Colors.black,
          primary: Colors.black,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          minimumSize: const Size(double.infinity, 50)),
      onPressed: () async {
        if (true) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ),
              (route) => false);
        } else {
          callSnackbar("Giriş Başarısız");
        }
      },
      child: Text("Sign In",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          )),
    );
  }
}
