import 'package:bloc/bloc.dart';
import 'package:e_mandi/data/firebase/firebase_auth_repository.dart';
import 'package:e_mandi/services/session_manager/session_controller.dart';
import 'package:e_mandi/utils/enums.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState> {
  FirebaseAuthRepository firebaseAuthRepository;
  LoginBloc({required this.firebaseAuthRepository}) : super(const LoginState()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<LoginApi>(_onFormSubmitted);
  }

  void _onEmailChanged(EmailChanged event, Emitter<LoginState> emit) {
    emit(
      state.copyWith(
        email: event.email,
      ),
    );
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<LoginState> emit) {
    emit(
      state.copyWith(
        password: event.password,
      ),
    );
  }


  // Future<void> _onFormSubmitted(
  //   LoginApi event,
  //   Emitter<LoginState> emit,
  // ) async {
  //   // Map<String, String> data = {
  //   //   'email': 'eve.holt@reqres.in',
  //   //   'password': 'cityslicka',
  //   // };
  //   Map<String, String> data = {
  //     'email': state.email,
  //     'password': state.password,
  //   };
  //   emit(state.copyWith(
  //     postApiStatus: PostApiStatus.loading,
  //   ));
  //   await firebaseAuthRepository.loginWithGoogle().then((value) async {
  //     if (value.error.isNotEmpty) {
  //       emit(state.copyWith(postApiStatus: PostApiStatus.error, message: value.error));
  //     } else {
  //       await SessionController().saveUserInPreference(value);
  //       await SessionController().getUserFromPreference();
  //       emit(state.copyWith(postApiStatus: PostApiStatus.success));
  //     }
  //   }).onError((error, stackTrace) {
  //     emit(state.copyWith(postApiStatus: PostApiStatus.error, message: error.toString()));
  //   });
  // }

  Future<void> _onFormSubmitted(
  LoginApi event,
  Emitter<LoginState> emit,
) async {
  // Map<String, String> data = {
  //   'email': 'eve.holt@reqres.in',
  //   'password': 'cityslicka',
  // };
  Map<String, String> data = {
    'email': state.email,
    'password': state.password,
  };
  emit(state.copyWith(
    postApiStatus: PostApiStatus.loading,
  ));

  try {
    final user = await firebaseAuthRepository.loginWithGoogle();
    await SessionController().saveUserInPreference(user);
    await SessionController().getUserFromPreference();
    emit(state.copyWith(postApiStatus: PostApiStatus.success));
  } catch (error) {
    emit(state.copyWith(
      postApiStatus: PostApiStatus.error,
      message: error.toString(),
    ));
  }
}


}
