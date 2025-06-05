import 'package:equatable/equatable.dart';
import '../../../domain/entities/nutrition_plan.dart';

abstract class NutritionPlanState extends Equatable {
  const NutritionPlanState();

  @override
  List<Object> get props => [];
}

class NutritionPlanInitial extends NutritionPlanState {}

class NutritionPlanLoading extends NutritionPlanState {}

class NutritionPlanLoaded extends NutritionPlanState {
  final NutritionPlan plan;

  const NutritionPlanLoaded({required this.plan});

  @override
  List<Object> get props => [plan];
}

class NutritionPlanError extends NutritionPlanState {
  final String message;

  const NutritionPlanError({required this.message});

  @override
  List<Object> get props => [message];
}
