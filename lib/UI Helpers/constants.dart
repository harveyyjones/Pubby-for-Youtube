import 'dart:ui';

import 'package:flutter/material.dart';

// Ekran ölçüleri.
var pixelRatio = window.devicePixelRatio;
var logicalScreenSize = window.physicalSize / pixelRatio;
var screenWidth = logicalScreenSize.width;
var screenHeight = logicalScreenSize.height;

String homeScreenTitle = "Fortune Teller Of The Month";
String fontFamilyCambria = "Cambria";
String fontFamilyJavanese = "Javanese";
Color colorOfTitleInHomeScreen = Color.fromARGB(255, 79, 75, 75);
