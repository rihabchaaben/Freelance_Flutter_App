// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String id;
  final String designation;
  final List<String> subCategories;
  Category({
    required this.id,
    required this.designation,
    required this.subCategories,
  });

  Category copyWith({
    String? id,
    String? designation,
    List<String>? subCategories,
  }) {
    return Category(
      id: id ?? this.id,
      designation: designation ?? this.designation,
      subCategories: subCategories ?? this.subCategories,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'designation': designation,
      'subCategories': subCategories,
    };
  }

  factory Category.fromMap(Map<String, dynamic>? map) {
    return Category(
      id: map!['id'] as String,
      designation: map['designation'] as String,
      subCategories: map['subCategories'] == null
          ? <String>[]
          : (map['subCategories'] as List<dynamic>).cast<String>(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) =>
      Category.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Category(id: $id, designation: $designation, subCategories: $subCategories)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Category &&
        other.id == id &&
        other.designation == designation &&
        listEquals(other.subCategories, subCategories);
  }

  @override
  int get hashCode =>
      id.hashCode ^ designation.hashCode ^ subCategories.hashCode;

  @override
  List<Object?> get props => [
        this.id,
        this.designation,
        this.subCategories,
      ];
}
