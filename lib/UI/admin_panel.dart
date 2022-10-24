import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pubby_for_youtube/Business%20Logic/firestore_database_service.dart';
import 'package:pubby_for_youtube/UI/steppers.dart';

class AdminPanel extends StatefulWidget {
  const AdminPanel({super.key});

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  FirestoreDatabaseService _firestoreDatabaseService =
      FirestoreDatabaseService();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    _firestoreDatabaseService.saveUser();
                    print(user!.displayName);
                  },
                  child: Text("SaveData()")),
              ElevatedButton(
                  onPressed: () {
                 
                   
                  },
                  child: Text("Get User Data")),
            ],
          ),
        ),
      ),
    );
  }
}
