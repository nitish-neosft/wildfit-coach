import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/profile_settings.dart';
import '../repositories/profile_repository.dart';

class GetProfileSettings implements UseCase<ProfileSettings, NoParams> {
  final ProfileRepository repository;

  GetProfileSettings(this.repository);

  @override
  Future<Either<Failure, ProfileSettings>> call(NoParams params) {
    return repository.getProfileSettings();
  }
}
