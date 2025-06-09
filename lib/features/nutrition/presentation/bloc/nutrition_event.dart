part of 'nutrition_bloc.dart';

abstract class NutritionEvent extends Equatable {
  const NutritionEvent();

  @override
  List<Object> get props => [];
}

class LoadNutritionPlans extends NutritionEvent {
  const LoadNutritionPlans();
}

class LoadMemberNutritionPlans extends NutritionEvent {
  final String memberId;

  const LoadMemberNutritionPlans(this.memberId);

  @override
  List<Object> get props => [memberId];
}

class LoadNutritionPlanById extends NutritionEvent {
  final String id;

  const LoadNutritionPlanById(this.id);

  @override
  List<Object> get props => [id];
}

class CreateNewNutritionPlan extends NutritionEvent {
  final NutritionPlan nutritionPlan;

  const CreateNewNutritionPlan({required this.nutritionPlan});

  @override
  List<Object> get props => [nutritionPlan];
}

class DeleteNutritionPlanEvent extends NutritionEvent {
  final String planId;
  final String memberId;

  const DeleteNutritionPlanEvent({
    required this.planId,
    required this.memberId,
  });

  @override
  List<Object> get props => [planId, memberId];
}
