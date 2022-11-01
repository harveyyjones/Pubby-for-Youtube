import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pubby_for_youtube/UI/steppers.dart';

import '../business_logic/firestore_database_service.dart';

class AdminPanel extends StatefulWidget {
  const AdminPanel({super.key});

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  FirestoreDatabaseService _firestoreDatabaseService =
      FirestoreDatabaseService();

  late FirebaseFirestore _instance = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    _firestoreDatabaseService.saveUer();
                    print(user!.displayName);
                  },
                  child: Text("SaveData()")),
              ElevatedButton(
                  onPressed: () {
                    _instance
                        .collection("users")
                        .doc(currentUser!.uid)
                        .update({"name": "adnan"});
                  },
                  child: Text("Change name")),
              ElevatedButton(
                  onPressed: () {
                    print("*****************************************");
                    print(_firestoreDatabaseService.getAllUsersData());
                    
                  },
                  child: Text("Tüm kullanıcı adlarını listele")),
            ],
          ),
        ),
      ),
    );
  }
}
