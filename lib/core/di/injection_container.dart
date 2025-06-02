import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../network/api_client.dart';
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
import '../../features/members/bloc/member_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Features - Auth
  // Bloc
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

  // Use cases
  sl.registerLazySingleton(() => Login(sl()));
  sl.registerLazySingleton(() => Register(sl()));
  sl.registerLazySingleton(() => Logout(sl()));
  sl.registerLazySingleton(() => CheckAuthStatus(sl()));
  sl.registerLazySingleton(() => RefreshToken(sl()));
  sl.registerLazySingleton(() => ResetPassword(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(sl()),
  );

  // Features - Assessment
  // Bloc
  sl.registerFactory(
    () => AssessmentBloc(
      getAssessments: sl(),
      getAssessmentById: sl(),
      saveAssessment: sl(),
      updateAssessment: sl(),
      deleteAssessment: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetAssessments(sl()));
  sl.registerLazySingleton(() => GetAssessmentById(sl()));
  sl.registerLazySingleton(() => SaveAssessment(sl()));
  sl.registerLazySingleton(() => UpdateAssessment(sl()));
  sl.registerLazySingleton(() => DeleteAssessment(sl()));

  // Repository
  sl.registerLazySingleton<AssessmentRepository>(
    () => AssessmentRepositoryImpl(sl()),
  );

  // Data sources
  sl.registerLazySingleton<AssessmentRemoteDataSource>(
    () => AssessmentRemoteDataSourceImpl(sl()),
  );

  // Features - Dashboard
  // Bloc
  sl.registerFactory(
    () => DashboardBloc(
      getDashboardData: sl(),
      getMembers: sl(),
      getMemberDetails: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetDashboardData(sl()));
  sl.registerLazySingleton(() => GetMembers(sl()));
  sl.registerLazySingleton(() => GetMemberDetails(sl()));

  // Repository
  sl.registerLazySingleton<DashboardRepository>(
    () => DashboardRepositoryImpl(sl()),
  );

  // Data sources
  sl.registerLazySingleton<DashboardRemoteDataSource>(
    () => DashboardRemoteDataSourceImpl(sl()),
  );

  // Core
  sl.registerLazySingleton(() => const FlutterSecureStorage());
  sl.registerLazySingleton(() => Dio()); // Base Dio instance
  sl.registerLazySingleton(() => ApiClient(
        dio: sl(),
        storage: sl(),
      ));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  // Member feature
  sl.registerFactory(() => MemberBloc(repository: sl()));

  // Initialize any async dependencies here
  await sl.allReady();
}
