import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pubby_for_youtube/UI/steppers.dart';
import 'package:pubby_for_youtube/business_logic/user_model.dart';

class FirestoreDatabaseService {
  String deneme = "deneme";
  var collection = FirebaseFirestore.instance.collection('users');

  UserModel _user = UserModel();
  late FirebaseFirestore _instance = FirebaseFirestore.instance;
  Future<UserModel> getUserData() async {
    DocumentSnapshot<Map<String, dynamic>> _okunanUser =
        await FirebaseFirestore.instance.doc("users/${currentUser!.uid}").get();
    Map<String, dynamic>? okunanUserbilgileriMap = _okunanUser.data();
    UserModel okunanUserBilgileriNesne =
        UserModel.fromMap(okunanUserbilgileriMap!);
    print(okunanUserBilgileriNesne.toString());
    return okunanUserBilgileriNesne;
  }

// Burda stream için verileri çekiyoruz.
  Stream<DocumentSnapshot<Map<String, dynamic>>> getProfileData() {
    var ref = _instance.collection("users").doc(currentUser!.uid).snapshots();
    return ref;
  }

// Burada ilk kez stepper widget'ından aldığımız verileri veritabanına yolluyoruz. Öncesinde modelden geçirip map'e dönüştürüyoruz.
  Future saveUer([String? biography, photoUrl, String? name]) async {
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
    DocumentSnapshot<Map<String, dynamic>> _okunanUser =
        await FirebaseFirestore.instance.doc("users/${currentUser!.uid}").get();
    Map<String, dynamic>? okunanUserbilgileriMap = _okunanUser.data();
    UserModel okunanUserBilgileriNesne =
        UserModel.fromMap(okunanUserbilgileriMap!);
    print(okunanUserBilgileriNesne.toString());
  }

  updateProfilePhoto(String imageURL) async {
    // DocumentSnapshot<Map<String, dynamic>> _okunanUser =
    collection.doc(currentUser!.uid).update({"profilePhotoURL": imageURL});

    print("--------------------------------------------");
  }

  updateName(newName) {
    _instance
        .collection("users")
        .doc(currentUser!.uid)
        .update({"name": newName});
  }

  updateBiography(newBiography) {
    _instance
        .collection("users")
        .doc(currentUser!.uid)
        .update({"biography": newBiography});
  }

  getName() async {
    String? name = "deafult";
    await getProfileData().forEach((element) {
      name = element.data()!["biography"];
    });
    return name.toString();
  }

  getAllUsersData() async {
    QuerySnapshot<Map<String, dynamic>> _okunanUser =
        await FirebaseFirestore.instance.collection("users").get();
    for (var item in _okunanUser.docs) {
      print("***************************");
      print(item[
          "name"]); // Dosya içerisine ulaşabilir veya döküman Id'sini çekebilirsiniz.
    }
  }
}
