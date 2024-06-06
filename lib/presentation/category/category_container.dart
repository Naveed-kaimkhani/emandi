import 'package:e_mandi/style/images.dart';
import 'package:flutter/material.dart';
import 'package:e_mandi/style/styling.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CategoryContainer extends StatelessWidget {
  final String imagePath;
  final String text;
  final VoidCallback onTap;

  const CategoryContainer({
    Key? key,
    required this.imagePath,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.0),
      child: Container(
        width: 131.w,
        height: 161.h,
        decoration: BoxDecoration(
          color: Styling.primaryColor,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5.0,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100.w, // Adjust the size as needed
              height: 100
                  .h, // Keeping width and height the same to make it circular
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 5.0,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Center(
                child: Image.asset(
                  imagePath,
                  width: 80.w, // Adjust the size of the image as needed
                  height: 80
                      .h, // Keeping width and height the same for aspect ratio
                ),
              ),
            ),
            SizedBox(
                height: 10.h), // Add some spacing between the image and text
            Text(
              text,
              style: TextStyle(
                color: Colors.white, // Adjust the color as needed
                fontSize: 14.sp, // Adjust the font size as needed
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
