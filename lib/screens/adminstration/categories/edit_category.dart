import 'package:flutter/material.dart';
import '../../../cubit/add_category/add_category_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/components/components.dart';
import '../../../style/colors.dart';
import '../components/app_bar_actions_item.dart';
import '../components/side_menu.dart';
class EditPage extends StatefulWidget {
  const EditPage({
    Key? key,
    required this.docID,
     required this.designation,
  }) : super(key: key);
  final String docID;
   final String designation;
  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {


  //form key
  final _formkey = GlobalKey<FormState>();
 String designation = '';
  // ignore: unused_field
  static List<String> subcategoriesList = [' '];
  final designationController = TextEditingController();
  final subcategoriesController = TextEditingController();
  @override
  void initState() {
    super.initState();
    designationController.text=widget.designation;
  }
  _clearText() {
    designationController.clear();
    subcategoriesController.clear();
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
          if (state is EditCategorySuccess) {
          toast(Colors.green, "Editing category Succeded", context);
          } else if (state is EditCategoryError) {
          toast(Colors.red, " Editing category failed", context);
          }
        },
        builder: (context, state) {
          if (state is AddCategoryEditing) {
            return Form(
              key: _formkey,
              child: ListView(
                children: [
                   SizedBox(height: 40,),
                 Center(
                
                      child: Text(
                        'Update Category',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Color.fromARGB(255, 5, 5, 5),
                        ),
                      ),
                    ),
                  SizedBox(height: 50,),
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
                            fontSize: 20,
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
                              fontSize: 20,
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
                    height: 70,
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
                                  .editCategory(widget.docID);

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
                          'Update category',
                          style: TextStyle(color: Colors.white,fontSize: 25),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: _clearText,
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.grey),
                        ),
                        child: const Text('Clear',
                            style: TextStyle(color: Colors.white,fontSize: 25)),
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
