// import 'package:dartz/dartz.dart';

// Future<void> _onFormSubmitted(
//   LoginApi event,
//   Emitter<LoginState> emit,
// ) async {
//   Map<String, String> data = {
//     'email': state.email,
//     'password': state.password,
//   };
//   emit(state.copyWith(
//     postApiStatus: PostApiStatus.loading,
//   ));
//   await firebaseAuthRepository.loginWithGoogle().then((either) async {
//     either.fold(
//       (failure) {
//         emit(state.copyWith(
//           postApiStatus: PostApiStatus.error,
//           message: failure.error, // Assuming `LoginFailure` has an `error` property
//         ));
//       },
//       (user) async {
//         await SessionController().saveUserInPreference(user);
//         await SessionController().getUserFromPreference();
//         emit(state.copyWith(postApiStatus: PostApiStatus.success));
//       },
//     );
//   }).onError((error, stackTrace) {
//     emit(state.copyWith(
//       postApiStatus: PostApiStatus.error,
//       message: error.toString(),
//     ));
//   });
// }
