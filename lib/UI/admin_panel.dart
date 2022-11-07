import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pubby_for_youtube/UI%20Helpers/bottom_bar.dart';
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
        bottomNavigationBar: BottomBar(selectedIndex: 2),
        body: Center(
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    _firestoreDatabaseService.getAllUsersData();
                    print(user!.displayName);
                  },
                  child: Text("GetAllUsersData")),
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
                    _firestoreDatabaseService.getMatchesIds();
                  },
                  child: Text("Eşleşilen")),
              ElevatedButton(
                  onPressed: () {
                    _firestoreDatabaseService.getUserDataViaUId();
                  },
                  child: Text("GetUserDataViaUId();")),
            ],
          ),
        ),
      ),
    );
  }
}
