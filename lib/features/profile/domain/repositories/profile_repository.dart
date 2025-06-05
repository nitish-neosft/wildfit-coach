import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/profile_settings.dart';

abstract class ProfileRepository {
  Future<Either<Failure, ProfileSettings>> getProfileSettings();
  Future<Either<Failure, void>> updateNotificationSettings(
      NotificationSettings settings);
  Future<Either<Failure, void>> updateLanguage(String language);
  Future<Either<Failure, void>> updatePassword(
      String currentPassword, String newPassword);
  Future<Either<Failure, void>> updateProfile({
    String? name,
    String? email,
    String? avatar,
  });
}
