import 'package:e_mandi/presentation/category/category_container.dart';
// import 'package:e_mandi/presentation/widgets/input_field.dart';
// import 'package:e_mandi/presentation/widgets/SignupWithGoogle.dart';
import 'package:e_mandi/style/images.dart';
import 'package:e_mandi/style/styling.dart';
import 'package:e_mandi/utils/custom_loader.dart';
import 'package:e_mandi/utils/routes/routes_name.dart';
// import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    // LoaderOverlay.hide();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Styling.backgroundColor,
        // appBar: AppBar(
        //   title: const Text('CategoryScreen'),
        // ),
        body: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20.h,
            ),
            Image.asset(
              // logoImage,
              Images.logo_en,
              height: 280.h,
              width: 280.w,
            ),
            // SvgPicture(bytesLoader)

            Row(
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CategoryContainer(
                  imagePath: Images.initial,
                  text: AppLocalizations.of(context)!.iNITIAL,
                  onTap: () {
                    Navigator.pushNamed(context, RoutesName.initialScreen);
                  },
                ),
                CategoryContainer(
                  imagePath: Images.billing,
                  text: AppLocalizations.of(context)!.bILLING,
                  onTap: () {
                    Navigator.pushNamed(context, RoutesName.billingScreen);
                  },
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CategoryContainer(
                  imagePath: Images.ledger,
                  text: AppLocalizations.of(context)!.lEDGES,
                  onTap: () {
                    Navigator.pushNamed(context, RoutesName.ledgesScreen);
                  },
                ),
                CategoryContainer(
                  imagePath: Images.connection,
                  text: AppLocalizations.of(context)!.cONNECTIONS,
                  onTap: () {
                    Navigator.pushNamed(context, RoutesName.connectionScreen);
                  },
                ),
              ],
            )
          ],
        ));
  }
}
