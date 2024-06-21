import 'package:e_mandi/presentation/widgets/auth_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../style/custom_text_style.dart';
import '../../../style/styling.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ItemAddedDialogue extends StatefulWidget {
  const ItemAddedDialogue({super.key});

  @override
  State<ItemAddedDialogue> createState() => _ItemAddedDialogueState();
}

class _ItemAddedDialogueState extends State<ItemAddedDialogue> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      // shadowColor: Color.fromARGB(255, 135, 130, 130),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const DoneIcon(),
            SizedBox(
              height: 20.h,
            ),
            Text(
              AppLocalizations.of(context)!.itemAdded,
              style: CustomTextStyle.font_22_primary,
            ),
            SizedBox(height: 18.h),
            AuthButton(
                height: 50.h,
                widht: 120.w,
                fontsize: 20.sp,
                color: Styling.primaryColor,
                text: "Ok",
                func: () {
                  Navigator.pop(context);
                }),
          ],
        ),
      ),
    );
  }
}

class DoneIcon extends StatelessWidget {
  const DoneIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 30,
      backgroundColor: Styling.primaryColor,
      child: Icon(
        Icons.done,
        color: Colors.white,
        size: 30,
      ),
    );
  }
}
