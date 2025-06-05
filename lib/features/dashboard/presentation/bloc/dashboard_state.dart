part of 'dashboard_bloc.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object?> get props => [];
}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final DashboardData data;

  const DashboardLoaded(this.data);

  @override
  List<Object?> get props => [data];
}

class MembersLoaded extends DashboardState {
  final List<DashboardMember> members;

  const MembersLoaded(this.members);

  @override
  List<Object?> get props => [members];
}

class MemberDetailsLoaded extends DashboardState {
  final DashboardMember member;

  const MemberDetailsLoaded(this.member);

  @override
  List<Object?> get props => [member];
}

class DashboardError extends DashboardState {
  final String message;

  const DashboardError(this.message);

  @override
  List<Object?> get props => [message];
}

class DashboardAuthError extends DashboardState {
  final String message;

  const DashboardAuthError(this.message);

  @override
  List<Object?> get props => [message];
}

class DashboardNetworkError extends DashboardState {
  final String message;

  const DashboardNetworkError(this.message);

  @override
  List<Object?> get props => [message];
}

class MemberNotFound extends DashboardState {
  final String message;

  const MemberNotFound(this.message);

  @override
  List<Object?> get props => [message];
}
