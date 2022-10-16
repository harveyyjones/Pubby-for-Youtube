import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pubby_for_youtube/UI%20Helpers/constants.dart';

import '../UI Helpers/personal_info_name_bar.dart';

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
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color.fromARGB(255, 236, 243, 250),
      child: Stepper(
        controlsBuilder: (context, details) {
          return details.stepIndex == 2
              ? TextButton(
                  style: ButtonStyle(),
                  onPressed: () {},
                  child: Text(
                    "Finish",
                    style: TextStyle(fontSize: 22),
                  ))
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
                      child: const Text('Next'),
                    ),
                    TextButton(
                      onPressed: () {
                        if (_index > 0) {
                          setState(() {
                            _index -= 1;
                          });
                        }
                      },
                      child: const Text("Back"),
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
        steps: <Step>[
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
                      height: screenlHeight / 33,
                    ),
                    PersonalInfoNameBar(
                      label: "What's your name?",
                      lineCount: 1,
                    ),
                    Text(
                      "This will be seen by everyone.",
                      style: TextStyle(
                          fontFamily: fontFamilyCambria, fontSize: 22),
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
                  label: "Tell us something about you! What do you listen?",
                  lineCount: 4,
                )),
          ),
          Step(
            isActive: _index > 1,
            state: _index > 2 ? StepState.complete : StepState.indexed,
            title: const Text('Step 1 title'),
            content: Container(
              padding: EdgeInsets.only(top: screenlHeight / 25),
              alignment: Alignment.centerLeft,
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      maxRadius: screenWidth / 3.3,
                      minRadius: 20,
                    ),
                    SizedBox(
                      height: screenlHeight / 33,
                    ),
                    TextButton(
                      child: Text(
                        "Add a picture for you awesome profile!",
                        style: TextStyle(fontSize: 22),
                      ),
                      onPressed: () {
                        // TODO: Image picker ekle.
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
