import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wildfit_coach/features/members/domain/repositories/member_repository.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/router.dart';

import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/data/services/user_service.dart';
import 'features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'core/di/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  // Initialize services
  final prefs = await SharedPreferences.getInstance();
  final userService = UserService(prefs);

  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  runApp(MyApp(userService: userService));
}

class MyApp extends StatelessWidget {
  final UserService userService;

  const MyApp({
    required this.userService,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => di.sl<AuthBloc>(),
        ),
        BlocProvider<DashboardBloc>(
          create: (context) => di.sl<DashboardBloc>(),
        ),
        RepositoryProvider<MemberRepository>(
          create: (context) => di.sl<MemberRepository>(),
        ),
      ],
      child: MaterialApp.router(
        title: 'WildFit',
        theme: AppTheme.darkTheme,
        routerConfig: createRouter(userService),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
