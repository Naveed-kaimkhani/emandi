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

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  // final FirebaseUserRepository _firebaseUserRepository =
  //     FirebaseUserRepository();          // replace this thing with getx
  final _formKey = GlobalKey<FormState>();

  FocusNode nameFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  FocusNode fruitFocusNode = FocusNode();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  // final TextEditingController _addressController = TextEditingController();
  Widget k = SizedBox(
    height: 16.h,
  );
  // void isLoading(bool value) {
  //   setState(() {
  //     isLoadingNow = value;
  //   });
  // }

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
              AppLocalizations.of(context)!.iNITIAL,
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
                  FruitDropdown(
                    currentNode: fruitFocusNode,
                    nextNode: fruitFocusNode,
                  ),
                  ContainerDropDown(
                    currentNode: fruitFocusNode,
                    nextNode: fruitFocusNode,
                  ),
                  const ItemCountDropDown(),

                  InputField(
                    hint_text: AppLocalizations.of(context)!.rent,
                    currentNode: nameFocusNode,
                    focusNode: nameFocusNode,
                    nextNode: fruitFocusNode,
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
                          widht: 110.w,
                          text: AppLocalizations.of(context)!.submit,
                          func: () {
                            FocusManager.instance.primaryFocus?.unfocus();

                            // _submitForm();
                          },
                          color: Styling.primaryColor),

                      // SizedBox(
                      //   height: 10.h,
                      // ),
                      AuthButton(
                          height: 56.h,
                          widht: 200.w,
                          text: AppLocalizations.of(context)!.viewList,
                          // text: "View List",
                          func: () {
                            Navigator.pushNamed(
                                context, RoutesName.initialList);
                            // _submitForm();
                          },
                          color: Styling.primaryColor),
                    ],
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
