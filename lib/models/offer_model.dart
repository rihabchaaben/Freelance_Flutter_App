// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Offer extends Equatable {
  String? id;
  String? title;
  String? description;
  String? startDate;
  String? endDate;
  String? uid;
  String? price;
  Offer(
      {this.id,
      this.title,
      this.description,
      this.startDate,
      this.endDate,
      this.uid,
      this.price});
  Offer.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    uid = json['uid'];
    price = json['price'];
  }
  @override
  List<Object> get props {
    return [title!, description!, startDate!, endDate!, uid!, price!];
  }

  Offer copyWith({
    String? id,
    String? title,
    String? description,
    String? startDate,
    String? endDate,
    String? uid,
    String? price,
  }) {
    return Offer(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      uid: uid ?? this.uid,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'startDate': startDate,
      'endDate': endDate,
      'uid': uid,
      'price': price,
    };
  }

  factory Offer.fromMap(Map<String, dynamic> map, String id) {
    return Offer(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      startDate: map['startDate'] as String,
      endDate: map['endDate'] as String,
      uid: map['uid'] as String,
      price: map['price'] as String,
    );
  }

  @override
  bool get stringify => true;
}
