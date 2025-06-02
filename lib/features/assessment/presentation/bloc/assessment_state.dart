part of 'assessment_bloc.dart';

abstract class AssessmentState extends Equatable {
  const AssessmentState();

  @override
  List<Object> get props => [];
}

class AssessmentInitial extends AssessmentState {}

class AssessmentLoading extends AssessmentState {}

class AssessmentsLoaded extends AssessmentState {
  final List<UserAssessment> assessments;

  const AssessmentsLoaded(this.assessments);

  @override
  List<Object> get props => [assessments];
}

class AssessmentLoaded extends AssessmentState {
  final UserAssessment assessment;

  const AssessmentLoaded(this.assessment);

  @override
  List<Object> get props => [assessment];
}

class AssessmentCreated extends AssessmentState {}

class AssessmentUpdated extends AssessmentState {}

class AssessmentDeleted extends AssessmentState {}

class AssessmentError extends AssessmentState {
  final String message;

  const AssessmentError(this.message);

  @override
  List<Object> get props => [message];
}
