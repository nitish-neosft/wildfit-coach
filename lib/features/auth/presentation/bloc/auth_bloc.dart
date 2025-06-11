import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/check_auth_status.dart';
import '../../domain/usecases/login.dart';
import '../../domain/usecases/logout.dart';
import '../../domain/usecases/register.dart';
import '../../domain/usecases/refresh_token.dart';
import '../../domain/usecases/reset_password.dart';
import 'auth_event.dart';
import 'auth_state.dart';

/// Manages the authentication state of the application using the BLoC pattern.
/// This bloc handles all authentication-related operations including login,
/// registration, logout, token refresh, and password reset.
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Login _login;
  final Register _register;
  final Logout _logout;
  final CheckAuthStatus _checkAuthStatus;
  final RefreshToken _refreshToken;
  final ResetPassword _resetPassword;

  AuthBloc({
    required Login login,
    required Register register,
    required Logout logout,
    required CheckAuthStatus checkAuthStatus,
    required RefreshToken refreshToken,
    required ResetPassword resetPassword,
  })  : _login = login,
        _register = register,
        _logout = logout,
        _checkAuthStatus = checkAuthStatus,
        _refreshToken = refreshToken,
        _resetPassword = resetPassword,
        super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<RegisterRequested>(_onRegisterRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<CheckAuthStatusRequested>(_onCheckAuthStatusRequested);
    on<TokenRefreshRequested>(_onTokenRefreshRequested);
    on<ResetPasswordRequested>(_onResetPasswordRequested);
  }

  /// Handles the login request event.
  /// Emits [AuthLoading] while processing and either [Authenticated]
  /// on success or [AuthError] on failure.
  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await _login(event.email, event.password);
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(Authenticated(user)),
    );
  }

  /// Handles the registration request event.
  /// Emits [AuthLoading] while processing and either [Authenticated]
  /// on success or [AuthError] on failure.
  Future<void> _onRegisterRequested(
    RegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await _register(
        event.name, event.email, event.password, event.confirmPassword);
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(Authenticated(user)),
    );
  }

  /// Handles the logout request event.
  /// Emits [AuthLoading] while processing and either [Unauthenticated]
  /// on success or [AuthError] on failure.
  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await _logout();
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(Unauthenticated()),
    );
  }

  /// Handles the check auth status request event.
  /// Emits [AuthLoading] while processing and either [Authenticated]
  /// if a user is found or [Unauthenticated] if no user is found.
  Future<void> _onCheckAuthStatusRequested(
    CheckAuthStatusRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await _checkAuthStatus();
    result.fold(
      (failure) => emit(Unauthenticated()),
      (user) =>
          user != null ? emit(Authenticated(user)) : emit(Unauthenticated()),
    );
  }

  /// Handles the token refresh request event.
  /// Emits [Authenticated] on success or [AuthError] on failure.
  Future<void> _onTokenRefreshRequested(
    TokenRefreshRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await _refreshToken();
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(Authenticated(user)),
    );
  }

  /// Handles the password reset request event.
  /// Emits [AuthLoading] while processing and either [PasswordResetRequested]
  /// on success or [PasswordResetError] on failure.
  Future<void> _onResetPasswordRequested(
    ResetPasswordRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await _resetPassword(event.email);
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (success) => emit(
        success ? const PasswordResetSuccess() : const PasswordResetFailure(),
      ),
    );
  }
}
