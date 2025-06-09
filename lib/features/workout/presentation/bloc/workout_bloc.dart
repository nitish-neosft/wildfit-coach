import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/workout_plan.dart';
import '../../domain/usecases/get_workout_plans.dart';
import '../../domain/usecases/get_workout_plan_by_id.dart';
import '../../domain/usecases/get_member_workout_plans.dart';
import '../../domain/usecases/create_workout_plan.dart';
import '../../../../core/usecases/usecase.dart';

part 'workout_event.dart';
part 'workout_state.dart';

class WorkoutBloc extends Bloc<WorkoutEvent, WorkoutState> {
  final GetWorkoutPlans getWorkoutPlans;
  final GetWorkoutPlanById getWorkoutPlanById;
  final GetMemberWorkoutPlans getMemberWorkoutPlans;
  final CreateWorkoutPlan createWorkoutPlan;

  WorkoutBloc({
    required this.getWorkoutPlans,
    required this.getWorkoutPlanById,
    required this.getMemberWorkoutPlans,
    required this.createWorkoutPlan,
  }) : super(WorkoutInitial()) {
    on<LoadWorkoutPlans>(_onLoadWorkoutPlans);
    on<LoadWorkoutPlanById>(_onLoadWorkoutPlanById);
    on<LoadMemberWorkoutPlans>(_onLoadMemberWorkoutPlans);
    on<CreateNewWorkoutPlan>(_onCreateNewWorkoutPlan);
  }

  Future<void> _onLoadWorkoutPlans(
    LoadWorkoutPlans event,
    Emitter<WorkoutState> emit,
  ) async {
    emit(WorkoutLoading());
    final result = await getWorkoutPlans(NoParams());
    result.fold(
      (failure) => emit(WorkoutError(message: failure.message)),
      (workoutPlans) => emit(WorkoutPlansLoaded(workoutPlans: workoutPlans)),
    );
  }

  Future<void> _onLoadWorkoutPlanById(
    LoadWorkoutPlanById event,
    Emitter<WorkoutState> emit,
  ) async {
    emit(WorkoutLoading());
    final result = await getWorkoutPlanById(Params(id: event.id));
    result.fold(
      (failure) => emit(WorkoutError(message: failure.message)),
      (workoutPlan) => emit(WorkoutPlanLoaded(workoutPlan: workoutPlan)),
    );
  }

  Future<void> _onLoadMemberWorkoutPlans(
    LoadMemberWorkoutPlans event,
    Emitter<WorkoutState> emit,
  ) async {
    emit(WorkoutLoading());
    final result = await getMemberWorkoutPlans(event.memberId);
    result.fold(
      (failure) => emit(WorkoutError(message: failure.message)),
      (workoutPlans) => emit(WorkoutPlansLoaded(workoutPlans: workoutPlans)),
    );
  }

  Future<void> _onCreateNewWorkoutPlan(
    CreateNewWorkoutPlan event,
    Emitter<WorkoutState> emit,
  ) async {
    emit(WorkoutLoading());
    final result = await createWorkoutPlan(event.workoutPlan);
    result.fold(
      (failure) => emit(WorkoutError(message: failure.message)),
      (workoutPlan) => emit(WorkoutPlanCreated(workoutPlan)),
    );
  }
}
