import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/user_assessment.dart';
import '../../../domain/entities/vital_signs.dart';
import '../../../domain/entities/body_measurements.dart';
import '../../../domain/entities/cardio_fitness.dart';
import '../../../domain/entities/muscular_endurance.dart';
import '../../../domain/entities/flexibility_tests.dart';
import '../../../domain/usecases/save_assessment.dart';
import '../../../../../core/error/failures.dart';

part 'blood_pressure_event.dart';
part 'blood_pressure_state.dart';

class BloodPressureBloc extends Bloc<BloodPressureEvent, BloodPressureState> {
  final SaveAssessment saveAssessment;

  BloodPressureBloc({
    required this.saveAssessment,
  }) : super(const BloodPressureInitial()) {
    on<UpdateBPCategory>(_onUpdateBPCategory);
    on<SaveBloodPressure>(_onSaveBloodPressure);
  }

  void _onUpdateBPCategory(
    UpdateBPCategory event,
    Emitter<BloodPressureState> emit,
  ) {
    if (state is BloodPressureInitial) {
      emit((state as BloodPressureInitial).copyWith(
        bpCategory: event.category,
      ));
    }
  }

  Future<void> _onSaveBloodPressure(
    SaveBloodPressure event,
    Emitter<BloodPressureState> emit,
  ) async {
    emit(BloodPressureSaving());

    final vitalSigns = VitalSigns(
      bloodPressure: '${event.systolic}/${event.diastolic}',
      restingHeartRate: event.restingHeartRate,
      bpCategory: event.bpCategory,
    );

    final assessment = UserAssessment(
      name: 'Blood Pressure Assessment ${event.date}',
      vitalSigns: vitalSigns,
      bodyMeasurements: const BodyMeasurements(
        height: 0,
        weight: 0,
        chest: 0,
        waist: 0,
        hips: 0,
        arms: 0,
        neck: 0,
        forearm: 0,
        calf: 0,
        midThigh: 0,
      ),
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
          emit(BloodPressureError('Server error: ${failure.message}'));
        } else if (failure is NetworkFailure) {
          emit(BloodPressureError('Network error: ${failure.message}'));
        } else {
          emit(BloodPressureError(failure.message));
        }
      },
      (_) => emit(BloodPressureSaved()),
    );
  }
}
