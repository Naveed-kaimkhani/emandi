import 'package:e_mandi/utils/enums.dart';
import 'package:e_mandi/utils/routes/routes_name.dart';
import 'package:e_mandi/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/bloc/login_bloc.dart';


/// A widget representing the submit button for the login form.
class SubmitButton extends StatelessWidget {
  final formKey;
  const SubmitButton({Key? key, required this.formKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listenWhen: (current, previous) => current.postApiStatus != previous.postApiStatus,
      listener: (context, state) {
        if (state.postApiStatus == PostApiStatus.error) {
          // context.flushBarErrorMessage(message: state.message.toString());
          utils.flushBarErrorMessage(state.message, context);
        }

        if (state.postApiStatus == PostApiStatus.success) {
          Navigator.pushNamedAndRemoveUntil(context, RoutesName.home, (route) => false);
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
          buildWhen: (current, previous) => current.postApiStatus != previous.postApiStatus,
          builder: (context, state) {
            return ElevatedButton(
                onPressed: () {
                  if (formKey.currentState.validate()) {
                    context.read<LoginBloc>().add(LoginApi());
                  }
                },
                child: state.postApiStatus == PostApiStatus.loading ? const CircularProgressIndicator() : const Text('Login'));
          }),
    );
  }
}
