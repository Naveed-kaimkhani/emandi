
import 'package:dartz/dartz.dart';
import 'package:e_mandi/domain/failures/get_user_failure.dart';
import 'package:e_mandi/domain/failures/update_user_failure.dart';
import 'package:e_mandi/domain/failures/users_list_failure.dart';

import '../entities/user.dart';

abstract class UsersRepository {
  Future<Either<UsersListFailure, List<UserModel>>> getUsers();

  Future<Either<UpdateUserFailure, bool>> updateUser(UserModel user);

  Future<Either<GetUserFailure, UserModel>> getUserByEmail(String email);
}
