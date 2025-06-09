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
      final profileSettings = await localDataSource.getProfileSettings();
      return Right(profileSettings);
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateNotificationSettings(
    NotificationSettings settings,
  ) async {
    try {
      await localDataSource.updateNotificationSettings(
        NotificationSettingsModel(
          memberCheckInAlerts: settings.memberCheckInAlerts,
          memberAssessmentReminders: settings.memberAssessmentReminders,
          memberProgressAlerts: settings.memberProgressAlerts,
          membershipExpiryAlerts: settings.membershipExpiryAlerts,
          newMemberAssignments: settings.newMemberAssignments,
          staffMeetingReminders: settings.staffMeetingReminders,
          paymentReminders: settings.paymentReminders,
        ),
      );
      return const Right(null);
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateLanguage(String language) async {
    try {
      await localDataSource.updateLanguage(language);
      return const Right(null);
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
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
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
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
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
