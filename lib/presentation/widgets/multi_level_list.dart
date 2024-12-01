import 'package:e_mandi/style/styling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MultiLevelList<T> extends StatelessWidget {
  final T? selectedItem;
  final List<DropdownMenuItem<T>> items;
  final Function(T?) onSelected;
  final String hintText;

  const MultiLevelList({
    Key? key,
    required this.selectedItem,
    required this.items,
    required this.onSelected,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
      ),
      padding: EdgeInsets.all(12.w),
      child: DropdownButtonFormField<T>(
        value: selectedItem,
        onChanged: onSelected,
        items: items,
        decoration: InputDecoration(
          fillColor: Styling.textfieldsColor,
          filled: true,
          contentPadding: const EdgeInsets.all(12),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: const BorderSide(color: Colors.black, width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide.none,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide.none,
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            color: const Color.fromARGB(255, 112, 102, 102),
            fontSize: 17.sp,
          ),
        ),
        style: const TextStyle(
          color: Colors.black,
          fontFamily: "Sansita",
          fontSize: 16,
        ),
        dropdownColor: Styling.textfieldsColor,
        icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
      ),
    );
  }
}
