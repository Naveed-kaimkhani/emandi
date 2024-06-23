import 'package:dartz/dartz.dart';
import 'package:e_mandi/bloc/login_bloc/login_bloc.dart';
import 'package:e_mandi/domain/entities/user.dart';
import 'package:e_mandi/domain/failures/login_failure.dart';
import 'package:e_mandi/domain/repositories/auth_repository.dart';
import 'package:e_mandi/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthRepository implements AuthRepository {
 final FirebaseAuth _auth = FirebaseAuth.instance;
 
@override
Future<UserModel> loginWithGoogle() async {
  try {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = fb.GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    var fbUser = await fb.FirebaseAuth.instance.signInWithCredential(credential);

    // Create a User object directly
    final user = UserModel(
      uid: fbUser.user?.uid ?? '',
      name: fbUser.user?.displayName ?? '',
      email: fbUser.user?.email ?? '',
      phone: fbUser.user?.phoneNumber ?? '',
      imageUrl: fbUser.user?.photoURL ?? '',
    );

    return user;
  } catch (error) {
    throw LoginFailure(error: error.toString());
    // utils.flushBarErrorMessage(error.toString(), context)

  }
}

@override
 Future<User?> loginWithEmailPass(String email, String password, context) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      utils.flushBarErrorMessage("Invalid email or password", context);
      return null;
    }
  }
}
