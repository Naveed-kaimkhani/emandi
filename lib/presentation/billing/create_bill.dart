import 'package:e_mandi/presentation/initial/container_dropdown.dart';
import 'package:e_mandi/presentation/initial/dropdown.dart';
import 'package:e_mandi/presentation/initial/item_count.dart';
import 'package:e_mandi/presentation/widgets/auth_button.dart';
import 'package:e_mandi/presentation/widgets/input_field.dart';
import 'package:e_mandi/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../style/styling.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CreateBillFromScratch extends StatefulWidget {
  const CreateBillFromScratch({Key? key}) : super(key: key);

  @override
  State<CreateBillFromScratch> createState() => _CreateBillFromScratchState();
}

class _CreateBillFromScratchState extends State<CreateBillFromScratch> {
  final _formKey = GlobalKey<FormState>();

  FocusNode nameFocusNode = FocusNode();
  FocusNode rateFocusNode = FocusNode();
  FocusNode fruitFocusNode = FocusNode();
  FocusNode percentageFocusNode = FocusNode();
  FocusNode rentFocusNode = FocusNode();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  // final TextEditingController _addressController = TextEditingController();
  Widget k = SizedBox(
    height: 16.h,
  );

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    nameFocusNode.dispose();
    // phoneFocusNode.dispose();
    rateFocusNode.dispose();
    rentFocusNode.dispose();
    percentageFocusNode.dispose();
    fruitFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // utils.checkConnectivity(context);
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
              AppLocalizations.of(context)!.createFromScratch,
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
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 40.h,
                  ),

                  InputField(
                    hint_text: AppLocalizations.of(context)!.enterUserName,
                    currentNode: nameFocusNode,
                    focusNode: nameFocusNode,
                    nextNode: fruitFocusNode,
                    controller: _nameController,
                    obsecureText: false,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Enter name";
                      } else {
                        return null;
                      }
                    },
                  ),
                  InputField(
                    hint_text: AppLocalizations.of(context)!.selectItemTypeName,
                    currentNode: nameFocusNode,
                    focusNode: nameFocusNode,
                    nextNode: fruitFocusNode,
                    controller: _nameController,
                    obsecureText: false,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Enter name";
                      } else {
                        return null;
                      }
                    },
                  ),

                  ContainerDropDown(
                    currentNode: fruitFocusNode,
                    nextNode: fruitFocusNode,
                  ),

                  const ItemCountDropDown(),
                  FruitDropdown(
                    currentNode: fruitFocusNode,
                    nextNode: fruitFocusNode,
                  ),

                  InputField(
                    hint_text: AppLocalizations.of(context)!.itemRates,
                    currentNode: rateFocusNode,
                    focusNode: rateFocusNode,
                    nextNode: percentageFocusNode,
                    controller: _nameController,
                    obsecureText: false,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Enter Rate";
                      } else {
                        return null;
                      }
                    },
                  ),

                  InputField(
                    hint_text: "percentage",
                    currentNode: percentageFocusNode,
                    focusNode: percentageFocusNode,
                    nextNode: rentFocusNode,
                    controller: _nameController,
                    obsecureText: false,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Enter Percentage";
                      } else {
                        return null;
                      }
                    },
                  ),
                  InputField(
                    hint_text: AppLocalizations.of(context)!.rent,
                    currentNode: rentFocusNode,
                    focusNode: rentFocusNode,
                    nextNode: rentFocusNode,
                    controller: _nameController,
                    obsecureText: false,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Enter Rent";
                      } else {
                        return null;
                      }
                    },
                  ),
                  // k,
                  SizedBox(
                    height: 30.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AuthButton(
                          height: 56.h,
                          widht: 220.w,
                          text: AppLocalizations.of(context)!.gENERATEBILL,
                          func: () {
                            FocusManager.instance.primaryFocus?.unfocus();

                            // _submitForm();
                          },
                          color: Styling.primaryColor),
                      AuthButton(
                          height: 56.h,
                          widht: 120.w,
                          text: AppLocalizations.of(context)!.submit,
                          func: () {
                            // Navigator.pushNamed(context, RoutesName.initial_list);
                            // _submitForm();
                          },
                          color: Styling.primaryColor),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
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
