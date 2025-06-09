import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wildfit_coach/features/auth/presentation/bloc/auth_event.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'firebase_options.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/router.dart';
import 'core/services/notification_service.dart';
import 'features/notifications/presentation/bloc/notification_bloc.dart';

import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/data/services/user_service.dart';
import 'core/di/injection_container.dart' as di;
import 'package:flutter_screenutil/flutter_screenutil.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Need to ensure Firebase is initialized here as well
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print('Handling background message: ${message.messageId}');
  // TODO: Handle background message
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependency injection
  await di.init();

  // Initialize Firebase
  await Firebase.initializeApp();

  // Initialize shared preferences and services
  final prefs = await SharedPreferences.getInstance();
  final userService = UserService(prefs);

  // Initialize notification service
  final notificationService = NotificationService();
  await notificationService.initialize();

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
          create: (context) =>
              di.sl<AuthBloc>()..add(CheckAuthStatusRequested()),
        ),
        BlocProvider<NotificationBloc>(
          create: (context) =>
              di.sl<NotificationBloc>()..add(LoadNotifications()),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp.router(
            title: 'WildFit Coach',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.darkTheme,
            routerConfig: createRouter(userService),
          );
        },
      ),
    );
  }
}
