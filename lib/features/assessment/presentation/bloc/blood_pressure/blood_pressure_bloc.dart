import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/user_assessment.dart';
import '../../../domain/entities/vital_signs.dart';
import '../../../domain/usecases/save_assessment.dart';
import '../../../data/models/body_measurements_model.dart';
import '../../../data/models/cardio_fitness_model.dart';
import '../../../data/models/muscular_endurance_model.dart';
import '../../../data/models/flexibility_tests_model.dart';

part 'blood_pressure_event.dart';
part 'blood_pressure_state.dart';

class BloodPressureBloc extends Bloc<BloodPressureEvent, BloodPressureState> {
  final SaveAssessment saveAssessment;
  final String memberId;

  BloodPressureBloc({
    required this.saveAssessment,
    required this.memberId,
  }) : super(const BloodPressureInitial(
          bpCategory: '',
          systolic: 0,
          diastolic: 0,
          restingHeartRate: 0,
        )) {
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
      id: null,
      name: 'Blood Pressure Assessment',
      vitalSigns: vitalSigns,
      bodyMeasurements: BodyMeasurementsModel.empty(),
      cardioFitness: CardioFitnessModel.empty(),
      muscularEndurance: MuscularEnduranceModel.empty(),
      flexibilityTests: FlexibilityTestsModel.empty(),
      createdAt: null,
      updatedAt: null,
    );

    final result = await saveAssessment(SaveParams(assessment: assessment));
    result.fold(
      (failure) => emit(BloodPressureError(failure.message)),
      (_) => emit(BloodPressureSaved()),
    );
  }
}
