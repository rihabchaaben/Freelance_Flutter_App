
class CustomerModel {
  String name="";
  String phone="";
  String email="";
  String? image;
  String adress="";
  String role="";
  String uid="";
  String password="";
  CustomerModel(

      {
        required this.name,
     required this.phone,
    required  this.email,
            this.image,
    required  this.uid,
      required this.role,
    required  this.password,
    required this.adress,
  });

  Map<String, dynamic> toMap() {
    return {
     
      'name': name,
      'phone': phone,
      'email': email,
      'image': image,
      'uid': uid,
      'role': role,
      'password': password,
      'adress': adress,
    
    };
  }
  
  CustomerModel.fromJson(Map<String, dynamic> json) {
    role = json['role'];
    phone = json['phone'];
    name = json['name'];
    password = json['password'];
    adress = json['adress'];
    email = json['email'];
    image = json['image'];
    uid = json['uid'];
  }

 
  
   
}
