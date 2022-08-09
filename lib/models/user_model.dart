import 'package:freelance_dxb/models/erole.dart';

class UserModel {
  String? name;
  String? phone;
  String? email;
  String? image;
  String? adress;
  String? bio;
  String? role;
  String? uid;
  String? password;
  bool? isVerified;
  String? sessionPrice;
  String? hourPrice;

  UserModel(
      {this.name,
      this.phone,
      this.email,
      this.image,
      this.bio,
      this.uid,
      this.isVerified,
      this.role,
      this.password,
      this.adress,
      this.hourPrice,
      this.sessionPrice});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'email': email,
      'image': image,
      'uid': uid,
      'bio': bio,
      // 'cover': cover,
      'isVerified': isVerified,
      'role': role,
      'password': password,
      'adress': adress,
      'sessionPrice': sessionPrice,
      'hourPrice': hourPrice
    };
  }

  UserModel.fromJson(Map<String, dynamic>? json) {
    role = json!['role'];
    phone = json['phone'];
    name = json['name'];
    password = json['password'];
    adress = json['adress'];
    email = json['email'];
    image = json['image'];
    // cover = json['cover'];
    uid = json['uid'];
    hourPrice = json['hourPrice'];
    sessionPrice = json['sessionPrice'];
    bio = json['bio'];
    //isVerified = json['isVerified'];
  }
}
