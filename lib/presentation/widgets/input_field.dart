import 'package:e_mandi/style/styling.dart';
import 'package:e_mandi/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class InputField extends StatelessWidget {
  String? hint_text;
  FocusNode? currentNode;
  FocusNode? nextNode;
  bool? obsecureText;
  FocusNode? focusNode;
  IconData? icon;
  Widget? preicon;
  
  Widget? suffixIcon;
  dynamic validator;
  TextInputType? keyboardType;
  Function()? onIconPress;
  TextEditingController? controller;
  Function(String)? onChanged;


  InputField({
    super.key,
    required this.hint_text,
    required this.currentNode,
    required this.focusNode,
    required this.nextNode,
    required this.controller,
    this.validator,
    this.icon,
    this.preicon,
    this.suffixIcon,
    this.onIconPress,
    this.obsecureText,
    this.keyboardType,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
      ),
      padding: EdgeInsets.all(12.w),
      child: TextFormField(
        style: const TextStyle(
            color: Colors.black, fontFamily: "Sansita", fontSize: 16),
        keyboardType: keyboardType ?? TextInputType.text,
        obscureText: obsecureText ?? false,
        controller: controller,
        cursorColor: Colors.black,
        focusNode: focusNode,
        onEditingComplete: () =>
            utils.fieldFocusChange(context, currentNode!, nextNode!),
        onChanged: onChanged,
        // suffixIcon: suffixIcon,
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
          hintText: hint_text,
          hintStyle: TextStyle(
            color: const Color.fromARGB(255, 112, 102, 102),
            fontSize: 17.sp,
          ),
          prefixIcon: preicon,
          suffixIcon: suffixIcon,
        ),
        validator: validator,
      ),
    );
  }
}
