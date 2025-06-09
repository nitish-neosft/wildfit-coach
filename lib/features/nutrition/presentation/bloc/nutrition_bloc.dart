import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/nutrition_plan.dart';
import '../../domain/repositories/nutrition_repository.dart';

part 'nutrition_event.dart';
part 'nutrition_state.dart';

class NutritionBloc extends Bloc<NutritionEvent, NutritionState> {
  final NutritionRepository repository;

  NutritionBloc({required this.repository}) : super(NutritionInitial()) {
    on<LoadNutritionPlans>(_onLoadNutritionPlans);
    on<LoadMemberNutritionPlans>(_onLoadMemberNutritionPlans);
    on<LoadNutritionPlanById>(_onLoadNutritionPlanById);
    on<CreateNewNutritionPlan>(_onCreateNutritionPlan);
    on<DeleteNutritionPlanEvent>(_onDeleteNutritionPlan);
  }

  Future<void> _onLoadNutritionPlans(
    LoadNutritionPlans event,
    Emitter<NutritionState> emit,
  ) async {
    try {
      emit(NutritionLoading());
      final plans = await repository.getNutritionPlans();
      emit(NutritionPlansLoaded(plans: plans));
    } catch (e) {
      emit(NutritionError(message: e.toString()));
    }
  }

  Future<void> _onLoadMemberNutritionPlans(
    LoadMemberNutritionPlans event,
    Emitter<NutritionState> emit,
  ) async {
    try {
      emit(NutritionLoading());
      final plans = await repository.getMemberNutritionPlans(event.memberId);
      emit(NutritionPlansLoaded(plans: plans));
    } catch (e) {
      emit(NutritionError(message: e.toString()));
    }
  }

  Future<void> _onLoadNutritionPlanById(
    LoadNutritionPlanById event,
    Emitter<NutritionState> emit,
  ) async {
    try {
      emit(NutritionLoading());
      final plan = await repository.getNutritionPlanById(event.id);
      if (plan != null) {
        emit(NutritionPlanLoaded(plan: plan));
      } else {
        emit(const NutritionError(message: 'Nutrition plan not found'));
      }
    } catch (e) {
      emit(NutritionError(message: e.toString()));
    }
  }

  Future<void> _onCreateNutritionPlan(
    CreateNewNutritionPlan event,
    Emitter<NutritionState> emit,
  ) async {
    try {
      emit(NutritionLoading());
      await repository.createNutritionPlan(event.nutritionPlan);
      emit(NutritionPlanCreated(plan: event.nutritionPlan));
      final plans = await repository.getNutritionPlans();
      emit(NutritionPlansLoaded(plans: plans));
    } catch (e) {
      emit(NutritionError(message: e.toString()));
    }
  }

  Future<void> _onDeleteNutritionPlan(
    DeleteNutritionPlanEvent event,
    Emitter<NutritionState> emit,
  ) async {
    try {
      emit(NutritionLoading());
      await repository.deleteNutritionPlan(event.planId);
      emit(NutritionPlanDeleted());
      final plans = await repository.getMemberNutritionPlans(event.memberId);
      emit(NutritionPlansLoaded(plans: plans));
    } catch (e) {
      emit(NutritionError(message: e.toString()));
    }
  }
}
