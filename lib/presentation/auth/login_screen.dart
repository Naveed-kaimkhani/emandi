import 'package:e_mandi/bloc/bloc/login_bloc.dart';
import 'package:e_mandi/presentation/initial/initial_screen.dart';
import 'package:e_mandi/presentation/widgets/input_field.dart';
import 'package:e_mandi/presentation/widgets/SignupWithGoogle.dart';
import 'package:e_mandi/presentation/widgets/login_button.dart';
import 'package:e_mandi/style/images.dart';
import 'package:e_mandi/style/styling.dart';
import 'package:e_mandi/utils/custom_loader.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool obsecureText = true;

  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styling.backgroundColor,
      appBar: AppBar(
        backgroundColor: Styling.primaryColor,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.login,
          style: const TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Image.asset(
                  Images.logo_en,
                  height: 200.h,
                  width: 200.w,
                ),
                InputField(
                  hint_text: AppLocalizations.of(context)!.email,
                  currentNode: emailFocusNode,
                  focusNode: emailFocusNode,
                  nextNode: passwordFocusNode,
                  controller: _emailController,
                  obsecureText: false,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter email address";
                    } else if (!EmailValidator.validate(value)) {
                      return "Invalid email address";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                InputField(
                  hint_text: AppLocalizations.of(context)!.password,
                  currentNode: passwordFocusNode,
                  focusNode: passwordFocusNode,
                  nextNode: passwordFocusNode,
                  keyboardType: TextInputType.text,
                  controller: _passwordController,
                  icon: obsecureText
                      ? Icons.visibility_off
                      : Icons.remove_red_eye,
                  obsecureText: obsecureText,
                  onIconPress: () {
                    setState(() {
                      obsecureText = !obsecureText;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter password";
                    } else if (value.length < 6) {
                      return "Password must be of 6 characters";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 50),
                LoginButton(
                    formKey: _formKey,
                    text: AppLocalizations.of(context)!.login,
                    color: Styling.primaryColor,
                    height: 45.h,
                    widht: 210.w),
                SizedBox(
                  height: 30.h,
                ),
                SignupWithGoogle(
                  // formKey: _formKey,
                  height: 45.h,
                  width: 210.w,
                  text: AppLocalizations.of(context)!.signup,
                  color: Styling.primaryColor,
                ), // Widget for submit button
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
