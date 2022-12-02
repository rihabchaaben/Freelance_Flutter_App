import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freelance_dxb/models/category_model.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'add_category_state.dart';

class AddCategoryCubit extends Cubit<AddCategoryState> {
  AddCategoryCubit() : super(AddCategoryEditing());

  void addCategory(String designation) {
    final currentState = getCurrentStateAsAddCategoryEditing();
    emit(currentState.copyWith(designation: designation));
  }

  void addSubCategory(String subCategoryDesignation) {
    final currentState = getCurrentStateAsAddCategoryEditing();
    final newSubCategories = [
      ...currentState.subCategories,
      subCategoryDesignation
    ];
    emit(currentState.copyWith(subCategories: newSubCategories));
  }

  void removeSubCate(String subCateDesignation) {
    final currentState = getCurrentStateAsAddCategoryEditing();
    final newSubCategories =
        currentState.subCategories.where((currentSubCateDesign) {
      return currentSubCateDesign != subCateDesignation;
    }).toList();
    emit(currentState.copyWith(subCategories: newSubCategories));
  }

  Future<void> saveCurrentCategory() async {
    final currentState = getCurrentStateAsAddCategoryEditing();
    try {
   
      final addedCat = await FirebaseFirestore.instance
          .collection('categories').doc();
   final Category cat=Category(id: addedCat.id, designation: currentState.designation, subCategories: currentState.subCategories);
        addedCat.set(cat.toMap());
      emit(AddCategorySuccess());
    } catch (e) {
      emit(AddCategoryFailed("Error"));
    }
  }

  AddCategoryEditing getCurrentStateAsAddCategoryEditing() {
    if (state is AddCategoryEditing) {
      return state as AddCategoryEditing;
    }
    throw Exception("Current state is not AddCategoryEditing");
  }
Future<void> editCategory(String docId) async {
    final currentState = getCurrentStateAsAddCategoryEditing();
    try {
   
      final addedCat = await FirebaseFirestore.instance
          .collection('categories').doc(docId);
        addedCat.set({'id':docId, 'designation':currentState.designation,'subCategories':currentState.subCategories});
      emit(EditCategorySuccess());
    } catch (e) {
      emit(EditCategoryError(error: 'error in editing'));
    }
  }

  Category?  category;
 getCategory({id}) async {
    await FirebaseFirestore.instance.collection('categories').doc(id).get().then((value) {
     final category = Category.fromMap(value.data());
     emit(GetCategorySuccess(category));
    }).catchError((e) {
      print(e.toString());
    });
  }
}
