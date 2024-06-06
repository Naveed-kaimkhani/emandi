import 'package:e_mandi/presentation/widgets/input_field.dart';
import 'package:e_mandi/presentation/widgets/submit_button.dart';
import 'package:e_mandi/style/styling.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        title: const Text('LoginScreen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                icon:
                    obsecureText ? Icons.visibility_off : Icons.remove_red_eye,
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
              // ElevatedButton(
              //   onPressed: () {
              //      _submitForm();
              //   },

                // child: const Text('LoginScreen'),
              // ),
               SubmitButton(
                  formKey: _formKey,
                ), // Widget for submit button
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Implement your Google LoginScreen logic here
                  print('LoginScreen with Google');
                },
                child: const Text('LoginScreen with Google'),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // _LoginScreen();
    }
  }

  
  // void _LoginScreen() {
  //   // isLoading(true);
  //   _firebaseRepository
  //       .LoginScreen(_emailController.text, _passwordController.text, context)
  //       // .LoginScreen("kkk@gmail.com", "111111", context)
  //       .then((User? user) async {
  //     if (user != null) {
  //       //  final   currentLocation = await Geolocator.getCurrentPosition();
  //       getUser();
  //     } else {
  //       isLoading(false);
  //       utils.flushBarErrorMessage("Failed to LoginScreen", context);
  //     }
  //   });
  // }
  
}
