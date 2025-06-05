import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/profile_settings.dart';
import '../../domain/usecases/get_profile_settings.dart';
import '../../domain/usecases/update_language.dart';
import '../../domain/usecases/update_notification_settings.dart';
import '../../domain/usecases/update_password.dart';
import '../../domain/usecases/update_profile.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileSettings getProfileSettings;
  final UpdateNotificationSettings updateNotificationSettings;
  final UpdateLanguage updateLanguage;
  final UpdatePassword updatePassword;
  final UpdateProfile updateProfile;

  ProfileBloc({
    required this.getProfileSettings,
    required this.updateNotificationSettings,
    required this.updateLanguage,
    required this.updatePassword,
    required this.updateProfile,
  }) : super(ProfileInitial()) {
    on<LoadProfileSettings>(_onLoadProfileSettings);
    on<UpdateNotificationSettingsEvent>(_onUpdateNotificationSettings);
    on<UpdateLanguageEvent>(_onUpdateLanguage);
    on<UpdatePasswordEvent>(_onUpdatePassword);
    on<UpdateProfileEvent>(_onUpdateProfile);
  }

  Future<void> _onLoadProfileSettings(
    LoadProfileSettings event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());
    final result = await getProfileSettings(NoParams());
    result.fold(
      (failure) => emit(ProfileError(_mapFailureToMessage(failure))),
      (settings) => emit(ProfileLoaded(settings)),
    );
  }

  Future<void> _onUpdateNotificationSettings(
    UpdateNotificationSettingsEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileUpdating());
    final result = await updateNotificationSettings(
      UpdateNotificationSettingsParams(settings: event.settings),
    );
    result.fold(
      (failure) => emit(ProfileUpdateError(_mapFailureToMessage(failure))),
      (_) async {
        final settingsResult = await getProfileSettings(NoParams());
        settingsResult.fold(
          (failure) => emit(ProfileError(_mapFailureToMessage(failure))),
          (settings) => emit(ProfileLoaded(settings)),
        );
      },
    );
  }

  Future<void> _onUpdateLanguage(
    UpdateLanguageEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileUpdating());
    final result = await updateLanguage(
      UpdateLanguageParams(language: event.language),
    );
    result.fold(
      (failure) => emit(ProfileUpdateError(_mapFailureToMessage(failure))),
      (_) async {
        final settingsResult = await getProfileSettings(NoParams());
        settingsResult.fold(
          (failure) => emit(ProfileError(_mapFailureToMessage(failure))),
          (settings) => emit(ProfileLoaded(settings)),
        );
      },
    );
  }

  Future<void> _onUpdatePassword(
    UpdatePasswordEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileUpdating());
    final result = await updatePassword(
      UpdatePasswordParams(
        currentPassword: event.currentPassword,
        newPassword: event.newPassword,
      ),
    );
    result.fold(
      (failure) => emit(ProfileUpdateError(_mapFailureToMessage(failure))),
      (_) => emit(ProfileUpdateSuccess()),
    );
  }

  Future<void> _onUpdateProfile(
    UpdateProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileUpdating());
    final result = await updateProfile(
      UpdateProfileParams(
        name: event.name,
        email: event.email,
        avatar: event.avatar,
      ),
    );
    result.fold(
      (failure) => emit(ProfileUpdateError(_mapFailureToMessage(failure))),
      (_) async {
        final settingsResult = await getProfileSettings(NoParams());
        settingsResult.fold(
          (failure) => emit(ProfileError(_mapFailureToMessage(failure))),
          (settings) => emit(ProfileLoaded(settings)),
        );
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server error occurred';
      case NetworkFailure:
        return 'Network error occurred';
      default:
        return 'Unexpected error occurred';
    }
  }
}
