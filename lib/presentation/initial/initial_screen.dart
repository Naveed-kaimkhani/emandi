// import 'dart:typed_data';
import 'dart:typed_data';
import 'package:e_mandi/presentation/initial/dropdown.dart';
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
class UserSignUp extends StatefulWidget {
  const UserSignUp({Key? key}) : super(key: key);

  @override
  State<UserSignUp> createState() => _UserSignUpState();
}

class _UserSignUpState extends State<UserSignUp> {
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
    utils.checkConnectivity(context);
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
          backgroundColor: Colors.white,
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20.h,
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
                  FruitDropdown(currentNode: fruitFocusNode,nextNode: fruitFocusNode,),
                  
                  // k,
                  SizedBox(
                    height: 18.h,
                  ),

                  // isLoadingNow
                  //     ? const CircleProgress()
                  //     :
                       AuthButton(
                        
                          height: 56.h,
                          widht: 300.w,
                          text: "Signup",
                          func: () {
                            FocusManager.instance.primaryFocus?.unfocus();

                            // _submitForm();
                          },
                          color: Styling.primaryColor),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}
