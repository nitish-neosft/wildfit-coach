import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wildfit_coach/features/dashboard/data/models/dashboard_member_model.dart';
import 'package:wildfit_coach/features/members/data/models/workout_plan_model.dart';
import '../error/exceptions.dart';
import '../../features/auth/data/models/user_model.dart';
import '../../features/dashboard/data/models/dashboard_data_model.dart';
import '../../features/profile/data/models/profile_settings_model.dart';
import '../../features/assessment/data/models/user_assessment_model.dart';
import 'api_endpoints.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: ApiEndpoints.baseUrl)
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  // Auth endpoints
  @POST(ApiEndpoints.login)
  Future<UserModel> login(@Body() Map<String, dynamic> body);

  @POST(ApiEndpoints.register)
  Future<UserModel> register(@Body() Map<String, dynamic> body);

  @POST(ApiEndpoints.refreshToken)
  Future<UserModel> refreshToken();

  @POST(ApiEndpoints.resetPassword)
  Future<void> resetPassword(@Body() Map<String, dynamic> body);

  // Dashboard endpoints
  @GET(ApiEndpoints.dashboard)
  Future<DashboardDataModel> getDashboardData();

  @GET(ApiEndpoints.members)
  Future<List<DashboardMemberModel>> getMembers();

  @GET("${ApiEndpoints.memberDetails}{id}")
  Future<DashboardMemberModel> getMemberDetails(@Path("id") String id);

  // Profile endpoints
  @GET(ApiEndpoints.profile)
  Future<ProfileSettingsModel> getProfileSettings();

  @PUT("${ApiEndpoints.profile}/notification-settings")
  Future<void> updateNotificationSettings(
      @Body() Map<String, dynamic> settings);

  @PUT("${ApiEndpoints.profile}/language")
  Future<void> updateLanguage(@Body() Map<String, dynamic> body);

  @PUT("${ApiEndpoints.profile}/password")
  Future<void> updatePassword(@Body() Map<String, dynamic> body);

  @PUT(ApiEndpoints.profile)
  Future<void> updateProfile(@Body() Map<String, dynamic> body);

  // Assessment endpoints
  @POST(ApiEndpoints.assessments)
  Future<void> saveAssessment(@Body() Map<String, dynamic> assessment);

  @GET(ApiEndpoints.assessments)
  Future<List<UserAssessmentModel>> getAssessments();

  @GET("${ApiEndpoints.assessmentDetails}{id}")
  Future<UserAssessmentModel> getAssessmentById(@Path("id") String id);

  @PUT("${ApiEndpoints.assessmentDetails}{id}")
  Future<void> updateAssessment(
      @Path("id") String id, @Body() Map<String, dynamic> assessment);

  @DELETE("${ApiEndpoints.assessmentDetails}{id}")
  Future<void> deleteAssessment(@Path("id") String id);

  // Workout plan endpoints
  @GET(ApiEndpoints.memberWorkoutPlans)
  Future<List<WorkoutPlanModel>> getMemberWorkoutPlans(
      @Path("memberId") String memberId);

  @GET("${ApiEndpoints.workoutPlanDetails}{id}")
  Future<WorkoutPlanModel> getWorkoutPlan(@Path("id") String id);

  @POST(ApiEndpoints.workoutPlans)
  Future<WorkoutPlanModel> createWorkoutPlan(@Body() Map<String, dynamic> plan);

  @PUT("${ApiEndpoints.workoutPlanDetails}{id}")
  Future<WorkoutPlanModel> updateWorkoutPlan(
      @Path("id") String id, @Body() Map<String, dynamic> plan);

  @DELETE("${ApiEndpoints.workoutPlanDetails}{id}")
  Future<void> deleteWorkoutPlan(@Path("id") String id);

  @PUT(ApiEndpoints.workoutPlanProgress)
  Future<void> updateWorkoutProgress(
      @Path("id") String id, @Body() Map<String, dynamic> progress);
}
