import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class CheckAuthStatus {
  final AuthRepository repository;

  CheckAuthStatus(this.repository);

  Future<User?> call() {
    return repository.getCurrentUser();
  }
}
