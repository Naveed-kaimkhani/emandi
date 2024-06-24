import 'package:e_mandi/presentation/widgets/button_for_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import '../../../style/images.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

itemAddedDialog(context, String text) async {
  return await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        content: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.4,
            maxWidth: MediaQuery.of(context).size.width * 0.8,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset(
                Images.done,
                height: 150.h,
                width: 150.w,
              ),
              Text(
                text,
                style: TextStyle(
                  fontSize: 18.sp,
                  color: const Color(0xff326060),
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                AppLocalizations.of(context)!.itemAddedSucc,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    child: ButtonForDialogue(
                      text: "Ok",
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(
                    height: 14.w,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
