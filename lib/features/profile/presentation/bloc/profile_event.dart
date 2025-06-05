part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class LoadProfileSettings extends ProfileEvent {}

class UpdateNotificationSettingsEvent extends ProfileEvent {
  final NotificationSettings settings;

  const UpdateNotificationSettingsEvent(this.settings);

  @override
  List<Object?> get props => [settings];
}

class UpdateLanguageEvent extends ProfileEvent {
  final String language;

  const UpdateLanguageEvent(this.language);

  @override
  List<Object?> get props => [language];
}

class UpdatePasswordEvent extends ProfileEvent {
  final String currentPassword;
  final String newPassword;

  const UpdatePasswordEvent({
    required this.currentPassword,
    required this.newPassword,
  });

  @override
  List<Object?> get props => [currentPassword, newPassword];
}

class UpdateProfileEvent extends ProfileEvent {
  final String? name;
  final String? email;
  final String? avatar;

  const UpdateProfileEvent({
    this.name,
    this.email,
    this.avatar,
  });

  @override
  List<Object?> get props => [name, email, avatar];
}
