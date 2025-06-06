import 'package:equatable/equatable.dart';
import '../../domain/entities/user.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class Authenticated extends AuthState {
  final User user;

  const Authenticated(this.user);

  @override
  List<Object?> get props => [user];
}

class Unauthenticated extends AuthState {}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}

class PasswordResetRequested extends AuthState {}

class PasswordResetSuccess extends AuthState {
  const PasswordResetSuccess();
}

class PasswordResetFailure extends AuthState {
  const PasswordResetFailure();
}

class PasswordResetError extends AuthState {
  final String message;

  const PasswordResetError(this.message);

  @override
  List<Object?> get props => [message];
}
