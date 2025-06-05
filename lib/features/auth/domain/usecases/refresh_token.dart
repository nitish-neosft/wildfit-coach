import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class RefreshToken {
  final AuthRepository repository;

  RefreshToken(this.repository);

  Future<Either<Failure, User>> call() {
    return repository.refreshToken();
  }
}
