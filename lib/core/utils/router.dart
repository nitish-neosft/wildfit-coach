import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wildfit_coach/features/assessment/presentation/bloc/blood_pressure/blood_pressure_bloc.dart';
import 'package:wildfit_coach/features/assessment/presentation/bloc/cardio_fitness/cardio_fitness_bloc.dart';
import 'package:wildfit_coach/features/assessment/presentation/bloc/detailed_measurements/detailed_measurements_bloc.dart';
import 'package:wildfit_coach/features/assessment/presentation/bloc/muscular_flexibility/muscular_flexibility_bloc.dart';
import 'package:wildfit_coach/features/assessment/presentation/screens/detailed_measurements_screen.dart';
import 'package:wildfit_coach/features/assessment/presentation/screens/muscular_flexibility_screen.dart';
import 'package:wildfit_coach/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:wildfit_coach/features/profile/presentation/pages/profile_page.dart';
import '../../features/assessment/domain/usecases/save_assessment.dart';
import '../../features/assessment/presentation/screens/blood_pressure_screen.dart';
import '../../features/assessment/presentation/screens/cardio_fitness_screen.dart';
import '../../features/auth/presentation/screens/splash_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/members/presentation/screens/member_details_screen.dart';
import '../../features/auth/data/services/user_service.dart';
import '../../features/dashboard/presentation/screens/dashboard_screen.dart';
import '../../features/notifications/presentation/screens/notification_screen.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../core/di/injection_container.dart' as di;
import '../../features/workout/presentation/screens/workout_plans_screen.dart';
import '../../features/workout/presentation/screens/workout_plan_form_screen.dart';
import '../../features/workout/presentation/bloc/workout_bloc.dart';
import '../../features/workout/domain/entities/workout_plan.dart';
import '../../features/workout/presentation/screens/workout_plan_detail_screen.dart';
import '../../features/nutrition/presentation/screens/nutrition_plans_screen.dart';
import '../../features/nutrition/presentation/screens/nutrition_plan_form_screen.dart';
import '../../features/nutrition/presentation/screens/nutrition_plan_detail_screen.dart';
import '../../features/nutrition/presentation/bloc/nutrition_bloc.dart';
import '../../features/nutrition/domain/entities/nutrition_plan.dart';
import '../../features/members/presentation/screens/members_list_screen.dart';
import '../../features/members/presentation/screens/new_member_screen.dart';
import '../../features/assessment/presentation/bloc/pending_assessments/pending_assessments_bloc.dart';
import '../../features/assessment/presentation/screens/pending_assessments_screen.dart';
import '../../features/workout/presentation/screens/workouts_overview_screen.dart';
import '../../features/nutrition/presentation/screens/nutrition_overview_screen.dart';
import '../../features/nutrition/presentation/screens/nutrition_plan_edit_screen.dart';
import '../../features/nutrition/data/repositories/nutrition_repository_impl.dart';

