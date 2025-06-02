import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wildfit_coach/features/assessment/domain/entities/body_measurements.dart';
import 'package:wildfit_coach/features/assessment/domain/entities/flexibility_tests.dart';
import 'package:wildfit_coach/features/assessment/domain/entities/muscular_endurance.dart';
import 'package:wildfit_coach/features/assessment/domain/entities/vital_signs.dart';
import '../../../domain/entities/user_assessment.dart';
import '../../../domain/entities/cardio_fitness.dart';
import '../../../domain/usecases/save_assessment.dart';

part 'cardio_fitness_event.dart';
part 'cardio_fitness_state.dart';

class CardioFitnessBloc extends Bloc<CardioFitnessEvent, CardioFitnessState> {
  final SaveAssessment saveAssessment;

  CardioFitnessBloc({
    required this.saveAssessment,
  }) : super(const CardioFitnessInitial()) {
    on<UpdateRockportCategory>(_onUpdateRockportCategory);
    on<UpdateYmcaCategory>(_onUpdateYmcaCategory);
    on<SaveCardioFitness>(_onSaveCardioFitness);
  }

  void _onUpdateRockportCategory(
    UpdateRockportCategory event,
    Emitter<CardioFitnessState> emit,
  ) {
    if (state is CardioFitnessInitial) {
      emit((state as CardioFitnessInitial).copyWith(
        rockportFitnessCategory: event.category,
      ));
    }
  }

  void _onUpdateYmcaCategory(
    UpdateYmcaCategory event,
    Emitter<CardioFitnessState> emit,
  ) {
    if (state is CardioFitnessInitial) {
      emit((state as CardioFitnessInitial).copyWith(
        ymcaFitnessCategory: event.category,
      ));
    }
  }

  Future<void> _onSaveCardioFitness(
    SaveCardioFitness event,
    Emitter<CardioFitnessState> emit,
  ) async {
    emit(CardioFitnessSaving());
    try {
      final cardioFitness = CardioFitness(
        vo2Max: event.vo2max,
        rockportTestResult: event.rockportFitnessCategory,
        ymcaStepTestResult: event.ymcaFitnessCategory,
        ymcaHeartRate: event.ymcaHeartRate,
      );

      final assessment = UserAssessment(
        name: 'Cardio Fitness Assessment ${event.date}',
        vitalSigns: event.vitalSigns,
        bodyMeasurements: event.bodyMeasurements,
        cardioFitness: cardioFitness,
        muscularEndurance: event.muscularEndurance,
        flexibilityTests: event.flexibilityTests,
      );

      await saveAssessment(assessment);
      emit(CardioFitnessSaved());
    } catch (e) {
      emit(CardioFitnessError(e.toString()));
    }
  }
}
