class UserModel {
  String? uid;
  String? name;
  String? email;
  UserModel({this.uid, this.email, this.name});
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map["uid"],
      email: map["email"],
      name: map["name"],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "email": email,
      "name": name,
    };
  }
}
