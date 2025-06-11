class ApiEndpoints {
  static const String baseUrl =
      'https://massive-diverse-dane.ngrok-free.app/api'; // Development URL

  // Auth endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String refreshToken = '/auth/refresh';
  static const String resetPassword = '/auth/reset-password';

  // Dashboard endpoints
  static const String dashboard = '/dashboard';
  static const String members = '/members';
  static const String memberDetails = '/members/'; // Append member ID

  // Profile endpoints
  static const String profile = '/profile';
  static const String updateProfile = '/profile/update';

  // Session endpoints
  static const String sessions = '/sessions';
  static const String sessionDetails = '/sessions/'; // Append session ID

  // Assessment endpoints
  static const String assessments = '/assessments';
  static const String assessmentDetails =
      '/assessments/'; // Append assessment ID

  // Workout plan endpoints
  static const String workoutPlans = '/workout-plans';
  static const String memberWorkoutPlans = '/members/{memberId}/workout-plans';
  static const String workoutPlanDetails = '/workout-plans/'; // Append plan ID
  static const String workoutPlanProgress = '/workout-plans/{id}/progress';

  // Nutrition plan endpoints
  static const String nutritionPlans = '/nutrition-plans';
  static const String memberNutritionPlans =
      '/members/{memberId}/nutrition-plans';
  static const String nutritionPlanDetails =
      '/nutrition-plans/'; // Append plan ID
  static const String nutritionPlanProgress = '/nutrition-plans/{id}/progress';
}
