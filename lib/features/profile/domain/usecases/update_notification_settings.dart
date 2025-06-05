import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/profile_settings.dart';
import '../repositories/profile_repository.dart';

class UpdateNotificationSettings
    implements UseCase<void, UpdateNotificationSettingsParams> {
  final ProfileRepository repository;

  UpdateNotificationSettings(this.repository);

  @override
  Future<Either<Failure, void>> call(UpdateNotificationSettingsParams params) {
    return repository.updateNotificationSettings(params.settings);
  }
}

class UpdateNotificationSettingsParams extends Equatable {
  final NotificationSettings settings;

  const UpdateNotificationSettingsParams({required this.settings});

  @override
  List<Object?> get props => [settings];
}
