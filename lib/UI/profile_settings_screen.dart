import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pubby_for_youtube/UI%20Helpers/constants.dart';

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
  var _selectedItem = "Intermediate";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: EdgeInsets.only(top: screenlHeight / 20),
          decoration: const BoxDecoration(color: Color(0xffeef3f8)),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: screenlHeight / 10,
              ),
              Stack(
                children: [
                  Container(
                    color: Color.fromARGB(0, 176, 11, 11),
                    width: screenWidth / 2,
                    child: const Hero(
                      tag: "Profile Screen",
                      child: CircleAvatar(
                          maxRadius: 180,
                          minRadius: 55,
                          backgroundImage:
                              AssetImage("assetss/teacherman.jpg")),
                    ),
                  ),
                  Positioned(
                      right: screenWidth / 25,
                      top: screenlHeight / 5,
                      child: IconButton(
                          iconSize: 75,
                          onPressed: () {
                            //TODO: Image picker ile foto değiştirilebiliyor olacak. Muhtemelen localde saklanabilir. Aşağıda dil seviyeleri belirleme kısmı var onlarında lokalde tutulması lazım.
                          },
                          icon: Icon(
                              color: Color.fromARGB(255, 160, 201, 245),
                              Icons.image_search)))
                ],
              ),
              SizedBox(
                height: screenlHeight / 33,
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
