
import 'package:e_mandi/style/images.dart';
import 'package:e_mandi/style/styling.dart';
import 'package:e_mandi/utils/custom_loader.dart';
import 'package:e_mandi/utils/enums.dart';
import 'package:e_mandi/utils/routes/routes_name.dart';
import 'package:e_mandi/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../bloc/login_bloc/login_bloc.dart';

/// A widget representing the submit button for the login form.
class SignupWithGoogle extends StatelessWidget {
  final String? text;
  final Color? color;
  final double height;
  final double width;
  // final formKey;

  const SignupWithGoogle({
    Key? key,
    // required this.formKey,
    required this.text,
    required this.color,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listenWhen: (current, previous) =>
          current.postApiStatus != previous.postApiStatus,
      listener: (context, state) async {
        if (state.postApiStatus == PostApiStatus.loading) {
          // LoaderOverlay.show(context);
          utils.toastMessage("Please wait...");
        } else if (state.postApiStatus == PostApiStatus.error) {
          LoaderOverlay.hide();
          utils.flushBarErrorMessage(state.message, context);
        } else if (state.postApiStatus == PostApiStatus.success) {
          // LoaderOverlay.hide();
          // utils.flushBarErrorMessage(state.message, context);
          Navigator.pushNamed(context, RoutesName.categoryScreen);
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        buildWhen: (current, previous) =>
            current.postApiStatus != previous.postApiStatus,
        builder: (context, state) {
          return InkWell(
            onTap: () {
              context.read<LoginBloc>().add(LoginApi());
              // if (formKey.currentState?.validate() ?? false) {
              // }
            },
            child: Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                color: Styling.primaryColor,
                borderRadius: BorderRadius.circular(28.r),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      text!,
                      style: TextStyle(
                          fontSize: 25.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    Image.asset(Images.google_icon),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
