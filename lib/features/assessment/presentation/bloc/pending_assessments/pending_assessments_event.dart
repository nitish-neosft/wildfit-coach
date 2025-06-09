part of 'pending_assessments_bloc.dart';

abstract class PendingAssessmentsEvent extends Equatable {
  const PendingAssessmentsEvent();

  @override
  List<Object> get props => [];
}

class LoadPendingAssessments extends PendingAssessmentsEvent {}
