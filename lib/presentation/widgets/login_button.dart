import 'package:e_mandi/style/images.dart';
import 'package:e_mandi/style/styling.dart';
import 'package:e_mandi/utils/custom_loader.dart';
import 'package:e_mandi/utils/enums.dart';
import 'package:e_mandi/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../bloc/login_bloc/login_bloc.dart';

/// A widget representing the submit button for the login form.
class LoginButton extends StatelessWidget {
  final String? text;
  // final Function()? func;
  final Color? color;
  final double height;

  final double widht;

  final formKey;
  const LoginButton({
    Key? key,
    required this.formKey,
    required this.text,
    // required this.func,
    required this.color,
    required this.height,
    required this.widht,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listenWhen: (current, previous) =>
          current.postApiStatus != previous.postApiStatus,
      listener: (context, state) {
        if (state.postApiStatus == PostApiStatus.loading) {
          // context.flushBarErrorMessage(message: state.message.toString());
          // utils.flushBarErrorMessage(state.message, context);
          LoaderOverlay.show(context);
        }

        if (state.postApiStatus == PostApiStatus.error) {
          LoaderOverlay.hide();
          // context.flushBarErrorMessage(message: state.message.toString());
          utils.flushBarErrorMessage(state.message, context);
        }
        if (state.postApiStatus == PostApiStatus.success) {
          // Navigator.pushNamedAndRemoveUntil(
          //     context, RoutesName.home, (route) => false);
          LoaderOverlay.hide();
          utils.flushBarErrorMessage("hogyaa bhaiiiiiiii", context);
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
          buildWhen: (current, previous) =>
              current.postApiStatus != previous.postApiStatus,
          builder: (context, state) {
            return InkWell(
              onTap: () {
                // if (formKey.currentState.validate()) {
                //   context.read<LoginBloc>().add(LoginApi());
                // }

                context.read<LoginBloc>().add(LoginWithEmailPass());
              },
              // child: state.postApiStatus == PostApiStatus.loading ? const CircularProgressIndicator() : const Text('Login'));
              child: Container(
                width: widht,
                height: height,
                decoration: BoxDecoration(
                  color: Styling.primaryColor,
                  borderRadius: BorderRadius.circular(28.r),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // SvgPicture.asset(Images.google_icon_svg),
                      Text(
                        text!,
                        style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                      // Image.asset(Images.google_icon),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
