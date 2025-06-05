import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:wildfit_coach/features/auth/data/services/user_service.dart';
import 'package:wildfit_coach/features/members/presentation/bloc/member/member_bloc.dart';
import 'package:wildfit_coach/features/members/presentation/bloc/nutrition_plan/nutrition_plan_bloc.dart';
import 'package:wildfit_coach/features/members/presentation/bloc/workout_plan/workout_plan_bloc.dart';
import '../network/dio_cofig.dart';
import '../network/rest_client.dart';
import '../network/network_info.dart';
import '../../features/dashboard/data/datasources/dashboard_remote_data_source.dart';
import '../../features/dashboard/data/repositories/dashboard_repository_impl.dart';
import '../../features/dashboard/domain/repositories/dashboard_repository.dart';
import '../../features/dashboard/domain/usecases/get_dashboard_data.dart';
import '../../features/dashboard/domain/usecases/get_members.dart';
import '../../features/dashboard/domain/usecases/get_member_details.dart';
import '../../features/dashboard/presentation/bloc/dashboard_bloc.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/data/datasources/auth_local_data_source.dart';
import '../../features/auth/data/datasources/auth_remote_data_source.dart';
import '../../features/auth/domain/usecases/check_auth_status.dart';
import '../../features/auth/domain/usecases/login.dart';
import '../../features/auth/domain/usecases/logout.dart';
import '../../features/auth/domain/usecases/register.dart';
import '../../features/auth/domain/usecases/refresh_token.dart';
import '../../features/auth/domain/usecases/reset_password.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/assessment/data/datasources/assessment_remote_data_source.dart';
import '../../features/assessment/data/repositories/assessment_repository_impl.dart';
import '../../features/assessment/domain/repositories/assessment_repository.dart';
import '../../features/assessment/domain/usecases/delete_assessment.dart';
import '../../features/assessment/domain/usecases/get_assessment_by_id.dart';
import '../../features/assessment/domain/usecases/get_assessments.dart';
import '../../features/assessment/domain/usecases/save_assessment.dart';
import '../../features/assessment/domain/usecases/update_assessment.dart';
import '../../features/assessment/presentation/bloc/assessment_bloc.dart';
import '../../features/members/domain/usecases/get_member.dart';
import '../../features/members/data/repositories/member_repository_impl.dart';
import '../../features/members/domain/repositories/member_repository.dart';
import '../../features/members/data/datasources/member_remote_data_source.dart';
import '../../features/profile/data/datasources/profile_remote_data_source.dart';
import '../../features/profile/data/repositories/profile_repository_impl.dart';
import '../../features/profile/domain/repositories/profile_repository.dart';
import '../../features/profile/domain/usecases/get_profile_settings.dart';
import '../../features/profile/domain/usecases/update_language.dart';
import '../../features/profile/domain/usecases/update_notification_settings.dart';
import '../../features/profile/domain/usecases/update_password.dart';
import '../../features/profile/domain/usecases/update_profile.dart';
import '../../features/profile/presentation/bloc/profile_bloc.dart';
import '../../features/profile/data/datasources/profile_local_data_source.dart';

import '../../features/assessment/presentation/bloc/blood_pressure/blood_pressure_bloc.dart';
import '../../features/assessment/presentation/bloc/cardio_fitness/cardio_fitness_bloc.dart';
import '../../features/assessment/presentation/bloc/muscular_flexibility/muscular_flexibility_bloc.dart';
import '../../features/assessment/presentation/bloc/detailed_measurements/detailed_measurements_bloc.dart';
import '../../features/members/domain/usecases/update_member.dart'
    as update_member;
import '../../features/members/domain/usecases/add_assessment.dart'
    as add_assessment;

final sl = GetIt.instance;

