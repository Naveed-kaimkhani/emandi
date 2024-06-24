import 'package:e_mandi/style/images.dart';
import 'package:e_mandi/style/styling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../services/splash/splash_services.dart'; // Importing the SplashServices class from the services/splash/splash_services.dart file

/// A widget representing the splash screen of the application.
class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

/// The state of the [SplashView] widget.
class _SplashViewState extends State<SplashView> {
  final SplashServices splashServices =
      SplashServices(); // Instance of SplashServices for handling splash screen logic

  @override
  void initState() {
    super.initState();
    // Calls the [checkAuthentication] method from [SplashServices] to handle authentication logic
    splashServices.checkAuthentication(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Styling.primaryColor,
        body: Center(
          child: Image.asset(
            Images.logo_en,
            height: 240.h,
            width: 240.w,
          ),
        ),
      ),
    );
  }
}
