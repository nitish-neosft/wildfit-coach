import 'package:equatable/equatable.dart';
import '../../../domain/entities/member.dart';

abstract class MemberState extends Equatable {
  const MemberState();

  @override
  List<Object?> get props => [];
}

class MemberInitial extends MemberState {}

class MemberLoading extends MemberState {}

class MemberLoaded extends MemberState {
  final Member member;

  const MemberLoaded(this.member);

  @override
  List<Object?> get props => [member];
}

class MemberError extends MemberState {
  final String message;

  const MemberError(this.message);

  @override
  List<Object?> get props => [message];
}

class MemberAuthError extends MemberState {
  final String message;

  const MemberAuthError(this.message);

  @override
  List<Object?> get props => [message];
}

class MemberNetworkError extends MemberState {
  final String message;

  const MemberNetworkError(this.message);

  @override
  List<Object?> get props => [message];
}

class MemberNotFound extends MemberState {
  final String message;

  const MemberNotFound(this.message);

  @override
  List<Object?> get props => [message];
}
