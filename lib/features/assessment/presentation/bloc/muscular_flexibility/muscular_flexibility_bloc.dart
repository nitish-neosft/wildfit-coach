import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/user_assessment.dart';
import '../../../domain/entities/muscular_endurance.dart';
import '../../../domain/entities/flexibility_tests.dart';
import '../../../domain/entities/vital_signs.dart';
import '../../../domain/usecases/save_assessment.dart';
import '../../../data/models/body_measurements_model.dart';
import '../../../data/models/cardio_fitness_model.dart';

part 'muscular_flexibility_event.dart';
part 'muscular_flexibility_state.dart';

class MuscularFlexibilityBloc
    extends Bloc<MuscularFlexibilityEvent, MuscularFlexibilityState> {
  final SaveAssessment saveAssessment;
  final String memberId;

  MuscularFlexibilityBloc({
    required this.saveAssessment,
    required this.memberId,
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
      id: null,
      name: 'Muscular Flexibility Assessment',
      vitalSigns: event.vitalSigns,
      bodyMeasurements: BodyMeasurementsModel.empty(),
      cardioFitness: CardioFitnessModel.empty(),
      muscularEndurance: muscularEndurance,
      flexibilityTests: flexibilityTests,
      createdAt: null,
      updatedAt: null,
    );

    final result = await saveAssessment(SaveParams(assessment: assessment));
    result.fold(
      (failure) => emit(MuscularFlexibilityError(failure.message)),
      (_) => emit(MuscularFlexibilitySaved()),
    );
  }
}
