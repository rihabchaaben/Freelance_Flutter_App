class SubCategoryModel {
  String? designation;

  SubCategoryModel({
    this.designation,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': designation,
    };
  }

  SubCategoryModel.fromJson(Map<String, dynamic>? json) {
    designation = json!['designation'];
  }
}
