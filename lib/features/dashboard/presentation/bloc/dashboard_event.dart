part of 'dashboard_bloc.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object?> get props => [];
}

class LoadDashboard extends DashboardEvent {}

class LoadMembers extends DashboardEvent {}

class LoadMemberDetails extends DashboardEvent {
  final String memberId;

  const LoadMemberDetails(this.memberId);

  @override
  List<Object?> get props => [memberId];
}
