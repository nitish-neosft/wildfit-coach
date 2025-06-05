import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/profile_repository.dart';

class UpdateProfile implements UseCase<void, UpdateProfileParams> {
  final ProfileRepository repository;

  UpdateProfile(this.repository);

  @override
  Future<Either<Failure, void>> call(UpdateProfileParams params) {
    return repository.updateProfile(
      name: params.name,
      email: params.email,
      avatar: params.avatar,
    );
  }
}

class UpdateProfileParams extends Equatable {
  final String? name;
  final String? email;
  final String? avatar;

  const UpdateProfileParams({
    this.name,
    this.email,
    this.avatar,
  });

  @override
  List<Object?> get props => [name, email, avatar];
}
