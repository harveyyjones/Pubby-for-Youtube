import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  var createdAt;
  String? eMail;
  String? name;
  String? userId;
  String? profilePhotoURL; // Bunun veri tipini değiştirebilirim duruma göre.
  var updatedAt;
  String? biography;
  String? gender;

  UserModel({
    this.userId,
    this.name,
    this.eMail,
    this.profilePhotoURL,
    this.biography,
    var this.gender,
    var this.createdAt,
    var this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      "biography": biography ?? "",
      "createdAt": createdAt ?? FieldValue.serverTimestamp(),
      "eMail": eMail,
      "name": name,
      "userId": userId,
      "profilePhotoURL": profilePhotoURL ?? "",
      "updatedAt": updatedAt ?? FieldValue.serverTimestamp(),
    };
  }

// Aşağıdaki isimlendirilmiş constructor DB'den gelen mapi, UserModel nesnesine çeviriyor.
  UserModel.fromMap(Map<String, dynamic> map)
      : userId = map["userId"],
        eMail = map["eMail"],
        name = map["name"],
        profilePhotoURL = map["profilePhotoURL"],
        biography = map["biography"],
        createdAt = (map["createdAt"]),
        updatedAt = (map["updatedAt"]);
}
