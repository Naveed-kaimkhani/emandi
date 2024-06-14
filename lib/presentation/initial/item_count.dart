import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_mandi/style/styling.dart';

class ItemCountDropDown extends StatelessWidget {
  final Function(int) onSelected;

  const ItemCountDropDown({
    Key? key,
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
        child: DropdownButton<int>(
          items: <int>[5, 10, 15].map((int value) {
            return DropdownMenuItem<int>(
              value: value,
              child: Text(value.toString()),
            );
          }).toList(),
          onChanged: (newValue) {
            if (newValue != null) {
              onSelected(newValue);
            }
          },
          hint: Text(
            'Item count',
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
