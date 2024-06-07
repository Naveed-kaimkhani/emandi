import 'package:e_mandi/style/styling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthButton extends StatelessWidget {
  final String? text;
  final Function()? func;
  final Color? color;
  final double height;

  final double widht;
  const AuthButton({
    required this.text,
    required this.func,
    required this.color,
    required this.height,
    required this.widht,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: func,
      child: Container(
        width: widht,
        height: height,
        decoration: BoxDecoration(
          color: Styling.primaryColor,
          // gradient:  LinearGradient(
          //   colors: [
          //     Styling.backgroundColor, // Start color (primaryColor)
          //    Styling.primaryColor, // End color (you can change this to any other color you want)
          //   ],
          //   begin: Alignment.centerRight,
          //   end: Alignment.centerLeft,
          // ),
          borderRadius: BorderRadius.circular(28.r),
        ),
        child: Center(
          child: Text(
            text!,
            style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white),
          ),
        ),
      ),
    );
  }
}
