part of 'pending_assessments_bloc.dart';

abstract class PendingAssessmentsState extends Equatable {
  const PendingAssessmentsState();

  @override
  List<Object> get props => [];
}

class PendingAssessmentsInitial extends PendingAssessmentsState {}

class PendingAssessmentsLoading extends PendingAssessmentsState {}

class PendingAssessmentsLoaded extends PendingAssessmentsState {
  final List<Member> membersWithPendingAssessments;

  const PendingAssessmentsLoaded(this.membersWithPendingAssessments);

  @override
  List<Object> get props => [membersWithPendingAssessments];
}

class PendingAssessmentsError extends PendingAssessmentsState {
  final String message;

  const PendingAssessmentsError(this.message);

  @override
  List<Object> get props => [message];
}
