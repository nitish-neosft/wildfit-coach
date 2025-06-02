import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/user_assessment.dart';
import '../../domain/usecases/get_assessments.dart';
import '../../domain/usecases/get_assessment_by_id.dart';
import '../../domain/usecases/save_assessment.dart';
import '../../domain/usecases/update_assessment.dart';
import '../../domain/usecases/delete_assessment.dart';

part 'assessment_event.dart';
part 'assessment_state.dart';

class AssessmentBloc extends Bloc<AssessmentEvent, AssessmentState> {
  final GetAssessments getAssessments;
  final GetAssessmentById getAssessmentById;
  final SaveAssessment saveAssessment;
  final UpdateAssessment updateAssessment;
  final DeleteAssessment deleteAssessment;

  AssessmentBloc({
    required this.getAssessments,
    required this.getAssessmentById,
    required this.saveAssessment,
    required this.updateAssessment,
    required this.deleteAssessment,
  }) : super(AssessmentInitial()) {
    on<LoadAssessments>(_onLoadAssessments);
    on<LoadAssessmentById>(_onLoadAssessmentById);
    on<CreateAssessment>(_onCreateAssessment);
    on<UpdateAssessmentEvent>(_onUpdateAssessment);
    on<DeleteAssessmentEvent>(_onDeleteAssessment);
  }

  Future<void> _onLoadAssessments(
      LoadAssessments event, Emitter<AssessmentState> emit) async {
    emit(AssessmentLoading());
    try {
      final assessments = await getAssessments();
      emit(AssessmentsLoaded(assessments));
    } catch (e) {
      emit(AssessmentError(e.toString()));
    }
  }

  Future<void> _onLoadAssessmentById(
      LoadAssessmentById event, Emitter<AssessmentState> emit) async {
    emit(AssessmentLoading());
    try {
      final assessment = await getAssessmentById(event.id);
      if (assessment != null) {
        emit(AssessmentLoaded(assessment));
      } else {
        emit(const AssessmentError('Assessment not found'));
      }
    } catch (e) {
      emit(AssessmentError(e.toString()));
    }
  }

  Future<void> _onCreateAssessment(
      CreateAssessment event, Emitter<AssessmentState> emit) async {
    emit(AssessmentLoading());
    try {
      await saveAssessment(event.assessment);
      emit(AssessmentCreated());
    } catch (e) {
      emit(AssessmentError(e.toString()));
    }
  }

  Future<void> _onUpdateAssessment(
      UpdateAssessmentEvent event, Emitter<AssessmentState> emit) async {
    emit(AssessmentLoading());
    try {
      await updateAssessment(event.assessment);
      emit(AssessmentUpdated());
    } catch (e) {
      emit(AssessmentError(e.toString()));
    }
  }

  Future<void> _onDeleteAssessment(
      DeleteAssessmentEvent event, Emitter<AssessmentState> emit) async {
    emit(AssessmentLoading());
    try {
      await deleteAssessment(event.id);
      emit(AssessmentDeleted());
    } catch (e) {
      emit(AssessmentError(e.toString()));
    }
  }
}
