import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/profile_settings.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_remote_data_source.dart';
import '../datasources/profile_local_data_source.dart';
import '../models/profile_settings_model.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;
  final ProfileLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ProfileRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, ProfileSettings>> getProfileSettings() async {
    try {
      // For development, always use local data source
      final profileSettings = await localDataSource.getProfileSettings();
      return Right(profileSettings.toEntity());
    } catch (e) {
      return const Left(ServerFailure('Failed to fetch profile settings'));
    }
  }

  @override
  Future<Either<Failure, void>> updateNotificationSettings(
    NotificationSettings settings,
  ) async {
    try {
      await localDataSource.updateNotificationSettings(
        NotificationSettingsModel(
          checkInReminders: settings.checkInReminders,
          checkOutReminders: settings.checkOutReminders,
          nutritionPlanAlerts: settings.nutritionPlanAlerts,
          fitnessTestReminders: settings.fitnessTestReminders,
          workoutPlanAlerts: settings.workoutPlanAlerts,
          trainerAttendanceSummary: settings.trainerAttendanceSummary,
          paymentReminders: settings.paymentReminders,
        ),
      );
      return const Right(null);
    } catch (e) {
      return const Left(
          ServerFailure('Failed to update notification settings'));
    }
  }

  @override
  Future<Either<Failure, void>> updateLanguage(String language) async {
    try {
      await localDataSource.updateLanguage(language);
      return const Right(null);
    } catch (e) {
      return const Left(ServerFailure('Failed to update language'));
    }
  }

  @override
  Future<Either<Failure, void>> updatePassword(
    String currentPassword,
    String newPassword,
  ) async {
    try {
      await localDataSource.updatePassword(currentPassword, newPassword);
      return const Right(null);
    } catch (e) {
      return const Left(ServerFailure('Failed to update password'));
    }
  }

  @override
  Future<Either<Failure, void>> updateProfile({
    String? name,
    String? email,
    String? avatar,
  }) async {
    try {
      await localDataSource.updateProfile(
        name: name,
        email: email,
        avatar: avatar,
      );
      return const Right(null);
    } catch (e) {
      return const Left(ServerFailure('Failed to update profile'));
    }
  }
}
