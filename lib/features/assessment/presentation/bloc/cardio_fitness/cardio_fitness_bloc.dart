import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/user_assessment.dart';
import '../../../domain/entities/cardio_fitness.dart';
import '../../../domain/entities/vital_signs.dart';
import '../../../domain/usecases/save_assessment.dart';
import '../../../data/models/body_measurements_model.dart';
import '../../../data/models/muscular_endurance_model.dart';
import '../../../data/models/flexibility_tests_model.dart';

part 'cardio_fitness_event.dart';
part 'cardio_fitness_state.dart';

class CardioFitnessBloc extends Bloc<CardioFitnessEvent, CardioFitnessState> {
  final SaveAssessment saveAssessment;
  final String memberId;

  CardioFitnessBloc({
    required this.saveAssessment,
    required this.memberId,
  }) : super(CardioFitnessInitial()) {
    on<SaveCardioFitness>(_onSaveCardioFitness);
  }

  Future<void> _onSaveCardioFitness(
    SaveCardioFitness event,
    Emitter<CardioFitnessState> emit,
  ) async {
    emit(CardioFitnessSaving());

    final assessment = UserAssessment(
      id: null,
      name: 'Cardio Fitness Assessment',
      vitalSigns: event.vitalSigns,
      bodyMeasurements: BodyMeasurementsModel.empty(),
      cardioFitness: event.cardioFitness,
      muscularEndurance: MuscularEnduranceModel.empty(),
      flexibilityTests: FlexibilityTestsModel.empty(),
      createdAt: null,
      updatedAt: null,
    );

    final result = await saveAssessment(SaveParams(assessment: assessment));
    result.fold(
      (failure) => emit(CardioFitnessError(failure.message)),
      (_) => emit(CardioFitnessSaved()),
    );
  }
}
