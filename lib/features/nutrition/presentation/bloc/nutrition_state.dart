part of 'nutrition_bloc.dart';

abstract class NutritionState extends Equatable {
  const NutritionState();

  @override
  List<Object> get props => [];
}

class NutritionInitial extends NutritionState {}

class NutritionLoading extends NutritionState {}

class NutritionPlansLoaded extends NutritionState {
  final List<NutritionPlan> plans;

  const NutritionPlansLoaded({required this.plans});

  @override
  List<Object> get props => [plans];
}

class NutritionPlanLoaded extends NutritionState {
  final NutritionPlan plan;

  const NutritionPlanLoaded({required this.plan});

  @override
  List<Object> get props => [plan];
}

class NutritionPlanCreated extends NutritionState {
  final NutritionPlan plan;

  const NutritionPlanCreated({required this.plan});

  @override
  List<Object> get props => [plan];
}

class NutritionPlanDeleted extends NutritionState {}

class NutritionError extends NutritionState {
  final String message;

  const NutritionError({required this.message});

  @override
  List<Object> get props => [message];
}

class MembersNeedingPlansLoaded extends NutritionState {
  final List<MemberNutritionStatus> members;

  const MembersNeedingPlansLoaded({required this.members});

  @override
  List<Object> get props => [members];
}

class NutritionPlanAssigned extends NutritionState {
  final String memberId;
  final String planId;

  const NutritionPlanAssigned({
    required this.memberId,
    required this.planId,
  });

  @override
  List<Object> get props => [memberId, planId];
}
