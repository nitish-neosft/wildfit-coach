class ApiEndpoints {
  static const String baseUrl =
      'https://api.wildfit-coach.com/v1'; // Replace with your actual base URL

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
}
