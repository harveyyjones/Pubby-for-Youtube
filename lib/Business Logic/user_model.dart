class UserModel {
  DateTime? createdAt;
  String? eMail;
  String? name;
  String? userId;
  String? profilePhotoURL; // Bunun veri tipini değiştirebilirim duruma göre.
  DateTime? updatedAt;
  String? biography;

  UserModel({
    this.userId,
    this.name,
    this.eMail,
    this.profilePhotoURL,
    this.biography,
    DateTime? this.createdAt,
    DateTime? this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      "biography": biography ?? "",
      "createdAt": createdAt ?? "",
      "eMail": eMail,
      "name": name,
      "userId": userId,
      "profilePhotoURL": profilePhotoURL ?? "",
      "updatedAt": updatedAt ?? "",
    };
  }
}
