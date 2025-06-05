import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/usecases/usecase.dart';
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
    final result = await getAssessments(NoParams());
    result.fold(
      (failure) => emit(AssessmentError(failure.message)),
      (assessments) => emit(AssessmentsLoaded(assessments)),
    );
  }

  Future<void> _onLoadAssessmentById(
      LoadAssessmentById event, Emitter<AssessmentState> emit) async {
    emit(AssessmentLoading());
    final result = await getAssessmentById(Params(id: event.id));
    result.fold(
      (failure) => emit(AssessmentError(failure.message)),
      (assessment) => assessment != null
          ? emit(AssessmentLoaded(assessment))
          : emit(const AssessmentError('Assessment not found')),
    );
  }

  Future<void> _onCreateAssessment(
      CreateAssessment event, Emitter<AssessmentState> emit) async {
    emit(AssessmentLoading());
    final result =
        await saveAssessment(SaveParams(assessment: event.assessment));
    result.fold(
      (failure) => emit(AssessmentError(failure.message)),
      (_) => emit(AssessmentCreated()),
    );
  }

  Future<void> _onUpdateAssessment(
      UpdateAssessmentEvent event, Emitter<AssessmentState> emit) async {
    emit(AssessmentLoading());
    final result =
        await updateAssessment(UpdateParams(assessment: event.assessment));
    result.fold(
      (failure) => emit(AssessmentError(failure.message)),
      (_) => emit(AssessmentUpdated()),
    );
  }

  Future<void> _onDeleteAssessment(
      DeleteAssessmentEvent event, Emitter<AssessmentState> emit) async {
    emit(AssessmentLoading());
    final result = await deleteAssessment(DeleteParams(id: event.id));
    result.fold(
      (failure) => emit(AssessmentError(failure.message)),
      (_) => emit(AssessmentDeleted()),
    );
  }
}
