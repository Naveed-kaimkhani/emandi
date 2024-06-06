import 'dart:async'; // Importing dart:async for asynchronous operations
import 'package:e_mandi/services/session_manager/session_controller.dart';
import 'package:e_mandi/utils/routes/routes_name.dart';
import 'package:flutter/material.dart'; // Importing Flutter material library

/// A class containing services related to the splash screen.
class SplashServices {
  /// Checks authentication status and navigates accordingly.
  ///
  /// Takes a [BuildContext] as input and navigates to the home screen if the user is authenticated,
  /// otherwise navigates to the login screen after a delay of 2 seconds.
  void checkAuthentication(BuildContext context) async {
    SessionController().getUserFromPreference().then((value) async {
      if (SessionController.isLogin ?? false) {
        Timer(
          const Duration(seconds: 2),
          () => Navigator.pushNamedAndRemoveUntil(context, RoutesName.home, (route) => false),
        );
      } else {
        Timer(
          const Duration(seconds: 2),
          () => Navigator.pushNamedAndRemoveUntil(context, RoutesName.login, (route) => false),
        );
      }
    }).onError((error, stackTrace) {
      Timer(
        const Duration(seconds: 2),
        () => Navigator.pushNamedAndRemoveUntil(context, RoutesName.login, (route) => false),
      );
    });
  }
}
