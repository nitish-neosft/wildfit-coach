import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/profile_repository.dart';

class UpdateLanguage implements UseCase<void, UpdateLanguageParams> {
  final ProfileRepository repository;

  UpdateLanguage(this.repository);

  @override
  Future<Either<Failure, void>> call(UpdateLanguageParams params) {
    return repository.updateLanguage(params.language);
  }
}

class UpdateLanguageParams extends Equatable {
  final String language;

  const UpdateLanguageParams({required this.language});

  @override
  List<Object?> get props => [language];
}
