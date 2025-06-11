import 'package:equatable/equatable.dart';

class MemberNutritionStatus extends Equatable {
  final String memberId;
  final String memberName;
  final String? profileImage;
  final DateTime? lastPlanEndDate;
  final bool needsNewPlan;
  final String? currentPlanId;

  const MemberNutritionStatus({
    required this.memberId,
    required this.memberName,
    this.profileImage,
    this.lastPlanEndDate,
    required this.needsNewPlan,
    this.currentPlanId,
  });

  @override
  List<Object?> get props => [
        memberId,
        memberName,
        profileImage,
        lastPlanEndDate,
        needsNewPlan,
        currentPlanId,
      ];
}
