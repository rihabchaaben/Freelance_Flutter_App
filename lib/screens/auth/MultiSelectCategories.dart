import 'package:flutter/material.dart';

import '../../models/category_model.dart';


class MultiSelectCategories extends StatefulWidget {
  final List<Category> categories;
  List<String>? selectedSubCategories;
  final ValueChanged<List<String>> onConfirm;
  MultiSelectCategories({
    Key? key,
    required this.categories,
    required this.onConfirm,
    this.selectedSubCategories,
  }) : super(key: key);

  @override
  State<MultiSelectCategories> createState() => _MultiSelectCategoriesState();
}

class _MultiSelectCategoriesState extends State<MultiSelectCategories> {
  List<String> result = [];

  void showBottomModal() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: ListViewMultiSelect(
                categories: widget.categories,
                selectedSubCategories: widget.selectedSubCategories,
                onChange: (results) {
                  result = results;
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                onPressed: () {
                  widget.onConfirm(result);
                  Navigator.of(context).pop();
                },
                child: Text("OK",style: TextStyle(color: Colors.red),),
              ),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: showBottomModal,
          child: Row(
            children: [
               Text(" Category",style:TextStyle(
          color: Color.fromARGB(255, 240, 67, 67),
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),),
        SizedBox(width: 20,),
              Container( 
                width: 200,
                height:30 ,
                child: Row(
                  children: [
               SizedBox(width: 10),
                Text("Select your category"),
                    SizedBox(width: 20,),
                    Icon(Icons.arrow_drop_down)
                  ],
                ),
                    decoration: BoxDecoration(   border: Border.all(color: Colors.red, ),
                           ),
        ),
            ],
          ),),
      ],
    );
  }
}

// ignore: must_be_immutable
class ListViewMultiSelect extends StatefulWidget {
  final List<Category> categories;
  final ValueChanged<List<String>> onChange;
  List<String>? selectedSubCategories;

  ListViewMultiSelect({
    Key? key,
    required this.categories,
    required this.onChange,
    this.selectedSubCategories,
  }) : super(key: key);

  @override
  State<ListViewMultiSelect> createState() => _ListViewMultiSelectState();
}

class _ListViewMultiSelectState extends State<ListViewMultiSelect> {
  final result = <String, bool>{};

  @override
  void initState() {
    widget.categories.forEach((cat) {
      cat.subCategories.forEach((sub) {
        result.putIfAbsent(sub, () {
          final defaultSelectedItems = widget.selectedSubCategories ?? [];
          return defaultSelectedItems.contains(sub);
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      key: Key("List_categories"),
      children: [
        SizedBox(height: 50),
        ...widget.categories.map(
          (cat) {
            final subCategories = cat.subCategories;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Text(
                    cat.designation,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                ...subCategories.map((sub) {
                  return CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    title: Text(sub),
                    onChanged: (bool? value) {
                      onSelectItem(sub, value);
                    },
                    value: result[sub],
                  );
                })
              ],
            );
          },
        )
      ],
    );
  }

  void onSelectItem(String sub, bool? value) {
    setState(() {
      result[sub] = value ?? false;
      final selectdItems = result.entries
          .where((item) => item.value)
          .map((item) => item.key)
          .toList();
      widget.onChange(selectdItems);
    });
  }
}
