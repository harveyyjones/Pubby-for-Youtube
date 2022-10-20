import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pubby_for_youtube/Business%20Logic/firestore_database_service.dart';
import 'package:pubby_for_youtube/UI%20Helpers/constants.dart';
import 'package:pubby_for_youtube/UI/home_screen.dart';
import '../UI Helpers/personal_info_name_bar.dart';

final User? currentUser = FirebaseAuth.instance.currentUser;
TextEditingController _controllerForName = TextEditingController();
TextEditingController _controllerForBiography = TextEditingController();
var profilePhoto;
int _index = 0;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const Center(
          child: MyStatefulWidget(),
        ),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => MyStatefulWidgetState();
}

class MyStatefulWidgetState extends State<MyStatefulWidget> {
  FirestoreDatabaseService _firestore_database_service =
      FirestoreDatabaseService();
  final ImagePicker _picker = ImagePicker();
File? _image;

  Future<File?> cropImage(File imageFile) async {
    CroppedFile? croppedImage =
        await ImageCropper().cropImage(sourcePath: imageFile.path);
    return File(croppedImage!.path);
    print("Image File Path: ${imageFile.path}");
  }

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      File? img = File(image.path);
      img = (await cropImage(img));
      setState(() {
        _image = img;
      });
    } on PlatformException catch (e) {
      print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    var _keyForStepper = GlobalKey();
    return SafeArea(
      child: Scaffold(
        body: Material(
          color: const Color.fromARGB(255, 236, 243, 250),
          child: Stepper(
              key: _keyForStepper,
              controlsBuilder: (context, details) {
                return details.stepIndex == 2
                    ? Column(
                        children: [
                          SizedBox(
                            height: screenHeight / 20,
                          ),
                          TextButton(
                              onPressed: () async {
                                if (_controllerForName.text != "" &&
                                    _controllerForBiography.text != "") {
                                  // Kullanıcının bilgilerinin ilk kez database'e yazdırılması işlemi burda gerçekleştiriliyor.
                                  await _firestore_database_service.saveUser(
                                      _controllerForBiography.text,
                                      _image,
                                      _controllerForName.text
                                      
                                      );
                                  // ignore: use_build_context_synchronously
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HomeScreen(),
                                      ),
                                      (route) => false);
                                } else {
                                  callSnackbar(String error,
                                      [Color? color, onVisible]) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      behavior: SnackBarBehavior.floating,
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 30.w, vertical: 30.h),
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
                                          child: Text(error,
                                              style: const TextStyle(
                                                  color: Colors.white)),
                                        ),
                                      ),
                                    ));
                                  }

                                  callSnackbar("Please fill all the forms.");
                                }
                              },
                              child: const Text(
                                "Finish",
                                style: TextStyle(fontSize: 40),
                              )),
                        ],
                      )
                    : Row(
                        children: <Widget>[
                          TextButton(
                            onPressed: () {
                              if (_index != 2) {
                                setState(() {
                                  _index += 1;
                                });
                              }
                            },
                            child: const Text(
                              'Next',
                              style: TextStyle(fontSize: 26),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              if (_index > 0) {
                                setState(() {
                                  _index -= 1;
                                });
                              }
                            },
                            child: const Text(
                              "Back",
                              style: TextStyle(fontSize: 26),
                            ),
                          ),
                        ],
                      );
              },
              type: StepperType.horizontal,
              currentStep: _index,
              onStepCancel: () {
                if (_index > 0) {
                  setState(() {
                    _index -= 1;
                  });
                }
              },
              onStepContinue: () {
                if (_index != 2) {
                  setState(() {
                    _index += 1;
                  });
                }
              },
              onStepTapped: (int index) {
                setState(() {
                  _index = index;
                });
              },
              steps: [
                ...stepList,
                Step(
                  isActive: _index > 1,
                  state: _index > 2 ? StepState.complete : StepState.indexed,
                  title: const Text('Step 1 title'),
                  content: Container(
                    padding: EdgeInsets.only(top: screenHeight / 25),
                    alignment: Alignment.centerLeft,
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                _image != null ? FileImage(_image!) : null,
                            //backgroundColor: Colors.white,
                            maxRadius: screenWidth / 3.3,
                            minRadius: 20,
                          ),
                          SizedBox(
                            height: screenHeight / 33,
                          ),
                          const Text(
                            "Add a picture for your awesome profile!",
                            style: TextStyle(fontSize: 28, color: Colors.black),
                          ),
                          InkWell(
                            onTap: () {
                              pickImage(ImageSource.gallery);

                              print("Image picker basıldı");
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.grey,
                                      offset: Offset(1, 2),
                                      blurRadius: 1,
                                      blurStyle: BlurStyle.outer,
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(22),
                                  color: Colors.white),
                              width: screenWidth / 2.5,
                              height: screenHeight / 12,
                              child: const Center(
                                child: Text(
                                  "Add Photo",
                                  style: TextStyle(
                                      fontSize: 33, fontFamily: "Javanese"),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}

List<Step> get stepList => <Step>[
      Step(
        isActive: true,
        state: _index > 0 ? StepState.complete : StepState.indexed,
        title: const Text(''),
        content: Container(
            // color: Colors.black,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: screenHeight / 33,
                ),
                PersonalInfoNameBar(
                  controller: _controllerForName,
                  label: "What's your name?",
                  lineCount: 1,
                ),
                Text(
                  "This will be seen by everyone.",
                  style: TextStyle(fontFamily: fontFamilyCambria, fontSize: 22),
                ),
              ],
            )),
      ),
      Step(
        isActive: _index > 0,
        state: _index > 1 ? StepState.complete : StepState.indexed,
        title: const Text('Step 1 title'),
        content: Container(
            alignment: Alignment.centerLeft,
            child: PersonalInfoNameBar(
              controller: _controllerForBiography,
              label: "Tell us something about you! What do you listen?",
              lineCount: 4,
            )),
      ),
    ];
