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
            child: Column(
              children: [
                ProfileHeader(
                  name: settings.name,
                  email: settings.email,
                  avatar: settings.avatar,
                  role: settings.role,
                  specialization: settings.specialization,
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildStatCard(
                          context,
                          'Experience',
                          '${settings.yearsOfExperience} Years',
                          Icons.timeline,
                        ),
                        _buildStatCard(
                          context,
                          'Active Members',
                          settings.activeMembers.toString(),
                          Icons.people,
                        ),
                        _buildStatCard(
                          context,
                          'Total Members',
                          settings.totalMembers.toString(),
                          Icons.groups,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SettingsSection(
                  title: 'Professional Details',
                  children: [
                    ListTile(
                      leading: const Icon(Icons.workspace_premium),
                      title: const Text('Certifications'),
                      subtitle: Text(settings.certifications.join(', ')),
                      trailing: const Icon(Icons.edit),
                      onTap: () {
                        // TODO: Implement certification management
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.schedule),
                      title: const Text('Working Hours'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => context.push('/working-hours'),
                    ),
                    ListTile(
                      leading: const Icon(Icons.calendar_today),
                      title: const Text('Schedule Management'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => context.push('/schedule'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SettingsSection(
                  title: 'Member Management',
                  children: [
                    ListTile(
                      leading: const Icon(Icons.assessment),
                      title: const Text('Assessment Templates'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => context.push('/assessment-templates'),
                    ),
                    ListTile(
                      leading: const Icon(Icons.fitness_center),
                      title: const Text('Workout Templates'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => context.push('/workout-templates'),
                    ),
                    ListTile(
                      leading: const Icon(Icons.bar_chart),
                      title: const Text('Progress Reports'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => context.push('/progress-reports'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SettingsSection(
                  title: 'Notifications',
                  children: [
                    SwitchListTile(
                      value: settings.notifications.memberCheckInAlerts,
                      onChanged: (value) {
                        context.read<ProfileBloc>().add(
                              UpdateNotificationSettingsEvent(
                                NotificationSettings(
                                  memberCheckInAlerts: value,
                                  memberAssessmentReminders: settings
                                      .notifications.memberAssessmentReminders,
                                  memberProgressAlerts: settings
                                      .notifications.memberProgressAlerts,
                                  membershipExpiryAlerts: settings
                                      .notifications.membershipExpiryAlerts,
                                  newMemberAssignments: settings
                                      .notifications.newMemberAssignments,
                                  staffMeetingReminders: settings
                                      .notifications.staffMeetingReminders,
                                  paymentReminders:
                                      settings.notifications.paymentReminders,
                                ),
                              ),
                            );
                      },
                      title: const Text('Member Check-in Alerts'),
                    ),
                    SwitchListTile(
                      value: settings.notifications.memberAssessmentReminders,
                      onChanged: (value) {
                        context.read<ProfileBloc>().add(
                              UpdateNotificationSettingsEvent(
                                NotificationSettings(
                                  memberCheckInAlerts: settings
                                      .notifications.memberCheckInAlerts,
                                  memberAssessmentReminders: value,
                                  memberProgressAlerts: settings
                                      .notifications.memberProgressAlerts,
                                  membershipExpiryAlerts: settings
                                      .notifications.membershipExpiryAlerts,
                                  newMemberAssignments: settings
                                      .notifications.newMemberAssignments,
                                  staffMeetingReminders: settings
                                      .notifications.staffMeetingReminders,
                                  paymentReminders:
                                      settings.notifications.paymentReminders,
                                ),
                              ),
                            );
                      },
                      title: const Text('Assessment Reminders'),
                    ),
                    SwitchListTile(
                      value: settings.notifications.memberProgressAlerts,
                      onChanged: (value) {
                        context.read<ProfileBloc>().add(
                              UpdateNotificationSettingsEvent(
                                NotificationSettings(
                                  memberCheckInAlerts: settings
                                      .notifications.memberCheckInAlerts,
                                  memberAssessmentReminders: settings
                                      .notifications.memberAssessmentReminders,
                                  memberProgressAlerts: value,
                                  membershipExpiryAlerts: settings
                                      .notifications.membershipExpiryAlerts,
                                  newMemberAssignments: settings
                                      .notifications.newMemberAssignments,
                                  staffMeetingReminders: settings
                                      .notifications.staffMeetingReminders,
                                  paymentReminders:
                                      settings.notifications.paymentReminders,
                                ),
                              ),
                            );
                      },
                      title: const Text('Member Progress Alerts'),
                    ),
                    SwitchListTile(
                      value: settings.notifications.membershipExpiryAlerts,
                      onChanged: (value) {
                        context.read<ProfileBloc>().add(
                              UpdateNotificationSettingsEvent(
                                NotificationSettings(
                                  memberCheckInAlerts: settings
                                      .notifications.memberCheckInAlerts,
                                  memberAssessmentReminders: settings
                                      .notifications.memberAssessmentReminders,
                                  memberProgressAlerts: settings
                                      .notifications.memberProgressAlerts,
                                  membershipExpiryAlerts: value,
                                  newMemberAssignments: settings
                                      .notifications.newMemberAssignments,
                                  staffMeetingReminders: settings
                                      .notifications.staffMeetingReminders,
                                  paymentReminders:
                                      settings.notifications.paymentReminders,
                                ),
                              ),
                            );
                      },
                      title: const Text('Membership Expiry Alerts'),
                    ),
                    SwitchListTile(
                      value: settings.notifications.newMemberAssignments,
                      onChanged: (value) {
                        context.read<ProfileBloc>().add(
                              UpdateNotificationSettingsEvent(
                                NotificationSettings(
                                  memberCheckInAlerts: settings
                                      .notifications.memberCheckInAlerts,
                                  memberAssessmentReminders: settings
                                      .notifications.memberAssessmentReminders,
                                  memberProgressAlerts: settings
                                      .notifications.memberProgressAlerts,
                                  membershipExpiryAlerts: settings
                                      .notifications.membershipExpiryAlerts,
                                  newMemberAssignments: value,
                                  staffMeetingReminders: settings
                                      .notifications.staffMeetingReminders,
                                  paymentReminders:
                                      settings.notifications.paymentReminders,
                                ),
                              ),
                            );
                      },
                      title: const Text('New Member Assignments'),
                    ),
                    SwitchListTile(
                      value: settings.notifications.staffMeetingReminders,
                      onChanged: (value) {
                        context.read<ProfileBloc>().add(
                              UpdateNotificationSettingsEvent(
                                NotificationSettings(
                                  memberCheckInAlerts: settings
                                      .notifications.memberCheckInAlerts,
                                  memberAssessmentReminders: settings
                                      .notifications.memberAssessmentReminders,
                                  memberProgressAlerts: settings
                                      .notifications.memberProgressAlerts,
                                  membershipExpiryAlerts: settings
                                      .notifications.membershipExpiryAlerts,
                                  newMemberAssignments: settings
                                      .notifications.newMemberAssignments,
                                  staffMeetingReminders: value,
                                  paymentReminders:
                                      settings.notifications.paymentReminders,
                                ),
                              ),
                            );
                      },
                      title: const Text('Staff Meeting Reminders'),
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

  Widget _buildStatCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
  ) {
    return Card(
      color: AppColors.darkCard,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: AppColors.primary),
            const SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.white.withOpacity(0.7),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
