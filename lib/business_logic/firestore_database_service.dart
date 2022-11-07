import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  updateIsUserListening(state, url) async {
    // Buradan anlık olarak müzik dinlenip dinlenmediğini, dinleniyorsa url'sini çekiyorum.
    await _instance
        .collection("users")
        .doc(currentUser!.uid)
        .update({"isUserListening": state, "currentlyListeningMusicUrl": url});
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
      print(item["name"]);
      print(item["isUserListening"]);

      // Dosya içerisine ulaşabilir veya döküman Id'sini çekebilirsiniz.
    }
  }

  getUserDatasToMatch(currentlyListeningMusicUrl, amIListeningNow) async {
    // Anlık olarak sürekli olarak o anda eşleşilen kişinin bilgilerini kullanıma hazır tutuyor.
    QuerySnapshot<Map<String, dynamic>> _okunanUser =
        await FirebaseFirestore.instance.collection("users").get();
    for (var item in _okunanUser.docs) {
      if (item["isUserListening"] &&
          currentlyListeningMusicUrl == item["currentlyListeningMusicUrl"] &&
          amIListeningNow) {
        sendMatchesToDatabase(item["uid"], currentlyListeningMusicUrl);
        print(" Eşleşilen kişi: ${item["name"]}");
        print(" Eşleşilen kişinin uid: ${item["uid"]}");
      }
    }
  }

  sendMatchesToDatabase(uid, musicUrl) async {
    // Veritabına daha sonradan notifcation sayfasında kullanılmak üzere uid'leri, zamanı ve hangi şarkıyı dinlerken eşleşildiğini gönderir.
    //Böylece eşleşme gerçekleştiği anda aynı yerden veriyi çekerek ekranda gösterilebilir. 30 dakika sonra kaybolur.
    final previousMatchesRef =
        _instance.doc("previousMatches/${currentUser!.uid}");
    previousMatchesRef
        .collection("previousMatchesList")
        .doc(uid)
        .set({"uid": uid, "timeStamp": DateTime.now(), "url": musicUrl}).then(
            (value) => print("İşlem başarılı"));
  }

  getMatchesIds() async {
    // Tüm eşleşmelerin Id'lerini döndürür. Daha sonra bilgileri çekmek için kullanılacak.
    List tumEslesmelerinIdsi = [];
    final previousMatchesRef = await _instance
        .collection("previousMatches")
        .doc(currentUser!.uid)
        .collection("previousMatchesList")
        .get();
    for (var item in previousMatchesRef.docs) {
      print(item["uid"]);
      tumEslesmelerinIdsi.add(item["uid"]);
      print("Tüm eşleşmelerin olduğu kişilerin idleri: ${tumEslesmelerinIdsi}");
      return await tumEslesmelerinIdsi;
    }
  }

  Future getUserDataViaUId() async {
    // Eşleşilenlerin Id'lerini kullanarak kullanıcı bilgilerini çeken bir fonksiyon. Notifications kısmında ve video altında sergilenirken kullanılabilir.
    UserModel users;
    List usersList = [];
    List<dynamic> eslesilenlerinIdleri = await getMatchesIds();
    print("Tüm eşleşmelerin olduğu kişilerin idleri: ${eslesilenlerinIdleri}");
    QuerySnapshot<Map<String, dynamic>> _okunanUser =
        await FirebaseFirestore.instance.collection("users").get();
    for (var item in await _okunanUser.docs) {
      if (await eslesilenlerinIdleri.contains(item["uid"])) {
        users = UserModel(
          name: item["name"],
          biography: item["biography"],
          profilePhotoURL: item["profilePhotoURL"],
        );
        usersList.add(users);
        return usersList;
      }
    }
  }

  getTheMutualSongViaUId() async {
    // Ortak bir şey dinlediğimiz kişilerle hangi şarkıda eşleştiğimizi döndüren metod.

    List tumEslesmelerinParcalari = [];
    final previousMatchesRef = await _instance
        .collection("previousMatches")
        .doc(currentUser!.uid)
        .collection("previousMatchesList")
        .get();
    for (var item in previousMatchesRef.docs) {
      print(item["uid"]);
      tumEslesmelerinParcalari.add(item["nameOfTheSong"]);
      print(
          "Tüm eşleşmelerin olduğu kişilerin Şarkıları: ${tumEslesmelerinParcalari}");
    }
      return await tumEslesmelerinParcalari;
  }
}
