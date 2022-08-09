/**import 'package:flutter/material.dart';
import '../categories/add.dart';

class SubcategoryTextFields extends StatefulWidget {
  final int index;
  SubcategoryTextFields(this.index);
  @override
  _SubcategoryTextFieldsState createState() => _SubcategoryTextFieldsState();
}

class _SubcategoryTextFieldsState extends State<SubcategoryTextFields> {
  late TextEditingController _designaionController;

  @override
  void initState() {
    super.initState();
    _designaionController = TextEditingController();
  }

  @override
  void dispose() {
    _designaionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _designaionController.text =
          _AddPageState..subcategoriesList[widget.index] ?? '';
    });

    return TextFormField(
      controller: _designaionController,
      onChanged: (v) => _AddPageState.subcategoriesList[widget.index] = v,
      decoration: InputDecoration(hintText: 'Enter \'s subcaegory'),
      validator: (v) {
        if (v!.trim().isEmpty) return 'Please enter something';
        return null;
      },
    );
  }
}
*/