Future<void> init() async {
  // Core
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(sl()),
  );

  sl.registerLazySingleton(() => InternetConnectionChecker.createInstance());

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  sl.registerLazySingleton(() => const FlutterSecureStorage());

  // Network
  sl.registerLazySingleton(() => DioConfig.createDio(storage: sl()));
  sl.registerLazySingleton(() => RestClient(sl()));

  // Services
  sl.registerLazySingleton(() => UserService(sl()));

  // Features - Auth
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<Login>(
    () => Login(sl()),
  );

  sl.registerLazySingleton<Register>(
    () => Register(sl()),
  );

  sl.registerLazySingleton<Logout>(
    () => Logout(sl()),
  );

  sl.registerLazySingleton<CheckAuthStatus>(
    () => CheckAuthStatus(sl()),
  );

  sl.registerLazySingleton<RefreshToken>(
    () => RefreshToken(sl()),
  );

  sl.registerLazySingleton<ResetPassword>(
    () => ResetPassword(sl()),
  );

  sl.registerFactory(
    () => AuthBloc(
      login: sl(),
      register: sl(),
      logout: sl(),
      checkAuthStatus: sl(),
      refreshToken: sl(),
      resetPassword: sl(),
    ),
  );

  // Features - Dashboard
  sl.registerLazySingleton<DashboardRemoteDataSource>(
    () => DashboardRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<DashboardRepository>(
    () => DashboardRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<GetDashboardData>(
    () => GetDashboardData(sl()),
  );

  sl.registerLazySingleton<GetMembers>(
    () => GetMembers(sl()),
  );

  sl.registerLazySingleton<GetMemberDetails>(
    () => GetMemberDetails(sl()),
  );

  sl.registerFactory(
    () => DashboardBloc(
      getDashboardData: sl(),
      getMembers: sl(),
      getMemberDetails: sl(),
    ),
  );

  // Features - Profile
  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(client: sl()),
  );

  sl.registerLazySingleton<ProfileLocalDataSource>(
    () => ProfileLocalDataSourceImpl(),
  );

  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<GetProfileSettings>(
    () => GetProfileSettings(sl()),
  );

  sl.registerLazySingleton<UpdateNotificationSettings>(
    () => UpdateNotificationSettings(sl()),
  );

  sl.registerLazySingleton<UpdateLanguage>(
    () => UpdateLanguage(sl()),
  );

  sl.registerLazySingleton<UpdatePassword>(
    () => UpdatePassword(sl()),
  );

  sl.registerLazySingleton<UpdateProfile>(
    () => UpdateProfile(sl()),
  );

  sl.registerFactory(
    () => ProfileBloc(
      getProfileSettings: sl(),
      updateNotificationSettings: sl(),
      updateLanguage: sl(),
      updatePassword: sl(),
      updateProfile: sl(),
    ),
  );

  // Features - Members
  sl.registerLazySingleton<MemberRemoteDataSource>(
    () => MemberRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<MemberRepository>(
    () => MemberRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<GetMember>(
    () => GetMember(sl()),
  );

  sl.registerLazySingleton<update_member.UpdateMember>(
    () => update_member.UpdateMember(sl()),
  );

  sl.registerLazySingleton<add_assessment.AddAssessment>(
    () => add_assessment.AddAssessment(sl()),
  );

  sl.registerFactory(
    () => MemberBloc(
      getMember: sl<GetMember>(),
      updateMember: sl<update_member.UpdateMember>(),
      addAssessment: sl<add_assessment.AddAssessment>(),
    ),
  );

  sl.registerFactory(
    () => WorkoutPlanBloc(
      repository: sl(),
    ),
  );

  sl.registerFactory(
    () => NutritionPlanBloc(),
  );

  // Features - Assessment
  sl.registerLazySingleton<AssessmentRemoteDataSource>(
    () => AssessmentRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<AssessmentRepository>(
    () => AssessmentRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<GetAssessments>(
    () => GetAssessments(sl()),
  );

  sl.registerLazySingleton<GetAssessmentById>(
    () => GetAssessmentById(sl()),
  );

  sl.registerLazySingleton<SaveAssessment>(
    () => SaveAssessment(sl()),
  );

  sl.registerLazySingleton<UpdateAssessment>(
    () => UpdateAssessment(sl()),
  );

  sl.registerLazySingleton<DeleteAssessment>(
    () => DeleteAssessment(sl()),
  );

  sl.registerFactory(
    () => AssessmentBloc(
      getAssessments: sl(),
      getAssessmentById: sl(),
      saveAssessment: sl(),
      updateAssessment: sl(),
      deleteAssessment: sl(),
    ),
  );

  sl.registerFactory(
    () => BloodPressureBloc(
      saveAssessment: sl(),
    ),
  );

  sl.registerFactory(
    () => CardioFitnessBloc(
      saveAssessment: sl(),
    ),
  );

  sl.registerFactory(
    () => MuscularFlexibilityBloc(
      saveAssessment: sl(),
    ),
  );

  sl.registerFactory(
    () => DetailedMeasurementsBloc(
      saveAssessment: sl(),
    ),
  );

  // Initialize any async dependencies here
  await sl.allReady();
}
