import 'package:wildfit_coach/features/members/domain/models/activity.dart';

import '../../domain/models/member.dart';

class MemberRepository {
  Future<Member> getMember(String id) async {
    // TODO: Implement actual API call
    // This is a mock implementation
    return Member(
      id: id,
      name: 'John Doe',
      email: 'john@example.com',
      joinedAt: DateTime.now().subtract(const Duration(days: 30)),
      plan: 'Premium',
      hasWorkoutPlan: true,
      hasNutritionPlan: true,
      membershipExpiryDate: DateTime.now().add(const Duration(days: 30)),
      lastCheckIn: DateTime.now().subtract(const Duration(days: 1)),
      daysPresent: 2,
      todayActivities: [
        Activity(
            name: 'Workout', type: ActivityType.workout, time: DateTime.now()),
      ],
      height: 175.0,
      weight: 70.5,
    );
  }

  Future<void> updateMember(Member member) async {
    // TODO: Implement actual API call
  }
}
