import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lottie/lottie.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../style/styling.dart';

class NoInternetCnnection extends StatefulWidget {
  const NoInternetCnnection({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NoInternetCnnectionState createState() => _NoInternetCnnectionState();
}

class _NoInternetCnnectionState extends State<NoInternetCnnection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Lottie.asset(
                "assets/no.json",
                height: 300.h,
                width: 300.w,
              ),
            ),
            SizedBox(
              height: 26.h,
            ),
            Text(
              "Ooops!",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontSize: 29.sp,
              ),
            ),
            SizedBox(
              height: 14.h,
            ),
             Text(
            AppLocalizations.of(context)!.youAreNotConnectedToTheInternetPleaseCheckYourInternetConnection,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 42.h,
            ),
            InkWell(
              onTap: () {
                InternetConnectionChecker().hasConnection.then((connected) {
                  if (connected) {
                    Navigator.pop(context);
                    // Do something when connected
                  }
                });
              },
              child: Container(
                height: 50.h,
                width: 300.w,
                decoration: BoxDecoration(
                  color: Styling.primaryColor,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Center(
                  child: Text(
                    AppLocalizations.of(context)!.tryAgain,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontSize: 17.sp,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
