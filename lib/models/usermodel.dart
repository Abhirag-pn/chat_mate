

class UserModel {
  String? username;
  String? email;
  String? bio;
   String? imageurl;

  UserModel(
      {required this.username,
      required this.email,
      required this.imageurl,
      required this.bio});

  UserModel.fromMap(Map<String, dynamic> map) {
    username = map['username'];
    email = map['email'];
    bio = map['bio'];
    imageurl = map['imageurl'];
  }

  Map<String,dynamic>toMap(){
    return {
      "username":username,
      "email":email,
      "bio":bio,
      "imageurl":imageurl
    };
  }
}
