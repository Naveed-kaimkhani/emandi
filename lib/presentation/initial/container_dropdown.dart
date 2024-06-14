import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_mandi/style/styling.dart';

class ContainerDropDown<T> extends StatelessWidget {
  final List<T> items;
  final Function(T) onSelected;
  final String hintText;
  final String Function(T) displayText;

  const ContainerDropDown({
    Key? key,
    required this.items,
    required this.onSelected,
    required this.hintText,
    required this.displayText,
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
        child: DropdownButton<T>(
          items: items.map((T value) {
            return DropdownMenuItem<T>(
              value: value,
              child: Text(displayText(value)),
            );
          }).toList(),
          onChanged: (newValue) {
            if (newValue != null) {
              onSelected(newValue);
            }
          },
          hint: Text(
            hintText,
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
