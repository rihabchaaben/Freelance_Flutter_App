import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
    final newSubCategories = {
      ...currentState.subCategories,
      subCategoryDesignation
    };
    emit(currentState.copyWith(subCategories: newSubCategories));
  }

  void removeSubCate(String subCateDesignation) {
    final currentState = getCurrentStateAsAddCategoryEditing();
    final newSubCategories =
        currentState.subCategories.where((currentSubCateDesign) {
      return currentSubCateDesign != subCateDesignation;
    }).toSet();
    emit(currentState.copyWith(subCategories: newSubCategories));
  }

  Future<void> saveCurrentCategory() async {
    final currentState = getCurrentStateAsAddCategoryEditing();
    try {
      final addedCat = await FirebaseFirestore.instance
          .collection('categories')
          .add({'designation': currentState.designation});
      currentState.subCategories.forEach((designation) async {
        await FirebaseFirestore.instance
            .collection('categories')
            .doc(addedCat.id)
            .collection('subcategories')
            .add({'designation': designation, 'idCat': addedCat.id});
      });

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
}
