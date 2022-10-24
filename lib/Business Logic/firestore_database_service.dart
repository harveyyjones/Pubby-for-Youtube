import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pubby_for_youtube/UI/steppers.dart';
import 'package:pubby_for_youtube/business_logic/user_model.dart';

class FirestoreDatabaseService {
  String deneme = "deneme";

  UserModel _user = UserModel();
  late FirebaseFirestore _instance = FirebaseFirestore.instance;
  var collection = FirebaseFirestore.instance.collection('users');

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
    print("Profile Photo URL: ${_eklenecekUser.profilePhotoURL}");
    print("*****************************");
    print(_eklenecekUser.toMap());
    await _instance
        .collection("users")
        .doc(currentUser!.uid)
        .set(_eklenecekUser.toMap());
    DocumentSnapshot<Map<String, dynamic>> _okunanUser =
        await FirebaseFirestore.instance.doc("users/${currentUser!.uid}").get();
    Map<String, dynamic>? okunanUserbilgileriMap = _okunanUser.data();
    UserModel okunanUserBilgileriNesne =
        UserModel.fromMap(okunanUserbilgileriMap!);
    print(okunanUserBilgileriNesne.toString());
  }

// Veri gösterme fonksiyonu.
  Stream<DocumentSnapshot<Map<String, dynamic>>> getProfileData() {
    var ref = _instance.collection("users").doc(currentUser!.uid).snapshots();
    return ref;
  }

  updateProfilePhoto(String imageURL) async {
    // DocumentSnapshot<Map<String, dynamic>> _okunanUser =
    collection.doc(currentUser!.uid).update({"profilePhotoURL": imageURL});
    
        print("--------------------------------------------");
  }
}
