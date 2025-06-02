part of 'assessment_bloc.dart';

abstract class AssessmentEvent extends Equatable {
  const AssessmentEvent();

  @override
  List<Object> get props => [];
}

class LoadAssessments extends AssessmentEvent {}

class LoadAssessmentById extends AssessmentEvent {
  final String id;

  const LoadAssessmentById(this.id);

  @override
  List<Object> get props => [id];
}

class CreateAssessment extends AssessmentEvent {
  final UserAssessment assessment;

  const CreateAssessment(this.assessment);

  @override
  List<Object> get props => [assessment];
}

class UpdateAssessmentEvent extends AssessmentEvent {
  final UserAssessment assessment;

  const UpdateAssessmentEvent(this.assessment);

  @override
  List<Object> get props => [assessment];
}

class DeleteAssessmentEvent extends AssessmentEvent {
  final String id;

  const DeleteAssessmentEvent(this.id);

  @override
  List<Object> get props => [id];
}
