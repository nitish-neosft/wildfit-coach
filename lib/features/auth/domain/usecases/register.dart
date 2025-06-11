import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class Register {
  final AuthRepository repository;

  Register(this.repository);

  Future<Either<Failure, User>> call(
      String name, String email, String password, String confirmPassword) {
    return repository.register(name, email, password, confirmPassword);
  }
}
