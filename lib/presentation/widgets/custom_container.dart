import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomContainer extends StatelessWidget {
  final String imagePath;
  final String text;
  
  final String navigateTo;
  final Color containerColor;
  final Color imageContainerColor;
  final Color textColor;

  const CustomContainer({
    Key? key,
    required this.imagePath,
    required this.text,
    required this.containerColor,
    required this.imageContainerColor,
    required this.textColor, required this.navigateTo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // onTap();
        Navigator.pushNamed(context, navigateTo);
      },
      child: Container(
        width: 320.w,
        height: 130.h,
        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.circular(26.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 80.w,
              height: 80.h,
              decoration: BoxDecoration(
                color: imageContainerColor,
                borderRadius: BorderRadius.circular(25.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Center(
                child: Image.asset(imagePath, width: 80.w, height: 80.h),
              ),
            ),
            Text(
              text,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: 20.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
