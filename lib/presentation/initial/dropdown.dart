import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class FruitDropdown extends StatefulWidget {
  final FocusNode currentNode;
  final FocusNode nextNode;

  const FruitDropdown({
    Key? key,
    required this.currentNode,
    required this.nextNode,
  }) : super(key: key);

  @override
  _FruitDropdownState createState() => _FruitDropdownState();
}

class _FruitDropdownState extends State<FruitDropdown> {
  final List<String> fruits = ['Apple', 'Banana', 'Cherry', 'Date', 'Grape', 'Mango'];
  String? selectedFruit;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      focusNode: widget.currentNode,
      decoration: InputDecoration(
        hintText: AppLocalizations.of(context)!.selectItemTypeName,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      value: selectedFruit,
      items: fruits.map((String fruit) {
        return DropdownMenuItem<String>(
          value: fruit,
          child: Text(fruit),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          selectedFruit = newValue;
        });
        // Move to the next focus node
        FocusScope.of(context).requestFocus(widget.nextNode);
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please select a fruit";
        }
        return null;
      },
    );
  }
}
