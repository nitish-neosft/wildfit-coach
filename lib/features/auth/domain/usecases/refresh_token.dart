import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class RefreshToken {
  final AuthRepository repository;

  RefreshToken(this.repository);

  Future<User> call() {
    return repository.refreshToken();
  }
}
