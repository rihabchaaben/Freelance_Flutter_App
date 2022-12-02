
class UserModel {
  String name="";
  String? cv;
  String phone="";
  String email="";
  String? image;
  String adress="";
  String? bio;
  String role="";
  String uid="";
String? rate="0.0";
  String password="";
  String? sessionPrice;
  String? hourPrice;
   List<String> subcategory=[];

  UserModel(

      {
        required this.name,
      this.cv,
      this.rate,
      required this.subcategory,
     required this.phone,
      required this.email,
      this.image,
      this.bio,
     required this.uid,
    required  this.role,
    required this.password,
     required  this.adress,
      this.hourPrice,
      this.sessionPrice});

  Map<String, dynamic> toMap() {
    return {
      'cv':cv,
      'rate':rate,
      'name': name,
      'phone': phone,
      'email': email,
      'image': image,
      'uid': uid,
      'bio': bio,
      'role': role,
      'password': password,
      'adress': adress,
      'sessionPrice': sessionPrice,
      'hourPrice': hourPrice,
      'subcategory':subcategory,
    };
  }
  void set setRate(String? rate) {
    rate = rate;}
  UserModel.fromMap(Map<String, dynamic>? map) {
    role = map!['role'];
    rate = map['rate'];
    phone = map['phone'];
    name = map['name'];
    password = map['password'];
    adress = map['adress'];
    email = map['email'];
    image = map['image'];
    uid = map['uid'];
    hourPrice = map['hourPrice'];
    sessionPrice = map['sessionPrice'];
    bio = map['bio'];
    cv = map['cv'];
     subcategory=  map['subcategory'] == null
          ? <String>[]
          : (map['subcategory'] as List<dynamic>).cast<String>();
  
  }

 
  
   
}
