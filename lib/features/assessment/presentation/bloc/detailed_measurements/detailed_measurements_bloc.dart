import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/user_assessment.dart';
import '../../../domain/entities/body_measurements.dart';
import '../../../domain/entities/vital_signs.dart';
import '../../../domain/entities/cardio_fitness.dart';
import '../../../domain/entities/muscular_endurance.dart';
import '../../../domain/entities/flexibility_tests.dart';
import '../../../domain/usecases/save_assessment.dart';
import '../../../../../core/error/failures.dart';

part 'detailed_measurements_event.dart';
part 'detailed_measurements_state.dart';

class DetailedMeasurementsBloc
    extends Bloc<DetailedMeasurementsEvent, DetailedMeasurementsState> {
  final SaveAssessment saveAssessment;

  DetailedMeasurementsBloc({
    required this.saveAssessment,
  }) : super(DetailedMeasurementsInitial()) {
    on<SaveDetailedMeasurements>(_onSaveDetailedMeasurements);
  }

  Future<void> _onSaveDetailedMeasurements(
    SaveDetailedMeasurements event,
    Emitter<DetailedMeasurementsState> emit,
  ) async {
    emit(DetailedMeasurementsSaving());

    final bodyMeasurements = BodyMeasurements(
      height: event.height,
      weight: event.weight,
      arms: event.arms,
      calf: event.calf,
      forearm: event.forearm,
      midThigh: event.midThigh,
      chest: event.chest,
      waist: event.waist,
      hips: event.hips,
      neck: event.neck,
    );

    final assessment = UserAssessment(
      name: 'Detailed Measurements Assessment ${event.date}',
      vitalSigns: const VitalSigns(
        bloodPressure: '',
        restingHeartRate: 0,
        bpCategory: '',
      ),
      bodyMeasurements: bodyMeasurements,
      cardioFitness: const CardioFitness(
        vo2Max: 0,
        rockportTestResult: '',
        ymcaStepTestResult: '',
        ymcaHeartRate: 0,
      ),
      muscularEndurance: const MuscularEndurance(
        pushUps: 0,
        pushUpType: '',
        squats: 0,
        squatType: '',
        pullUps: 0,
      ),
      flexibilityTests: const FlexibilityTests(
        quadriceps: false,
        hamstring: false,
        hipFlexors: false,
        shoulderMobility: false,
        sitAndReach: false,
      ),
    );

    final result = await saveAssessment(SaveParams(assessment: assessment));
    result.fold(
      (failure) {
        if (failure is ServerFailure) {
          emit(DetailedMeasurementsError('Server error: ${failure.message}'));
        } else if (failure is NetworkFailure) {
          emit(DetailedMeasurementsError('Network error: ${failure.message}'));
        } else {
          emit(DetailedMeasurementsError(failure.message));
        }
      },
      (_) => emit(DetailedMeasurementsSaved()),
    );
  }
}
