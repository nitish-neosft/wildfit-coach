import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wildfit_coach/features/dashboard/data/models/dashboard_member_model.dart';
import 'package:wildfit_coach/features/members/data/models/member_model.dart';
import '../../features/auth/data/models/user_model.dart';
import '../../features/dashboard/data/models/dashboard_data_model.dart';
import '../../features/profile/data/models/profile_settings_model.dart';
import '../../features/assessment/data/models/user_assessment_model.dart';
import '../../features/schedule/data/models/session_model.dart';
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
  Future<List<MemberModel>> getMembers();

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

  // Member endpoints
  @POST(ApiEndpoints.members)
  Future<MemberModel> createMember(@Body() Map<String, dynamic> member);

  @DELETE("${ApiEndpoints.members}{id}")
  Future<void> deleteMember(@Path("id") String id);

  @GET("${ApiEndpoints.members}{id}")
  Future<MemberModel> getMember(@Path("id") String id);

  @PUT("${ApiEndpoints.members}{id}")
  Future<MemberModel> updateMember(
      @Path("id") String id, @Body() Map<String, dynamic> member);

  @PUT("${ApiEndpoints.members}{id}/goals")
  Future<void> updateMemberGoals(
      @Path("id") String id, @Body() Map<String, dynamic> goals);

  @POST("${ApiEndpoints.members}{id}/check-in")
  Future<void> checkIn(@Path("id") String id);

  @PUT("${ApiEndpoints.members}{id}/measurements")
  Future<void> updateMemberMeasurements(
      @Path("id") String id, @Body() Map<String, dynamic> measurements);

  @POST("${ApiEndpoints.members}{id}/assessments")
  Future<void> addAssessment(
      @Path("id") String id, @Body() Map<String, dynamic> assessment);

  @POST("${ApiEndpoints.members}{id}/workout-cards")
  Future<void> addWorkoutCard(
      @Path("id") String id, @Body() Map<String, dynamic> workoutCard);

  @PUT("${ApiEndpoints.members}{id}/workout-cards/{cardId}")
  Future<void> updateWorkoutCard(@Path("id") String id,
      @Path("cardId") String cardId, @Body() Map<String, dynamic> workoutCard);

  @DELETE("${ApiEndpoints.members}{id}/workout-cards/{cardId}")
  Future<void> deleteWorkoutCard(
      @Path("id") String id, @Path("cardId") String cardId);

  @POST("${ApiEndpoints.members}{id}/nutrition-cards")
  Future<void> addNutritionCard(
      @Path("id") String id, @Body() Map<String, dynamic> nutritionCard);

  @PUT("${ApiEndpoints.members}{id}/nutrition-cards/{cardId}")
  Future<void> updateNutritionCard(
      @Path("id") String id,
      @Path("cardId") String cardId,
      @Body() Map<String, dynamic> nutritionCard);

  @DELETE("${ApiEndpoints.members}{id}/nutrition-cards/{cardId}")
  Future<void> deleteNutritionCard(
      @Path("id") String id, @Path("cardId") String cardId);

  @GET('/members/pending-assessments')
  Future<List<MemberModel>> getMembersWithPendingAssessments();

  @GET('/sessions/today')
  Future<List<SessionModel>> getTodaySessions();

  @POST('/sessions')
  Future<SessionModel> createSession(@Body() Map<String, dynamic> session);

  @PUT('/sessions/{id}')
  Future<void> updateSession(
    @Path('id') String id,
    @Body() Map<String, dynamic> session,
  );

  @DELETE('/sessions/{id}')
  Future<void> deleteSession(@Path('id') String id);

  @POST('/sessions/{id}/complete')
  Future<void> completeSession(@Path('id') String id);
}
