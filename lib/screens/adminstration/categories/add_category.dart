import 'package:flutter/material.dart';
import 'package:freelance_dxb/cubit/add_category/add_category_cubit.dart';
import 'package:freelance_dxb/style/colors.dart';
import '../components/app_bar_actions_item.dart';
import '../components/side_menu.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCategoryPage extends StatefulWidget {
  const AddCategoryPage({Key? key}) : super(key: key);

  @override
  State<AddCategoryPage> createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  //form key
  final _formkey = GlobalKey<FormState>();
  // text for textfield
  String designation = '';
  // ignore: unused_field
  static List<String> subcategoriesList = [' '];
  final designationController = TextEditingController();
  final subcategoriesController = TextEditingController();

  //Clearing Text
  _clearText() {
    designationController.clear();
    subcategoriesController.clear();
  }

  @override
  void initState() {
    super.initState();
    ;
  }

  //Disposing Textfield
  @override
  void dispose() {
    designationController.dispose();
    subcategoriesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SizedBox(
        width: 100,
        child: SideMenu(),
      ),
      appBar: AppBar(
        backgroundColor: bgColor,
        actions: const [AppBarActionItem()],
      ),
      body: BlocConsumer<AddCategoryCubit, AddCategoryState>(
        listener: (context, state) {
          if (state is AddCategorySuccess) {
            // faire un toast de success
          } else if (state is AddCategoryFailed) {
            // echec
          }
        },
        builder: (context, state) {
          if (state is AddCategoryEditing) {
            return Form(
              key: _formkey,
              child: ListView(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 30, 50, 10),
                      child: TextFormField(
                        controller: designationController,
                        decoration: InputDecoration(
                          label: Text('Designation'),
                          hintText: 'Enter \'s designation',
                          labelStyle: const TextStyle(
                            color: Color.fromARGB(255, 240, 67, 67),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          focusColor: Colors.white,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 175, 172, 172)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 175, 172, 172)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  Wrap(
                    children: state.subCategories
                        .map((currentSubCat) => Container(
                              padding: EdgeInsets.only(left: 5),
                              decoration: BoxDecoration(
                                  // border: Border.all(width: 2),
                                  ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(currentSubCat),
                                  IconButton(
                                      onPressed: () {
                                        context
                                            .read<AddCategoryCubit>()
                                            .removeSubCate(currentSubCat);
                                      },
                                      icon: Icon(Icons.close))
                                ],
                              ),
                            ))
                        .toList(),
                  ),

                  Row(
                    children: [
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.fromLTRB(30, 10, 0, 10),
                        child: TextFormField(
                          decoration: InputDecoration(
                            label: Text('Subcategories'),
                            hintText: 'Enter \'s subcategory',
                            labelStyle: const TextStyle(
                              color: Color.fromARGB(255, 240, 67, 67),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                            focusColor: Colors.white,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 175, 172, 172)),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 175, 172, 172)),
                            ),
                          ),
                          controller: subcategoriesController,
                        ),
                      )),
                      IconButton(
                        onPressed: () {
                          context
                              .read<AddCategoryCubit>()
                              .addSubCategory(subcategoriesController.text);
                          subcategoriesController.clear();
                        },
                        icon: Icon(Icons.add),
                      )
                    ],
                  ),
                  //..._getSubcategories(),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            setState(() {
                              _formkey.currentState!.save();
                              designation = designationController.text;
                              context
                                  .read<AddCategoryCubit>()
                                  .addCategory(designationController.text);
                              context
                                  .read<AddCategoryCubit>()
                                  .saveCurrentCategory();

                              _clearText();
                              Navigator.pop(context);
                            });
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red),
                        ),
                        child: const Text(
                          'create category',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: _clearText,
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.grey),
                        ),
                        child: const Text('Clear',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
