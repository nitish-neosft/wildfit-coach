import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/user_assessment.dart';
import '../../../domain/entities/body_measurements.dart';
import '../../../domain/entities/vital_signs.dart';
import '../../../domain/usecases/save_assessment.dart';
import '../../../data/models/cardio_fitness_model.dart';
import '../../../data/models/muscular_endurance_model.dart';
import '../../../data/models/flexibility_tests_model.dart';

part 'detailed_measurements_event.dart';
part 'detailed_measurements_state.dart';

class DetailedMeasurementsBloc
    extends Bloc<DetailedMeasurementsEvent, DetailedMeasurementsState> {
  final SaveAssessment saveAssessment;
  final String memberId;

  DetailedMeasurementsBloc({
    required this.saveAssessment,
    required this.memberId,
  }) : super(DetailedMeasurementsInitial()) {
    on<SaveDetailedMeasurements>(_onSaveDetailedMeasurements);
  }

  Future<void> _onSaveDetailedMeasurements(
    SaveDetailedMeasurements event,
    Emitter<DetailedMeasurementsState> emit,
  ) async {
    emit(DetailedMeasurementsSaving());

    final assessment = UserAssessment(
      id: null,
      name: 'Detailed Measurements Assessment',
      vitalSigns: event.vitalSigns,
      bodyMeasurements: event.bodyMeasurements,
      cardioFitness: CardioFitnessModel.empty(),
      muscularEndurance: MuscularEnduranceModel.empty(),
      flexibilityTests: FlexibilityTestsModel.empty(),
      createdAt: null,
      updatedAt: null,
    );

    final result = await saveAssessment(SaveParams(assessment: assessment));
    result.fold(
      (failure) => emit(DetailedMeasurementsError(failure.message)),
      (_) => emit(DetailedMeasurementsSaved()),
    );
  }
}
