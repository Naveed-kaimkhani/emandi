import 'package:e_mandi/presentation/widgets/custom_container.dart';
import 'package:e_mandi/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../style/images.dart';
import '../../style/styling.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LedgesScreen extends StatefulWidget {
  const LedgesScreen({Key? key}) : super(key: key);

  @override
  State<LedgesScreen> createState() => _LedgesScreenState();
}

class _LedgesScreenState extends State<LedgesScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Styling.primaryColor,
            centerTitle: true,
            title: Text(
              AppLocalizations.of(context)!.lEDGES,
              style: const TextStyle(color: Colors.white),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          backgroundColor: Styling.backgroundColor,
          body: Padding(
            padding: EdgeInsets.only(left: 30.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20.h),
                Image.asset(Images.ledges, height: 280.h, width: 280.w),
                SizedBox(height: 16.h),
                CustomContainer(
                  imagePath: Images.view, // Replace with your image path
                  text: AppLocalizations.of(context)!
                      .bILLING, // Replace with your text
                  containerColor: Styling.primaryColor,
                  imageContainerColor: Styling.textfieldsColor,
                  navigateTo: RoutesName.viewLedges,
                  textColor: Colors.white,
                ),
                SizedBox(height: 20.h),
                CustomContainer(
                  imagePath: Images.edit, // Replace with your image path
                  text: AppLocalizations.of(context)!
                      .createFromInitialList, // Replace with your text
                  containerColor: Styling.textfieldsColor,
                  imageContainerColor: Styling.primaryColor,
                  textColor: Styling.primaryColor,
                  navigateTo: RoutesName.editLedges,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
