import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pubby_for_youtube/UI%20Helpers/blur_screen_maker.dart';
import 'package:pubby_for_youtube/UI%20Helpers/constants.dart';
import 'package:pubby_for_youtube/UI/steppers.dart';
import 'landing_screen.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  bool isVisible = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      //resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          LandingScreen(),
          BlueScreenMaker(
              xAxis: 15.0,
              yAxis: 15.0,
              height: screenHeight,
              width: screenWidth,
              child: SizedBox()),
          Positioned(
            bottom: screenHeight / 3,
            right: screenWidth / 4.3,
            child: _buildForm(context),
          ),
        ],
      ),
    );
  }

// formun oluşturulması
  Form _buildForm(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            height: screenHeight / 33,
          ),
          Text("Sign Up",
              style: GoogleFonts.poppins(
                fontSize: 30.sp,
                fontWeight: FontWeight.w400,
                color: Colors.black54,
              )),
          SizedBox(
            height: 16.h,
          ),
          _buildname(),
          SizedBox(height: 16.h),
          _buildEmailField(),
          SizedBox(height: 16.h),
          _buildphoneNumber(),
          SizedBox(height: 16.h),
          _buildPasswordField(),
          SizedBox(height: 16.h),
          _buildRegisterInButton(context),
        ],
      ),
    );
  }

//isim kontrolü
  /* bool isValidName(String name) {
    return RegExp(r"^[a-z A-Z,.\-]+$").hasMatch(name);
  }*/

// isim alanı
  Widget _buildname() {
    return Container(
      width: screenWidth / 1.7,
      height: screenWidth / 9,
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
            controller: nameController,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value!.isEmpty) {
                callSnackbar('İsim boş olamaz!');
                return '';
              } else if (value.length < 2) {
                callSnackbar('İsminiz minumum iki karakterden oluşmalıdır!');
                return '';
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: "Name",
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }

  bool isValidEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

// e-mail alanı
  Widget _buildEmailField() {
    return Container(
      width: screenWidth / 1.7,
      height: screenWidth / 9,
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
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value!.isEmpty) {
                callSnackbar('Email boş olamaz!');
                return '';
              } else if (!isValidEmail(value)) {
                callSnackbar('Email formatı hatalı!');
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
      ),
    );
  }

// şifre alanı
  Widget _buildPasswordField() {
    return Container(
      width: screenWidth / 1.7,
      height: screenWidth / 9,
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
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  spreadRadius: 1,
                ),
              ]),
          child: TextFormField(
            controller: passwordController,
            validator: (value) {
              if (value!.isNotEmpty) {
                if (value.length > 6) {
                } else {
                  callSnackbar("Şifreniz minimum 6 haneli olmalıdır.");
                  return '';
                }
              } else {
                callSnackbar("Şifre alanı boş olamaz!");
                return '';
              }
              return null;
            },
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
                border: InputBorder.none,
                labelText: "Password",
                suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        isVisible = !isVisible;
                      });
                    },
                    child: const Icon(Icons.visibility))),
            obscureText: !isVisible,
          ),
        ),
      ),
    );
  }

  // telefon numarası kontrolü
  bool isValidphoneNumber(String phoneNumber) {
    return RegExp(r"(^(?:[+0]9)?[0-9]{10,12}$)").hasMatch(phoneNumber);
  }

// numara alanı
  Widget _buildphoneNumber() {
    return Container(
      width: screenWidth / 1.7,
      height: screenWidth / 9,
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
            controller: phoneNumberController,
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value!.isEmpty) {
                callSnackbar('Telefon numarası boş olamaz!');
                return '';
              } else if (!isValidphoneNumber(value)) {
                callSnackbar('Telefon numarası formatı hatalı!');
                return '';
              }
              return null;
            },
            textInputAction: TextInputAction.done,
            decoration: const InputDecoration(
              labelText: "Phone Number",
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }

// kayıt ol butonu
  _buildRegisterInButton(BuildContext context) {
    return Container(
      width: screenWidth / 2,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            onPrimary: Colors.black,
            primary: Colors.black,
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            minimumSize: const Size(double.infinity, 50)),
        onPressed: () async {
          print(formKey.currentContext!.size!.width);

          if (formKey.currentState!.validate()) {
            print(true);
            await signUp();
          }
        },
        child: Text("Sign Up",
            style: GoogleFonts.poppins(
              fontSize: 20.sp,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            )),
      ),
    );
  }

// uyarı mesajı
  void callSnackbar(String error, [Color? color, VoidCallback? onVisible]) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
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

  Future signUp() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    User? user;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      user = userCredential.user;
      print(user);
      await user!.updateDisplayName(nameController.text);

      await user.reload();
      user = auth.currentUser;
      callSnackbar("Kayıt başarılı !", Colors.green, () {});
      Future.delayed(Duration(seconds: 1));
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => MyStatefulWidget(),
      ));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-exists' ||
          e.code == 'email-already-in-use') {
        callSnackbar("Bu e-mail daha önce kullanılmış!");
        return;
      } else if (e.code == 'phone-number-already-exists') {
        callSnackbar("Bu telefon numarası daha önce alınmış!");
        return;
      }
    }
  }
}
