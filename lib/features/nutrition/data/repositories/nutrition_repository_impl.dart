import '../../domain/entities/nutrition_plan.dart';
import '../../domain/entities/member_nutrition_status.dart';
import '../../domain/repositories/nutrition_repository.dart';
import '../../../members/domain/repositories/member_repository.dart';
import '../../../members/domain/entities/member.dart';
import '../../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';

class NutritionRepositoryImpl implements NutritionRepository {
  final List<NutritionPlan> _plans = [
    // Add some sample data
    NutritionPlan(
      id: '1',
      memberId: 'member1',
      name: 'Weight Loss Plan',
      description: 'A balanced plan for healthy weight loss',
      type: NutritionPlanType.weightLoss,
      isActive: true,
      startDate: DateTime.now(),
      dailyCalorieTarget: 2000,
      macroTargets: {
        'protein': 150,
        'carbs': 200,
        'fats': 70,
      },
      dietaryRestrictions: ['Gluten-free', 'Dairy-free'],
      allowedFoods: ['Chicken', 'Fish', 'Vegetables', 'Rice'],
      excludedFoods: ['Bread', 'Pasta'],
    ),
  ];

  final MemberRepository _memberRepository;

  NutritionRepositoryImpl({
    required MemberRepository memberRepository,
  }) : _memberRepository = memberRepository;

  @override
  Future<List<NutritionPlan>> getNutritionPlans() async {
    return _plans;
  }

  @override
  Future<List<NutritionPlan>> getMemberNutritionPlans(String memberId) async {
    return _plans.where((plan) => plan.memberId == memberId).toList();
  }

  @override
  Future<NutritionPlan?> getNutritionPlanById(String id) async {
    try {
      return _plans.firstWhere((plan) => plan.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> createNutritionPlan(NutritionPlan plan) async {
    _plans.add(plan);
  }

  @override
  Future<void> updateNutritionPlan(NutritionPlan plan) async {
    final index = _plans.indexWhere((p) => p.id == plan.id);
    if (index >= 0) {
      _plans[index] = plan;
    }
  }

  @override
  Future<void> deleteNutritionPlan(String id) async {
    _plans.removeWhere((plan) => plan.id == id);
  }

  @override
  Future<List<MemberNutritionStatus>> getMembersNeedingPlans() async {
    final membersResult = await _memberRepository.getMembers();

    if (membersResult.isLeft()) {
      return []; // Return empty list on failure
    }

    final members = membersResult.getOrElse(() => []);
    final List<MemberNutritionStatus> membersNeedingPlans = [];

    for (final member in members) {
      final memberPlans = await getMemberNutritionPlans(member.id);
      final activePlan = memberPlans.where((plan) => plan.isActive).toList();
      final bool needsNewPlan = activePlan.isEmpty;

      if (needsNewPlan) {
        membersNeedingPlans.add(
          MemberNutritionStatus(
            memberId: member.id,
            memberName: member.name,
            profileImage: member.avatar,
            needsNewPlan: true,
            lastPlanEndDate: memberPlans.isNotEmpty
                ? memberPlans
                    .map((p) => p.endDate ?? p.startDate)
                    .reduce((a, b) => a.isAfter(b) ? a : b)
                : null,
          ),
        );
      }
    }

    return membersNeedingPlans;
  }

  @override
  Future<void> assignNutritionPlan(String planId, String memberId) async {
    final planIndex = _plans.indexWhere((p) => p.id == planId);
    if (planIndex >= 0) {
      final plan = _plans[planIndex];
      _plans[planIndex] = plan.copyWith(
        memberId: memberId,
        isActive: true,
      );
    }
  }
}
