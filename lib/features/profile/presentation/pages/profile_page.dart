import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/constants/colors.dart';
import '../../domain/entities/profile_settings.dart';
import '../bloc/profile_bloc.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_event.dart';
import '../../../auth/presentation/bloc/auth_state.dart';
import '../widgets/change_password_dialog.dart';
import '../widgets/language_picker_dialog.dart';
import '../widgets/profile_header.dart';
import '../widgets/settings_section.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Profile',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: MultiBlocListener(
          listeners: [
            BlocListener<ProfileBloc, ProfileState>(
              listener: (context, state) {
                if (state is ProfileUpdateError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                } else if (state is ProfileUpdateSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Successfully updated')),
                  );
                }
              },
            ),
            BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is Unauthenticated) {
                  context.go('/login');
                }
              },
            ),
          ],
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ProfileLoaded) {
                return _buildContent(context, state.settings);
              } else if (state is ProfileError) {
                return Center(child: Text(state.message));
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, ProfileSettings settings) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.primary.withOpacity(0.1),
                  AppColors.primary.withOpacity(0.05),
                  Colors.transparent,
                ],
              ),
            ),
            child: ProfileHeader(
              name: settings.name,
              email: settings.email,
              avatar: settings.avatar,
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SettingsSection(
                  title: 'Notifications',
                  children: [
                    SwitchListTile(
                      value: settings.notifications.checkInReminders,
                      onChanged: (value) {
                        context.read<ProfileBloc>().add(
                              UpdateNotificationSettingsEvent(
                                NotificationSettings(
                                  checkInReminders: value,
                                  checkOutReminders:
                                      settings.notifications.checkOutReminders,
                                  nutritionPlanAlerts: settings
                                      .notifications.nutritionPlanAlerts,
                                  fitnessTestReminders: settings
                                      .notifications.fitnessTestReminders,
                                  workoutPlanAlerts:
                                      settings.notifications.workoutPlanAlerts,
                                  trainerAttendanceSummary: settings
                                      .notifications.trainerAttendanceSummary,
                                  paymentReminders:
                                      settings.notifications.paymentReminders,
                                ),
                              ),
                            );
                      },
                      title: const Text('Check-in Reminders'),
                    ),
                    SwitchListTile(
                      value: settings.notifications.checkOutReminders,
                      onChanged: (value) {
                        context.read<ProfileBloc>().add(
                              UpdateNotificationSettingsEvent(
                                NotificationSettings(
                                  checkInReminders:
                                      settings.notifications.checkInReminders,
                                  checkOutReminders: value,
                                  nutritionPlanAlerts: settings
                                      .notifications.nutritionPlanAlerts,
                                  fitnessTestReminders: settings
                                      .notifications.fitnessTestReminders,
                                  workoutPlanAlerts:
                                      settings.notifications.workoutPlanAlerts,
                                  trainerAttendanceSummary: settings
                                      .notifications.trainerAttendanceSummary,
                                  paymentReminders:
                                      settings.notifications.paymentReminders,
                                ),
                              ),
                            );
                      },
                      title: const Text('Check-out Reminders'),
                    ),
                    SwitchListTile(
                      value: settings.notifications.nutritionPlanAlerts,
                      onChanged: (value) {
                        context.read<ProfileBloc>().add(
                              UpdateNotificationSettingsEvent(
                                NotificationSettings(
                                  checkInReminders:
                                      settings.notifications.checkInReminders,
                                  checkOutReminders:
                                      settings.notifications.checkOutReminders,
                                  nutritionPlanAlerts: value,
                                  fitnessTestReminders: settings
                                      .notifications.fitnessTestReminders,
                                  workoutPlanAlerts:
                                      settings.notifications.workoutPlanAlerts,
                                  trainerAttendanceSummary: settings
                                      .notifications.trainerAttendanceSummary,
                                  paymentReminders:
                                      settings.notifications.paymentReminders,
                                ),
                              ),
                            );
                      },
                      title: const Text('Nutrition Plan Alerts'),
                    ),
                    SwitchListTile(
                      value: settings.notifications.workoutPlanAlerts,
                      onChanged: (value) {
                        context.read<ProfileBloc>().add(
                              UpdateNotificationSettingsEvent(
                                NotificationSettings(
                                  checkInReminders:
                                      settings.notifications.checkInReminders,
                                  checkOutReminders:
                                      settings.notifications.checkOutReminders,
                                  nutritionPlanAlerts: settings
                                      .notifications.nutritionPlanAlerts,
                                  fitnessTestReminders: settings
                                      .notifications.fitnessTestReminders,
                                  workoutPlanAlerts: value,
                                  trainerAttendanceSummary: settings
                                      .notifications.trainerAttendanceSummary,
                                  paymentReminders:
                                      settings.notifications.paymentReminders,
                                ),
                              ),
                            );
                      },
                      title: const Text('Workout Plan Alerts'),
                    ),
                    SwitchListTile(
                      value: settings.notifications.trainerAttendanceSummary,
                      onChanged: (value) {
                        context.read<ProfileBloc>().add(
                              UpdateNotificationSettingsEvent(
                                NotificationSettings(
                                  checkInReminders:
                                      settings.notifications.checkInReminders,
                                  checkOutReminders:
                                      settings.notifications.checkOutReminders,
                                  nutritionPlanAlerts: settings
                                      .notifications.nutritionPlanAlerts,
                                  fitnessTestReminders: settings
                                      .notifications.fitnessTestReminders,
                                  workoutPlanAlerts:
                                      settings.notifications.workoutPlanAlerts,
                                  trainerAttendanceSummary: value,
                                  paymentReminders:
                                      settings.notifications.paymentReminders,
                                ),
                              ),
                            );
                      },
                      title: const Text('Trainer Attendance Summary'),
                    ),
                    SwitchListTile(
                      value: settings.notifications.paymentReminders,
                      onChanged: (value) {
                        context.read<ProfileBloc>().add(
                              UpdateNotificationSettingsEvent(
                                NotificationSettings(
                                  checkInReminders:
                                      settings.notifications.checkInReminders,
                                  checkOutReminders:
                                      settings.notifications.checkOutReminders,
                                  nutritionPlanAlerts: settings
                                      .notifications.nutritionPlanAlerts,
                                  fitnessTestReminders: settings
                                      .notifications.fitnessTestReminders,
                                  workoutPlanAlerts:
                                      settings.notifications.workoutPlanAlerts,
                                  trainerAttendanceSummary: settings
                                      .notifications.trainerAttendanceSummary,
                                  paymentReminders: value,
                                ),
                              ),
                            );
                      },
                      title: const Text('Payment Reminders'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SettingsSection(
                  title: 'Plans & Tests',
                  children: [
                    ListTile(
                      leading: const Icon(Icons.fitness_center),
                      title: const Text('Workout Plan'),
                      subtitle: Text(
                        settings.hasWorkoutPlan ? 'View Plan' : 'Not Assigned',
                      ),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        if (settings.hasWorkoutPlan) {
                          context.push('/workout-plan/current',
                              extra: {'memberId': settings.userId});
                        }
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.restaurant_menu),
                      title: const Text('Nutrition Plan'),
                      subtitle: Text(
                        settings.hasNutritionPlan
                            ? 'View Plan'
                            : 'Not Assigned',
                      ),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        if (settings.hasNutritionPlan) {
                          context.push('/nutrition-plan/current',
                              extra: {'memberId': settings.userId});
                        }
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.monitor_heart),
                      title: const Text('Fitness Test'),
                      subtitle: Text(
                        settings.hasFitnessTest
                            ? 'View Results'
                            : 'Not Conducted',
                      ),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        if (settings.hasFitnessTest) {
                          context.push('/detailed-measurements',
                              extra: {'memberId': settings.userId});
                        }
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SettingsSection(
                  title: 'Account Settings',
                  children: [
                    ListTile(
                      leading: const Icon(Icons.language),
                      title: const Text('Language'),
                      subtitle: Text(settings.language),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => LanguagePickerDialog(
                            currentLanguage: settings.language,
                            onLanguageSelected: (language) {
                              context
                                  .read<ProfileBloc>()
                                  .add(UpdateLanguageEvent(language));
                            },
                          ),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.lock_outline),
                      title: const Text('Change Password'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => ChangePasswordDialog(
                            onPasswordChange: (currentPassword, newPassword) {
                              context.read<ProfileBloc>().add(
                                    UpdatePasswordEvent(
                                      currentPassword: currentPassword,
                                      newPassword: newPassword,
                                    ),
                                  );
                            },
                          ),
                        );
                      },
                    ),
                    if (settings.hasUnpaidDues)
                      ListTile(
                        leading: const Icon(Icons.payment, color: Colors.red),
                        title: const Text('Pending Payments'),
                        subtitle: const Text('Action Required'),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {
                          context.push('/payments');
                        },
                      ),
                    ListTile(
                      leading: const Icon(Icons.logout, color: Colors.red),
                      title: const Text('Logout'),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Logout'),
                            content:
                                const Text('Are you sure you want to logout?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  context
                                      .read<AuthBloc>()
                                      .add(LogoutRequested());
                                },
                                child: const Text(
                                  'Logout',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
