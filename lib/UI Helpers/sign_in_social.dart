import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SignInSocial {
  static Widget buildSocial(BuildContext context, Widget icon) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 5,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {},
        child: Container(
          width: 60,
          height: 60,
          padding: const EdgeInsets.all(16),
          child: Center(child: icon),
        ),
      ),
    );
  }
}
