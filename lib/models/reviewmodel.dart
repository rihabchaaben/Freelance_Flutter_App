// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class ReviewModel extends Equatable {
  String? id;
  String? idFreelancer;
  String? idCustomer;
  String? comment;
  String? rate;
 
  ReviewModel(
      {this.id,
      this.idFreelancer,
      this.idCustomer,
      this.comment,
      this.rate,
      });
  ReviewModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idFreelancer = json['idFreelancer'];
    idCustomer = json['idCustomer'];
    comment = json['comment'];
    rate = json['rate'];
   
  }
  @override
  List<Object> get props {
    return [id!, idFreelancer!, idCustomer!, comment!, rate!, ];
  }

 
 set setId(String id){
  id=id;
}
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'idFreelancer': idFreelancer,
      'idCustomer': idCustomer,
      'comment': comment,
      'rate': rate,
    
    };
  }

  factory ReviewModel.fromMap(Map<String, dynamic> map, String id) {
    return ReviewModel(
      id: map['id'] as String,
      idFreelancer: map['idFreelancer'] as String,
      idCustomer: map['idCustomer'] as String,
      comment: map['comment'] as String,
      rate: map['rate'] as String,
    
    );
  }

  @override
  bool get stringify => true;
}
