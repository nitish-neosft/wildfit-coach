import 'package:wildfit_coach/features/members/domain/models/activity.dart';

import '../domain/models/member.dart';

class MemberRepository {
  // TODO: Replace with actual API calls
  Future<Member> getMember(String id) async {
    // Add a small delay to simulate network request
    await Future.delayed(const Duration(milliseconds: 500));

    return Member(
      id: id,
      name: 'John Doe',
      email: 'john@example.com',
      joinedAt: DateTime.now().subtract(const Duration(days: 30)),
      plan: 'Premium',
      hasWorkoutPlan: true,
      hasNutritionPlan: true,
      hasAssessment: true,
      assessments: [
        Assessment(
          id: '1',
          date: DateTime.now().subtract(const Duration(days: 2)),
          type: AssessmentType.bloodPressure,
          data: {
            'systolic': 120,
            'diastolic': 80,
            'pulse': 72,
            'restingHeartRate': 68,
            'bpCategory': 'Normal',
          },
        ),
        Assessment(
          id: '2',
          date: DateTime.now().subtract(const Duration(days: 32)),
          type: AssessmentType.bloodPressure,
          data: {
            'systolic': 118,
            'diastolic': 78,
            'pulse': 70,
            'restingHeartRate': 65,
            'bpCategory': 'Normal',
          },
        ),
        Assessment(
          id: '3',
          date: DateTime.now().subtract(const Duration(days: 1)),
          type: AssessmentType.cardioFitness,
          data: {
            'rockportTest': {
              'time': 12.5,
              'distance': 1.6,
              'pulse': 150,
              'vo2max': 42.5,
              'fitnessCategory': 'Good',
            },
            'ymcaStepTest': {
              'heartRate': 120,
              'fitnessCategory': 'Above Average',
            },
          },
        ),
        Assessment(
          id: '4',
          date: DateTime.now().subtract(const Duration(days: 1)),
          type: AssessmentType.muscularFlexibility,
          data: {
            'testResults': {
              'quadriceps': true,
              'hamstring': true,
              'hipFlexors': false,
              'shoulderMobility': true,
              'sitAndReach': true,
            },
          },
        ),
        Assessment(
          id: '5',
          date: DateTime.now().subtract(const Duration(days: 1)),
          type: AssessmentType.detailedMeasurements,
          data: {
            'height': 175.0,
            'weight': 70.5,
            'arms': 32.0,
            'calf': 37.0,
            'forearm': 27.0,
            'midThigh': 55.0,
            'chest': 95.0,
            'waist': 82.0,
            'hips': 92.0,
            'neck': 38.0,
            'bodyFatPercentage': 15.5,
          },
        ),
      ],
      measurements: {
        'Height': '175 cm',
        'Weight': '70.5 kg',
        'BMI': '23.0',
        'Body Fat': '15.5%',
      },
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
    await Future.delayed(const Duration(milliseconds: 500));
  }

  Future<void> addAssessment(String memberId, Assessment assessment) async {
    // TODO: Implement API call
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
