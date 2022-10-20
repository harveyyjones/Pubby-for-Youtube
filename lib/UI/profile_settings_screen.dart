import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pubby_for_youtube/UI%20Helpers/constants.dart';
import 'package:pubby_for_youtube/UI/steppers.dart';

import '../UI Helpers/personal_info_name_bar.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({super.key});

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

TextEditingController nameController = TextEditingController(text: "Hailey");
TextEditingController eMailController =
    TextEditingController(text: "haileyelse@gmail.com");

class _ProfileSettingsState extends State<ProfileSettings> {
  File? _image;
  var _selectedItem = "Intermediate";
  @override
  Widget build(BuildContext context) {
    Future<File?> cropImage(File imageFile) async {
      CroppedFile? croppedImage = await ImageCropper().cropImage(
          aspectRatioPresets: [CropAspectRatioPreset.square],
          sourcePath: imageFile.path);
      print("Image File Path: ${imageFile.path}");
      return File(croppedImage!.path);
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

    return Scaffold(
      body: Container(
          padding: EdgeInsets.only(top: screenHeight / 20),
          decoration: const BoxDecoration(color: Color(0xffeef3f8)),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: screenHeight / 10,
              ),
              Stack(
                children: [
                  Container(
                    color: Color.fromARGB(0, 176, 11, 11),
                    width: screenWidth / 2,
                    child: Hero(
                      tag: "Profile Screen",
                      child: CircleAvatar(
                          maxRadius: 180,
                          minRadius: 55,
                          backgroundImage:
                              _image != null ? FileImage(_image!) : null),
                    ),
                  ),
                  Positioned(
                      right: screenWidth / 25,
                      top: screenHeight / 5,
                      child: IconButton(
                          iconSize: 75,
                          onPressed: () {
                            pickImage(ImageSource.gallery);
                            //TODO: Image picker ile foto değiştirilebiliyor olacak. Muhtemelen localde saklanabilir.
                          },
                          icon: Icon(
                              color: Color.fromARGB(255, 160, 201, 245),
                              Icons.image_search)))
                ],
              ),
              SizedBox(
                height: screenHeight / 33,
                width: MediaQuery.of(context).size.width,
              ),
              PersonalInfoNameBar(
                label: "Name",
                lineCount: 1,
                controller: nameController,
              ),
              PersonalInfoNameBar(label: "Biography", lineCount: 5),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: 250.w,
                height: 70.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      onPrimary: Color.fromARGB(255, 182, 99, 174),
                      primary: Colors.black,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32)),
                      minimumSize: Size(230.w, 60.h)),
                  onPressed: () {},
                  child: Text("Submit",
                      style: TextStyle(
                        fontFamily: 'Calisto',
                        fontSize: 23.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      )),
                ),
              ),
            ],
          )),
    );
  }
}
