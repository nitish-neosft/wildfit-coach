import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/nutrition_plan.dart';
import '../../../domain/entities/meal.dart';
import '../../../domain/entities/supplement.dart';
import 'nutrition_plan_event.dart';
import 'nutrition_plan_state.dart';

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
            type: 'Breakfast',
            calories: 400,
            protein: 30,
            carbs: 45,
            fats: 15,
            ingredients: ['Oatmeal', 'Banana', 'Protein Shake'],
            instructions: {
              'steps': [
                'Mix oatmeal with water',
                'Add sliced banana',
                'Prepare protein shake separately'
              ]
            },
          ),
          Meal(
            id: '2',
            name: 'Mid-Morning Snack',
            type: 'Snack',
            calories: 200,
            protein: 15,
            carbs: 20,
            fats: 10,
            ingredients: ['Greek Yogurt', 'Almonds'],
            instructions: {
              'steps': ['Mix Greek yogurt with almonds', 'Add honey if desired']
            },
          ),
        ],
        supplements: [
          Supplement(
            id: '1',
            name: 'Whey Protein',
            type: 'Protein',
            dosage: '30g',
            frequency: 'Post-workout',
            instructions: {
              'timing': 'Within 30 minutes after workout',
              'notes': 'Mix with water or milk'
            },
          ),
          Supplement(
            id: '2',
            name: 'Multivitamin',
            type: 'Vitamin',
            dosage: '1 tablet',
            frequency: 'Daily',
            instructions: {
              'timing': 'Morning with breakfast',
              'notes': 'Take with food'
            },
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
