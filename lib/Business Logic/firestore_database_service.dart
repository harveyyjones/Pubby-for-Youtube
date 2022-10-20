import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pubby_for_youtube/Business%20Logic/user_model.dart';
import 'package:pubby_for_youtube/UI/steppers.dart';

class FirestoreDatabaseService {
  String deneme = "deneme";

  UserModel _user = UserModel();
  late FirebaseFirestore _instance = FirebaseFirestore.instance;
// Burada ilk kez stepper widget'ından aldığımız verileri veritabanına yolluyoruz. Öncesinde modelden geçirip map'e dönüştürüyoruz.
  Future saveUser([String? biography, photoUrl, String? name]) async {
    UserModel? _eklenecekUser = UserModel(
      biography: biography,
      eMail: currentUser?.email,
      profilePhotoURL: photoUrl,
      name: name,
      userId: currentUser!.uid,
    );

    print("Biyografi: ${_eklenecekUser.biography}");
    print("E Mail: ${_eklenecekUser.eMail}");
    print("Name: ${_eklenecekUser.name}");
    print("Profile Photo stuff: ${_eklenecekUser.profilePhotoURL}");
    print("*****************************");
    print(_eklenecekUser.toMap());
    await _instance
        .collection("users")
        .doc(currentUser!.uid)
        .set(_eklenecekUser.toMap());
  }
}
