import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freelance_dxb/models/category_model.dart';
import 'package:freelance_dxb/models/subcategory_model.dart';

class CategoriesRepository {
  final Stream<QuerySnapshot> categoryRecords =
      FirebaseFirestore.instance.collection('categories').snapshots();

  // For Deleting categories
  CollectionReference delCategory =
      FirebaseFirestore.instance.collection('categories');
  Future<void> delete(id) {
    return delCategory
        .doc(id)
        .delete()
        .then((value) => print('category Deleted'))
        .catchError((_) => print('Something Error In Deleted category'));
  }

  CollectionReference updatedCategory =
      FirebaseFirestore.instance.collection('categories');
  Future<void> updateCategory(idcat, designation, subcategories) {
    return updatedCategory
        .doc(idcat)
        .update({
          'designation': designation,
          'subcategories': subcategories,
        })
        .then((value) => print("category Updated"))
        .catchError((error) => print("Failed to update category: $error"));
  }

  //Resigtering categories
  CollectionReference addedcategory =
      FirebaseFirestore.instance.collection('categories');
  Future<void> addCategory(String designation, Map subcategories) {
    return addedcategory
        .add({'designation': designation, 'subcategories': subcategories})
        .then((value) => print('category Added'))
        .catchError((_) => print('Something Error category'));
  }

  List<SubCategoryModel>? subcategoriesList;
  getSubcategories({required String idcat}) {
    FirebaseFirestore.instance
        .collection('categories')
        .doc(idcat)
        .collection('subcategories')
        .snapshots()
        .listen((event) {
      subcategoriesList = [];
      event.docs.forEach((e) {
        subcategoriesList!.add(SubCategoryModel.fromJson(e.data()));
        print(e.data());
      });
    });
  }

  late List<Category> categories;
  Category? category;

  List<Category> getAllCaregories() {
    List<Category> categories = [];
    FirebaseFirestore.instance.collection('categories').get().then((value) {
      for (var element in value.docs) {
        element.reference.get().then((value) {
          categories.add(Category.fromMap(element.data()));
          print(value.data());
        }).whenComplete(() {});
      }
      return categories;
    }).catchError((error) {});
    return categories;
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getCategoriesList() {
    try {
      final Future<QuerySnapshot<Map<String, dynamic>>> categoriesRecords =
          FirebaseFirestore.instance.collection('categories').get();
      return categoriesRecords;
    } catch (e) {
      rethrow;
    }
  }
}
