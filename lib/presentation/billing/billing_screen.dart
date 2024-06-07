import 'package:e_mandi/presentation/widgets/custom_container.dart';
import 'package:e_mandi/utils/routes/routes.dart';
import 'package:e_mandi/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                    imageContainerColor: Styling.textfieldsColor,
                    textColor: Colors.white,
                    navigateTo: RoutesName.createBill,
                  ),
                  SizedBox(height: 20.h),
                  CustomContainer(
                    imagePath: Images.initial, // Replace with your image path
                    text: AppLocalizations.of(context)!
                        .createFromInitialList, // Replace with your text
                    containerColor: Styling.textfieldsColor,
                    imageContainerColor: Styling.primaryColor,
                    textColor: Styling.primaryColor,
                    navigateTo: RoutesName.createBillFromInitialList,
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
