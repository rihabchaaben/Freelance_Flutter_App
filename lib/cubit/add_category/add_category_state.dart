// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_category_cubit.dart';

@immutable
abstract class AddCategoryState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddCategorySuccess extends AddCategoryState {}

class AddCategoryFailed extends AddCategoryState {
  final String message;

  AddCategoryFailed(this.message);
}

class AddCategoryEditing extends AddCategoryState {
  final String designation;
  final List<String> subCategories;

  AddCategoryEditing({
    this.designation = "",
    this.subCategories =const[],
  });

  @override
  List<Object?> get props => [this.designation, this.subCategories];

  AddCategoryEditing copyWith({
    String? designation,
    List<String>? subCategories,
  }) {
    return AddCategoryEditing(
      designation: designation ?? this.designation,
      subCategories: subCategories ?? this.subCategories,
    );
  }
}
class EditCategorySuccess extends AddCategoryState {}
class EditCategoryError extends AddCategoryState {
  String error;
  EditCategoryError({
    required this.error,
  });
  
}
class GetCategorySuccess extends AddCategoryState {
  final Category category;

  GetCategorySuccess(this.category);

}