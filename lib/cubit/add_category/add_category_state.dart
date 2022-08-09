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
  final Set<String> subCategories;

  AddCategoryEditing({
    this.designation = "",
    this.subCategories = const {},
  });

  @override
  List<Object?> get props => [this.designation, this.subCategories];

  AddCategoryEditing copyWith({
    String? designation,
    Set<String>? subCategories,
  }) {
    return AddCategoryEditing(
      designation: designation ?? this.designation,
      subCategories: subCategories ?? this.subCategories,
    );
  }
}
