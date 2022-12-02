import 'dart:convert';

import 'package:equatable/equatable.dart';

class FreelancerDetail extends Equatable {
  final String id;
  final String email;
  final String password;
  final String userName;
  final String? imageUrl;
  List <String> subCategory;
  final String? city;
  final String starNumber;
  String? role;
   String phone;

  FreelancerDetail({
    required this.email,
    required this.password,
    required this.id,
    required this.subCategory,
    required this.starNumber,
    this.city,
    required this.userName,
    this.imageUrl,
    this.role,
   required this.phone
  });

  @override
  List<Object?> get props => [
        this.id,
        this.subCategory,
        this.city,
        this.imageUrl,
        this.starNumber,
      ];

  Map<String, dynamic> toMap() {
    return {
      'uid': id,
        'password': password,
        'email':email,
       'rate': starNumber,
      'image': imageUrl,
      'name': userName,
      'subcategory': subCategory,
      'adress': city,
      'role': role,
      'phone': phone,
  
    };
  }

  factory FreelancerDetail.fromJson(Map<String, dynamic> map) {
    return FreelancerDetail(
      id: map['uid'],
        phone: map['phone'],
       email: map['email'],
        password: map['password'],
                role: map['role'],

         starNumber: map['rate'],
      userName: map['name'],
      imageUrl: map['image'],
      subCategory:  map['subcategory'] == null
          ? <String>[]
          : (map['subcategory'] as List<dynamic>).cast<String>(),
      city: map['adress'],
    );
  }

  String toJson() => json.encode(toMap());
}
