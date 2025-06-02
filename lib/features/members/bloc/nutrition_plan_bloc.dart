import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../domain/models/nutrition_plan.dart';

// Events
abstract class NutritionPlanEvent {}

class LoadNutritionPlan extends NutritionPlanEvent {
  final String memberId;
  final String planId;

  LoadNutritionPlan({required this.memberId, required this.planId});
}

class UpdateNutritionPlan extends NutritionPlanEvent {
  final NutritionPlan plan;

  UpdateNutritionPlan({required this.plan});
}

class AddMeal extends NutritionPlanEvent {
  final Meal meal;

  AddMeal({required this.meal});
}

class UpdateMeal extends NutritionPlanEvent {
  final Meal meal;

  UpdateMeal({required this.meal});
}

class DeleteMeal extends NutritionPlanEvent {
  final String mealId;

  DeleteMeal({required this.mealId});
}

class AddSupplement extends NutritionPlanEvent {
  final Supplement supplement;

  AddSupplement({required this.supplement});
}

class DeleteSupplement extends NutritionPlanEvent {
  final String supplementId;

  DeleteSupplement({required this.supplementId});
}

// States
abstract class NutritionPlanState {}

class NutritionPlanInitial extends NutritionPlanState {}

class NutritionPlanLoading extends NutritionPlanState {}

class NutritionPlanLoaded extends NutritionPlanState {
  final NutritionPlan plan;

  NutritionPlanLoaded({required this.plan});
}

class NutritionPlanError extends NutritionPlanState {
  final String message;

  NutritionPlanError({required this.message});
}

// Bloc
class NutritionPlanBloc extends Bloc<NutritionPlanEvent, NutritionPlanState> {
  NutritionPlanBloc() : super(NutritionPlanInitial()) {
    on<LoadNutritionPlan>(_onLoadNutritionPlan);
    on<UpdateNutritionPlan>(_onUpdateNutritionPlan);
    on<AddMeal>(_onAddMeal);
    on<UpdateMeal>(_onUpdateMeal);
    on<DeleteMeal>(_onDeleteMeal);
    on<AddSupplement>(_onAddSupplement);
    on<DeleteSupplement>(_onDeleteSupplement);
  }

  Future<void> _onLoadNutritionPlan(
    LoadNutritionPlan event,
    Emitter<NutritionPlanState> emit,
  ) async {
    try {
      emit(NutritionPlanLoading());
      // TODO: Load nutrition plan from repository
      final plan = NutritionPlan(
        id: event.planId,
        memberId: event.memberId,
        name: 'Weight Loss Plan',
        type: 'Weight Loss',
        dailyCalories: 2000,
        mealsPerDay: 5,
        durationWeeks: 12,
        currentProtein: 120,
        targetProtein: 150,
        currentCarbs: 200,
        targetCarbs: 250,
        currentFats: 50,
        targetFats: 70,
        meals: [
          Meal(
            id: '1',
            name: 'Breakfast',
            time: const TimeOfDay(hour: 8, minute: 0),
            calories: 400,
            foods: ['Oatmeal', 'Banana', 'Protein Shake'],
          ),
          Meal(
            id: '2',
            name: 'Mid-Morning Snack',
            time: const TimeOfDay(hour: 10, minute: 30),
            calories: 200,
            foods: ['Greek Yogurt', 'Almonds'],
          ),
        ],
        supplements: [
          Supplement(
            id: '1',
            name: 'Whey Protein',
            dosage: '30g',
            timing: 'Post-workout',
          ),
          Supplement(
            id: '2',
            name: 'Multivitamin',
            dosage: '1 tablet',
            timing: 'Morning',
          ),
        ],
      );
      emit(NutritionPlanLoaded(plan: plan));
    } catch (e) {
      emit(NutritionPlanError(message: e.toString()));
    }
  }

  Future<void> _onUpdateNutritionPlan(
    UpdateNutritionPlan event,
    Emitter<NutritionPlanState> emit,
  ) async {
    try {
      emit(NutritionPlanLoading());
      // TODO: Update nutrition plan in repository
      emit(NutritionPlanLoaded(plan: event.plan));
    } catch (e) {
      emit(NutritionPlanError(message: e.toString()));
    }
  }

  Future<void> _onAddMeal(
    AddMeal event,
    Emitter<NutritionPlanState> emit,
  ) async {
    try {
      final currentState = state;
      if (currentState is NutritionPlanLoaded) {
        final updatedPlan = currentState.plan.copyWith(
          meals: [...currentState.plan.meals, event.meal],
        );
        emit(NutritionPlanLoaded(plan: updatedPlan));
      }
    } catch (e) {
      emit(NutritionPlanError(message: e.toString()));
    }
  }

  Future<void> _onUpdateMeal(
    UpdateMeal event,
    Emitter<NutritionPlanState> emit,
  ) async {
    try {
      final currentState = state;
      if (currentState is NutritionPlanLoaded) {
        final updatedMeals = currentState.plan.meals.map((meal) {
          return meal.id == event.meal.id ? event.meal : meal;
        }).toList();
        final updatedPlan = currentState.plan.copyWith(meals: updatedMeals);
        emit(NutritionPlanLoaded(plan: updatedPlan));
      }
    } catch (e) {
      emit(NutritionPlanError(message: e.toString()));
    }
  }

  Future<void> _onDeleteMeal(
    DeleteMeal event,
    Emitter<NutritionPlanState> emit,
  ) async {
    try {
      final currentState = state;
      if (currentState is NutritionPlanLoaded) {
        final updatedMeals = currentState.plan.meals
            .where((meal) => meal.id != event.mealId)
            .toList();
        final updatedPlan = currentState.plan.copyWith(meals: updatedMeals);
        emit(NutritionPlanLoaded(plan: updatedPlan));
      }
    } catch (e) {
      emit(NutritionPlanError(message: e.toString()));
    }
  }

  Future<void> _onAddSupplement(
    AddSupplement event,
    Emitter<NutritionPlanState> emit,
  ) async {
    try {
      final currentState = state;
      if (currentState is NutritionPlanLoaded) {
        final updatedPlan = currentState.plan.copyWith(
          supplements: [...currentState.plan.supplements, event.supplement],
        );
        emit(NutritionPlanLoaded(plan: updatedPlan));
      }
    } catch (e) {
      emit(NutritionPlanError(message: e.toString()));
    }
  }

  Future<void> _onDeleteSupplement(
    DeleteSupplement event,
    Emitter<NutritionPlanState> emit,
  ) async {
    try {
      final currentState = state;
      if (currentState is NutritionPlanLoaded) {
        final updatedSupplements = currentState.plan.supplements
            .where((supplement) => supplement.id != event.supplementId)
            .toList();
        final updatedPlan =
            currentState.plan.copyWith(supplements: updatedSupplements);
        emit(NutritionPlanLoaded(plan: updatedPlan));
      }
    } catch (e) {
      emit(NutritionPlanError(message: e.toString()));
    }
  }
}