GoRouter createRouter(UserService userService) {
  final nutritionRepository = NutritionRepositoryImpl();

  return GoRouter(
    initialLocation: '/splash',
    errorBuilder: (context, state) => const LoginScreen(),
    redirect: (context, state) {
      final isLoggedIn = userService.isAuthenticated();
      final isLoginRoute = state.matchedLocation == '/login';
      final isSplashRoute = state.matchedLocation == '/splash';

      if (!isLoggedIn && !isLoginRoute && !isSplashRoute) {
        return '/login';
      }
      if (isLoggedIn && isLoginRoute) {
        return '/dashboard';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => BlocProvider.value(
          value: context.read<AuthBloc>(),
          child: const SplashScreen(),
        ),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => BlocProvider.value(
          value: context.read<AuthBloc>(),
          child: const LoginScreen(),
        ),
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: '/notifications',
        builder: (context, state) => const NotificationScreen(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => BlocProvider(
          create: (context) => di.sl<ProfileBloc>()..add(LoadProfileSettings()),
          child: const ProfilePage(),
        ),
      ),
      GoRoute(
        path: '/members/:id',
        builder: (context, state) {
          final memberId = state.pathParameters['id']!;
          return MemberDetailsScreen(
            memberId: memberId,
          );
        },
      ),
      GoRoute(
        path: '/members',
        builder: (context, state) => const MembersListScreen(),
      ),
      GoRoute(
        path: '/members/new',
        builder: (context, state) => const NewMemberScreen(),
      ),
      GoRoute(
        path: '/workout-plans/new',
        builder: (context, state) {
          final memberId = state.extra as String;
          return BlocProvider(
            create: (context) => di.sl<WorkoutBloc>(),
            child: WorkoutPlanFormScreen(memberId: memberId),
          );
        },
      ),
      GoRoute(
        path: '/workout-plans/:id/edit',
        builder: (context, state) {
          final Map<String, dynamic> extra =
              state.extra as Map<String, dynamic>;
          final memberId = extra['memberId'] as String;
          final workoutPlan = extra['plan'] as WorkoutPlan;
          return BlocProvider(
            create: (context) => di.sl<WorkoutBloc>(),
            child: WorkoutPlanFormScreen(
              memberId: memberId,
              workoutPlan: workoutPlan,
            ),
          );
        },
      ),
      GoRoute(
        path: '/workout-plans/member/:memberId',
        builder: (context, state) {
          final memberId = state.pathParameters['memberId']!;
          return BlocProvider(
            create: (context) =>
                di.sl<WorkoutBloc>()..add(LoadMemberWorkoutPlans(memberId)),
            child: WorkoutPlansScreen(memberId: memberId),
          );
        },
      ),
      GoRoute(
        path: '/workout-plans/detail/:id',
        builder: (context, state) {
          final Map<String, dynamic> extra =
              state.extra as Map<String, dynamic>;
          final memberId = extra['memberId'] as String;
          final workoutPlan = extra['plan'] as WorkoutPlan;
          return BlocProvider(
            create: (context) => di.sl<WorkoutBloc>(),
            child: WorkoutPlanDetailScreen(
              memberId: memberId,
              workoutPlan: workoutPlan,
            ),
          );
        },
      ),
      GoRoute(
        path: '/assessment/new',
        builder: (context, state) => BlocProvider(
          create: (context) => di.sl<DetailedMeasurementsBloc>(
              param1: state.pathParameters['memberId'] ?? ''),
          child: DetailedMeasurementsScreen(
              memberId: state.pathParameters['memberId'] ?? ''),
        ),
      ),
      GoRoute(
        path: '/assessment/pending',
        builder: (context, state) => BlocProvider(
          create: (context) => PendingAssessmentsBloc(
            memberRepository: di.sl(),
          )..add(LoadPendingAssessments()),
          child: const PendingAssessmentsScreen(),
        ),
      ),
      GoRoute(
        path: '/assessment/blood-pressure/:memberId',
        builder: (context, state) {
          final memberId = state.pathParameters['memberId']!;
          return BlocProvider(
            create: (context) => di.sl<BloodPressureBloc>(param1: memberId),
            child: BloodPressureScreen(
              memberId: state.pathParameters['memberId'] ?? '',
              selectedMonth: state.extra as DateTime?,
            ),
          );
        },
      ),
      GoRoute(
        path: '/assessment/cardio-fitness/:memberId',
        builder: (context, state) {
          final memberId = state.pathParameters['memberId']!;
          return BlocProvider(
            create: (context) => di.sl<CardioFitnessBloc>(param1: memberId),
            child: CardioFitnessScreen(
              memberId: state.pathParameters['memberId'] ?? '',
              selectedMonth: state.extra as DateTime?,
            ),
          );
        },
      ),
      GoRoute(
        path: '/assessment/muscular-flexibility/:memberId',
        builder: (context, state) {
          final memberId = state.pathParameters['memberId']!;
          return BlocProvider(
            create: (context) =>
                di.sl<MuscularFlexibilityBloc>(param1: memberId),
            child: MuscularFlexibilityScreen(
              memberId: state.pathParameters['memberId'] ?? '',
              selectedMonth: state.extra as DateTime?,
            ),
          );
        },
      ),
      GoRoute(
        path: '/assessment/detailed-measurements/:memberId',
        builder: (context, state) {
          final memberId = state.pathParameters['memberId']!;
          return BlocProvider(
            create: (context) =>
                di.sl<DetailedMeasurementsBloc>(param1: memberId),
            child: DetailedMeasurementsScreen(
                memberId: state.pathParameters['memberId'] ?? ''),
          );
        },
      ),
      GoRoute(
        path: '/schedule/new',
        builder: (context, state) {
          return const Scaffold(
            body: Center(
              child: Text(
                'Schedule Screen - Coming Soon',
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        },
      ),
      GoRoute(
        path: '/blood-pressure',
        builder: (context, state) {
          final selectedMonth = state.extra as DateTime?;
          return BlocProvider(
            create: (context) => di.sl<BloodPressureBloc>(
                param1: state.pathParameters['memberId'] ?? ''),
            child: BloodPressureScreen(
              memberId: state.pathParameters['memberId'] ?? '',
              selectedMonth: selectedMonth,
            ),
          );
        },
      ),
      GoRoute(
        path: '/cardio-fitness',
        builder: (context, state) {
          final selectedMonth = state.extra as DateTime?;
          return BlocProvider(
            create: (context) => di.sl<CardioFitnessBloc>(
                param1: state.pathParameters['memberId'] ?? ''),
            child: CardioFitnessScreen(
              memberId: state.pathParameters['memberId'] ?? '',
              selectedMonth: selectedMonth,
            ),
          );
        },
      ),
      GoRoute(
        path: '/muscular-flexibility',
        builder: (context, state) {
          final selectedMonth = state.extra as DateTime?;
          return BlocProvider(
            create: (context) => di.sl<MuscularFlexibilityBloc>(
                param1: state.pathParameters['memberId'] ?? ''),
            child: MuscularFlexibilityScreen(
              memberId: state.pathParameters['memberId'] ?? '',
              selectedMonth: selectedMonth,
            ),
          );
        },
      ),
      GoRoute(
        path: '/detailed-measurements',
        builder: (context, state) {
          return BlocProvider(
            create: (context) => di.sl<DetailedMeasurementsBloc>(
                param1: state.pathParameters['memberId'] ?? ''),
            child: DetailedMeasurementsScreen(
                memberId: state.pathParameters['memberId'] ?? ''),
          );
        },
      ),
      GoRoute(
        path: '/working-hours',
        builder: (context, state) {
          return const Scaffold(
            body: Center(
              child: Text(
                'Working Hours Management - Coming Soon',
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        },
      ),
      GoRoute(
        path: '/schedule',
        builder: (context, state) {
          return const Scaffold(
            body: Center(
              child: Text(
                'Schedule Management - Coming Soon',
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        },
      ),
      GoRoute(
        path: '/assessment-templates',
        builder: (context, state) {
          return const Scaffold(
            body: Center(
              child: Text(
                'Assessment Templates - Coming Soon',
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        },
      ),
      GoRoute(
        path: '/workout-templates',
        builder: (context, state) {
          return const Scaffold(
            body: Center(
              child: Text(
                'Workout Templates - Coming Soon',
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        },
      ),
      GoRoute(
        path: '/progress-reports',
        builder: (context, state) {
          return const Scaffold(
            body: Center(
              child: Text(
                'Progress Reports - Coming Soon',
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        },
      ),
      GoRoute(
        path: '/nutrition-plans/member/:memberId',
        builder: (context, state) {
          final memberId = state.pathParameters['memberId']!;
          return BlocProvider(
            create: (context) =>
                di.sl<NutritionBloc>()..add(LoadMemberNutritionPlans(memberId)),
            child: NutritionPlansScreen(memberId: memberId),
          );
        },
      ),
      GoRoute(
        path: '/nutrition-plans',
        builder: (context, state) => BlocProvider(
          create: (context) => NutritionBloc(repository: nutritionRepository),
          child: const NutritionOverviewScreen(),
        ),
      ),
      GoRoute(
        path: '/nutrition-plans/detail/:id',
        builder: (context, state) {
          final params = state.extra as Map<String, dynamic>;
          return NutritionPlanDetailScreen(
            memberId: params['memberId'] as String,
            nutritionPlan: params['plan'] as NutritionPlan,
          );
        },
      ),
      GoRoute(
        path: '/nutrition-plans/:id/edit',
        builder: (context, state) {
          final params = state.extra as Map<String, dynamic>;
          return BlocProvider(
            create: (context) => NutritionBloc(repository: nutritionRepository),
            child: NutritionPlanEditScreen(
              memberId: params['memberId'] as String,
              plan: params['plan'] as NutritionPlan,
            ),
          );
        },
      ),
      GoRoute(
        path: '/nutrition-plans/new',
        builder: (context, state) => BlocProvider(
          create: (context) => NutritionBloc(repository: nutritionRepository),
          child: const NutritionPlanEditScreen(
            memberId: 'member1', // TODO: Get actual member ID
            plan: null,
          ),
        ),
      ),
      GoRoute(
        path: '/workouts',
        builder: (context, state) => BlocProvider(
          create: (context) => di.sl<WorkoutBloc>(),
          child: const WorkoutsOverviewScreen(),
        ),
      ),
      GoRoute(
        path: '/nutrition/plan',
        builder: (context, state) => const Scaffold(
          body: Center(
            child: Text(
              'Nutrition Planning Overview - Coming Soon',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    ],
  );
}
