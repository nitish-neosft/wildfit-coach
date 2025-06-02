import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wildfit_coach/features/assessment/presentation/screens/detailed_measurements_screen.dart';
import 'package:wildfit_coach/features/assessment/presentation/screens/muscular_flexibility_screen.dart';
import '../../features/assessment/presentation/screens/blood_pressure_screen.dart';
import '../../features/assessment/presentation/screens/cardio_fitness_screen.dart';
import '../../features/auth/presentation/screens/splash_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/members/presentation/screens/member_details_screen.dart';
import '../../features/members/presentation/screens/workout_plan_screen.dart';
import '../../features/members/presentation/screens/nutrition_plan_screen.dart';
import '../../features/auth/data/services/user_service.dart';
import '../../features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/members/bloc/member_bloc.dart';
import '../../features/members/bloc/workout_plan_bloc.dart';
import '../../features/members/bloc/nutrition_plan_bloc.dart';
import '../../features/members/data/member_repository.dart';
import '../../features/assessment/presentation/bloc/blood_pressure/blood_pressure_bloc.dart';
import '../../features/assessment/presentation/bloc/cardio_fitness/cardio_fitness_bloc.dart';
import '../../features/assessment/presentation/bloc/muscular_flexibility/muscular_flexibility_bloc.dart';
import '../../features/assessment/presentation/bloc/detailed_measurements/detailed_measurements_bloc.dart';
import '../../core/di/injection_container.dart' as di;

GoRouter createRouter(UserService userService) => GoRouter(
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
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: '/dashboard',
          builder: (context, state) => const DashboardScreen(),
        ),
        GoRoute(
          path: '/member-details/:id',
          builder: (context, state) => MemberDetailsScreen(
            memberId: state.pathParameters['id']!,
          ),
        ),
        GoRoute(
          path: '/assessment/new',
          builder: (context, state) => BlocProvider(
            create: (context) => DetailedMeasurementsBloc(
              saveAssessment: di.sl(),
            ),
            child: const DetailedMeasurementsScreen(),
          ),
        ),
        GoRoute(
          path: '/workout/new',
          builder: (context, state) => BlocProvider(
            create: (context) => WorkoutPlanBloc(),
            child: const WorkoutPlanScreen(
              memberId: '',
              planId: 'new',
            ),
          ),
        ),
        GoRoute(
          path: '/nutrition/plan',
          builder: (context, state) => BlocProvider(
            create: (context) => NutritionPlanBloc(),
            child: const NutritionPlanScreen(
              memberId: '',
              planId: 'new',
            ),
          ),
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
          path: '/workout-plan/:planId',
          builder: (context, state) {
            final Map<String, dynamic> extra =
                state.extra as Map<String, dynamic>;
            return BlocProvider(
              create: (context) => WorkoutPlanBloc()
                ..add(LoadWorkoutPlan(
                  planId: state.pathParameters['planId']!,
                  memberId: extra['memberId'],
                )),
              child: WorkoutPlanScreen(
                memberId: extra['memberId'],
                planId: state.pathParameters['planId']!,
              ),
            );
          },
        ),
        GoRoute(
          path: '/nutrition-plan/:planId',
          builder: (context, state) {
            final Map<String, dynamic> extra =
                state.extra as Map<String, dynamic>;
            return BlocProvider(
              create: (context) => NutritionPlanBloc()
                ..add(LoadNutritionPlan(
                  planId: state.pathParameters['planId']!,
                  memberId: extra['memberId'],
                )),
              child: NutritionPlanScreen(
                memberId: extra['memberId'],
                planId: state.pathParameters['planId']!,
              ),
            );
          },
        ),
        GoRoute(
          path: '/blood-pressure',
          builder: (context, state) {
            final selectedMonth = state.extra as DateTime?;
            return BlocProvider(
              create: (context) => BloodPressureBloc(
                saveAssessment: di.sl(),
              ),
              child: BloodPressureScreen(selectedMonth: selectedMonth),
            );
          },
        ),
        GoRoute(
          path: '/cardio-fitness',
          builder: (context, state) {
            final selectedMonth = state.extra as DateTime?;
            return BlocProvider(
              create: (context) => CardioFitnessBloc(
                saveAssessment: di.sl(),
              ),
              child: CardioFitnessScreen(selectedMonth: selectedMonth),
            );
          },
        ),
        GoRoute(
          path: '/muscular-flexibility',
          builder: (context, state) {
            final selectedMonth = state.extra as DateTime?;
            return BlocProvider(
              create: (context) => MuscularFlexibilityBloc(
                saveAssessment: di.sl(),
              ),
              child: MuscularFlexibilityScreen(selectedMonth: selectedMonth),
            );
          },
        ),
        GoRoute(
          path: '/detailed-measurements',
          builder: (context, state) {
            return BlocProvider(
              create: (context) => DetailedMeasurementsBloc(
                saveAssessment: di.sl(),
              ),
              child: const DetailedMeasurementsScreen(),
            );
          },
        ),
      ],
    );
