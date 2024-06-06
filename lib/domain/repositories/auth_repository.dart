
import 'package:dartz/dartz.dart';
import 'package:e_mandi/domain/entities/user.dart';
import 'package:e_mandi/domain/failures/login_failure.dart';

abstract class AuthRepository {
  Future<UserModel> loginWithGoogle();
}