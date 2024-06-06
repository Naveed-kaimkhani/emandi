
import 'package:e_mandi/domain/entities/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<UserModel> loginWithGoogle();
  
  Future<User?> loginWithEmailPass(String email, String password, context);
}