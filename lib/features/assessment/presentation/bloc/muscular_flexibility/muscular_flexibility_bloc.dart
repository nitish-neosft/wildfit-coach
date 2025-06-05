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

part 'muscular_flexibility_event.dart';
part 'muscular_flexibility_state.dart';

class MuscularFlexibilityBloc
    extends Bloc<MuscularFlexibilityEvent, MuscularFlexibilityState> {
  final SaveAssessment saveAssessment;

  MuscularFlexibilityBloc({
    required this.saveAssessment,
  }) : super(const MuscularFlexibilityInitial()) {
    on<UpdatePushUpType>(_onUpdatePushUpType);
    on<UpdateSquatType>(_onUpdateSquatType);
    on<UpdateFlexibilityTest>(_onUpdateFlexibilityTest);
    on<SaveMuscularFlexibility>(_onSaveMuscularFlexibility);
  }

  void _onUpdatePushUpType(
    UpdatePushUpType event,
    Emitter<MuscularFlexibilityState> emit,
  ) {
    if (state is MuscularFlexibilityInitial) {
      emit((state as MuscularFlexibilityInitial).copyWith(
        pushUpType: event.type,
      ));
    }
  }

  void _onUpdateSquatType(
    UpdateSquatType event,
    Emitter<MuscularFlexibilityState> emit,
  ) {
    if (state is MuscularFlexibilityInitial) {
      emit((state as MuscularFlexibilityInitial).copyWith(
        squatType: event.type,
      ));
    }
  }

  void _onUpdateFlexibilityTest(
    UpdateFlexibilityTest event,
    Emitter<MuscularFlexibilityState> emit,
  ) {
    if (state is MuscularFlexibilityInitial) {
      final currentState = state as MuscularFlexibilityInitial;
      final updatedTests =
          Map<String, bool>.from(currentState.flexibilityTests);
      updatedTests[event.test] = event.passed;

      emit(currentState.copyWith(
        flexibilityTests: updatedTests,
      ));
    }
  }

  Future<void> _onSaveMuscularFlexibility(
    SaveMuscularFlexibility event,
    Emitter<MuscularFlexibilityState> emit,
  ) async {
    emit(MuscularFlexibilitySaving());

    final muscularEndurance = MuscularEndurance(
      pushUps: event.pushUps,
      pushUpType: event.pushUpType,
      squats: event.squats,
      squatType: event.squatType,
      pullUps: event.pullUps,
    );

    final flexibilityTests = FlexibilityTests(
      quadriceps: event.quadricepsPass,
      hamstring: event.hamstringPass,
      hipFlexors: event.hipFlexorsPass,
      shoulderMobility: event.shoulderMobilityPass,
      sitAndReach: event.sitAndReachPass,
    );

    final assessment = UserAssessment(
      name: 'Muscular Flexibility Assessment ${event.date}',
      vitalSigns: const VitalSigns(
        bloodPressure: '',
        restingHeartRate: 0,
        bpCategory: '',
      ),
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
      muscularEndurance: muscularEndurance,
      flexibilityTests: flexibilityTests,
    );

    final result = await saveAssessment(SaveParams(assessment: assessment));
    result.fold(
      (failure) {
        if (failure is ServerFailure) {
          emit(MuscularFlexibilityError('Server error: ${failure.message}'));
        } else if (failure is NetworkFailure) {
          emit(MuscularFlexibilityError('Network error: ${failure.message}'));
        } else {
          emit(MuscularFlexibilityError(failure.message));
        }
      },
      (_) => emit(MuscularFlexibilitySaved()),
    );
  }
}
