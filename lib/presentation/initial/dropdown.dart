import 'package:e_mandi/style/styling.dart';
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
  final List<String> fruits = [
    'Apple',
    'Banana',
    'Cherry',
    'Date',
    'Grape',
    'Mango'
  ];
  String? selectedFruit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(14.h),
      child: Container(
        decoration: BoxDecoration(
          color: Styling.textfieldsColor,
          borderRadius: BorderRadius.circular(35.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5.0,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
          child: DropdownButtonFormField<String>(
            focusNode: widget.currentNode,
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.selectItemTypeName,
              border: InputBorder.none,
            ),
            value: selectedFruit,
            items: fruits.map((String fruit) {
              return DropdownMenuItem<String>(
                value: fruit,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: selectedFruit == fruit
                        ? Styling.primaryColor.withOpacity(0.2)
                        : Colors.transparent,
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 1.h),
                  child: Text(
                    fruit,
                    style: TextStyle(
                      color: selectedFruit == fruit
                          ? Styling.primaryColor
                          : Colors.black,
                    ),
                  ),
                ),
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
          ),
        ),
      ),
    );
  }
}
