import 'dart:typed_data';
import 'package:e_mandi/presentation/initial/container_dropdown.dart';
import 'package:e_mandi/presentation/initial/dropdown.dart';
import 'package:e_mandi/presentation/initial/item_count.dart';
import 'package:e_mandi/presentation/widgets/auth_button.dart';
import 'package:e_mandi/presentation/widgets/input_field.dart';
import 'package:e_mandi/utils/utils.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../style/images.dart';
import '../../style/styling.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BillingScreen extends StatefulWidget {
  const BillingScreen({Key? key}) : super(key: key);

  @override
  State<BillingScreen> createState() => _BillingScreenState();
}

class _BillingScreenState extends State<BillingScreen> {
  final _formKey = GlobalKey<FormState>();

  FocusNode nameFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  FocusNode fruitFocusNode = FocusNode();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    nameFocusNode.dispose();
    phoneFocusNode.dispose();
    fruitFocusNode.dispose();
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
              AppLocalizations.of(context)!.bILLING,
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
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 30.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20.h),
                  Image.asset(Images.billing_scren,
                      height: 280.h, width: 280.w),
                  SizedBox(height: 16.h),
                  CustomContainer(
                    imagePath: Images.ledger, // Replace with your image path
                    text: AppLocalizations.of(context)!
                        .createFromScratch, // Replace with your text
                    containerColor: Styling.primaryColor,
                    imageContainerColor: Colors.white,
                    textColor: Colors.white,
                  ),
                  SizedBox(height: 20.h),
                  CustomContainer(
                    imagePath: Images.initial, // Replace with your image path
                    text: AppLocalizations.of(context)!
                        .createFromInitialList, // Replace with your text
                    containerColor: Color.fromARGB(255, 219, 218, 218),
                    imageContainerColor: Styling.primaryColor,
                    textColor: Styling.primaryColor,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomContainer extends StatelessWidget {
  final String imagePath;
  final String text;
  final Color containerColor;
  final Color imageContainerColor;
  final Color textColor;

  const CustomContainer({
    Key? key,
    required this.imagePath,
    required this.text,
    required this.containerColor,
    required this.imageContainerColor,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320.w,
      height: 130.h,
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(26.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80.w,
            height: 80.h,
            decoration: BoxDecoration(
              color: imageContainerColor,
              borderRadius: BorderRadius.circular(25.r),
            ),
            child: Center(
              child: Image.asset(imagePath, width: 80.w, height: 80.h),
            ),
          ),
          // Image.asset(imagePath, width: 80.w, height: 80.h),
          SizedBox(width: 10.w),
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
    );
  }
}
