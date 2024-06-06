import 'package:e_mandi/presentation/category/category_container.dart';
import 'package:e_mandi/presentation/widgets/input_field.dart';
import 'package:e_mandi/presentation/widgets/submit_button.dart';
import 'package:e_mandi/style/images.dart';
import 'package:e_mandi/style/styling.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Styling.backgroundColor,
        // appBar: AppBar(
        //   title: const Text('CategoryScreen'),
        // ),
        body: Column(
          children: [
            Image.asset(
              // logoImage,
              Images.logo_png,
              height: 280.h,
              width: 280.w,
            ),
            // SvgPicture(bytesLoader)

            Row(
              children: [
                CategoryContainer(
                  imagePath: Images.initial_svg,
                  text: AppLocalizations.of(context)!.iNITIAL,
                  onTap: () {},
                ),
                CategoryContainer(
                  imagePath: Images.initial_svg,
                  text: AppLocalizations.of(context)!.iNITIAL,
                  onTap: () {},
                ),
              ],
            ),

            Row(
              children: [
                CategoryContainer(
                  imagePath: Images.initial_svg,
                  text: AppLocalizations.of(context)!.iNITIAL,
                  onTap: () {},
                ),
                CategoryContainer(
                  imagePath: Images.initial_svg,
                  text: AppLocalizations.of(context)!.iNITIAL,
                  onTap: () {},
                ),
              ],
            )
          ],
        ));
  }

  // void _CategoryScreen() {
  //   // isLoading(true);
  //   _firebaseRepository
  //       .CategoryScreen(_emailController.text, _passwordController.text, context)
  //       // .CategoryScreen("kkk@gmail.com", "111111", context)
  //       .then((User? user) async {
  //     if (user != null) {
  //       //  final   currentLocation = await Geolocator.getCurrentPosition();
  //       getUser();
  //     } else {
  //       isLoading(false);
  //       utils.flushBarErrorMessage("Failed to CategoryScreen", context);
  //     }
  //   });
  // }
}
