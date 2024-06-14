import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_mandi/style/styling.dart';

class FruitDropdown extends StatelessWidget {
  final FocusNode currentNode;
  final FocusNode nextNode;
  final Function(String) onSelected;

  const FruitDropdown({
    Key? key,
    required this.currentNode,
    required this.nextNode,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Styling.textfieldsColor,
        borderRadius: BorderRadius.circular(50.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          items: <String>['Apple', 'Banana', 'Orange'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (newValue) {
            if (newValue != null) {
              onSelected(newValue);
              // Move focus to the next node
              FocusScope.of(context).requestFocus(nextNode);
            }
          },
          hint: Text(
            'Select Fruit',
            style: TextStyle(
              color: const Color.fromARGB(255, 112, 102, 102),
              fontSize: 17.sp,
            ),
          ),
          icon: const Icon(
            Icons.arrow_drop_down,
            color: Color.fromARGB(255, 65, 61, 61),
          ),
          style: const TextStyle(
            color: Colors.black,
            fontFamily: "Sansita",
            fontSize: 16,
          ),
          dropdownColor: Styling.textfieldsColor,
        ),
      ),
    );
  }
}
