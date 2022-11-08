import 'package:flutter/cupertino.dart';
import 'package:pubby_for_youtube/UI/steppers.dart';

class ChatScreen extends StatefulWidget {
  String? userToChatWith;
  ChatScreen({userToChatWith});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Text(currentUser!.uid),
        Text(widget.userToChatWith.toString()),
      ]),
    );
  }
}
