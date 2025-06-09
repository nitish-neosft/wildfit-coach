import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/constants/colors.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_state.dart';
import '../../../members/domain/entities/member.dart';
import '../bloc/dashboard_bloc.dart';
import '../widgets/modern_stats_card.dart';
import '../widgets/modern_member_card.dart';
import '../widgets/modern_quick_action_card.dart';
import '../widgets/activity_timeline.dart';
import '../widgets/network_image.dart';
import '../../../notifications/presentation/bloc/notification_bloc.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<DashboardBloc>()..add(LoadDashboard()),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, authState) {
          if (authState is Authenticated && authState.user != null) {
            final user = authState.user;
            final name = user.name ?? 'Professional';
            final avatar = user.profileImage ??
                'https://ui-avatars.com/api/?name=${Uri.encodeComponent(name)}&background=0D8ABC&color=fff';

            return Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              body: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.darkBackground,
                      AppColors.darkBackground.withOpacity(0.95),
                    ],
                  ),
                ),
                child: BlocBuilder<DashboardBloc, DashboardState>(
                  builder: (context, state) {
                    if (state is DashboardLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                        ),
                      );
                    }
                    if (state is DashboardError) {
                      return Center(
                        child: Text(
                          'Error: ${state.message}',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: AppColors.error,
                                  ),
                        ),
                      );
                    }
                    if (state is DashboardLoaded) {
                      final data = state.data;
                      return Scaffold(
                        appBar: AppBar(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Welcome back,',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: AppColors.white.withOpacity(0.7),
                                    ),
                              ),
                              Text(
                                name,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                      color: AppColors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ],
                          ),
                          actions: [
                            BlocBuilder<NotificationBloc, NotificationState>(
                              builder: (context, state) {
                                int unreadCount = 0;
                                if (state is NotificationLoaded) {
                                  unreadCount = state.notifications
                                      .where((notification) =>
                                          !notification.isRead)
                                      .length;
                                }

                                return Stack(
                                  children: [
                                    IconButton(
                                      icon: const Icon(
                                        Icons.notifications,
                                        color: AppColors.white,
                                      ),
                                      onPressed: () =>
                                          context.push('/notifications'),
                                    ),
                                    if (unreadCount > 0)
                                      Positioned(
                                        right: 8,
                                        top: 8,
                                        child: Container(
                                          padding: const EdgeInsets.all(2),
                                          decoration: BoxDecoration(
                                            color: AppColors.error,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          constraints: const BoxConstraints(
                                            minWidth: 16,
                                            minHeight: 16,
                                          ),
                                          child: Text(
                                            unreadCount > 99
                                                ? '99+'
                                                : unreadCount.toString(),
                                            style: const TextStyle(
                                              color: AppColors.white,
                                              fontSize: 10,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                  ],
                                );
                              },
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: GestureDetector(
                                onTap: () => context.push('/profile'),
                                child: NetworkImageWithFallback(
                                  imageUrl: avatar,
                                  width: 32,
                                  height: 32,
                                  borderRadius: BorderRadius.circular(16),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                        body: RefreshIndicator(
                          onRefresh: () async {
                            context.read<DashboardBloc>().add(LoadDashboard());
                          },
                          child: SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 24),
                                ModernStatsCard(stats: data.stats),
                                const SizedBox(height: 32),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Text(
                                    'Recent Members',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(
                                          color: AppColors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                SizedBox(
                                  height: 180,
                                  child: ListView.builder(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: data.members.length,
                                    itemBuilder: (context, index) {
                                      final dashboardMember =
                                          data.members[index];
                                      final member = Member(
                                        id: dashboardMember.id,
                                        name: dashboardMember.name,
                                        email: dashboardMember.email,
                                        avatar: dashboardMember.avatar,
                                        joinedAt: dashboardMember.joinedAt,
                                        plan: dashboardMember.plan,
                                        membershipExpiryDate: dashboardMember
                                            .membershipExpiryDate,
                                        height: dashboardMember.height,
                                        weight: dashboardMember.weight,
                                        bodyFat: dashboardMember.bodyFat,
                                        muscleMass: dashboardMember.muscleMass,
                                        bmi: dashboardMember.bmi,
                                        trainerName:
                                            dashboardMember.trainerName,
                                        lastCheckIn:
                                            dashboardMember.lastCheckIn,
                                        daysPresent:
                                            dashboardMember.daysPresent,
                                        weeklyWorkoutGoal:
                                            dashboardMember.weeklyWorkoutGoal,
                                        measurements:
                                            dashboardMember.measurements,
                                        currentStreak:
                                            dashboardMember.currentStreak,
                                      );
                                      return ModernMemberCard(
                                        member: member,
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(height: 32),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Text(
                                    'Quick Actions',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(
                                          color: AppColors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: GridView.count(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 16,
                                    crossAxisSpacing: 16,
                                    children: [
                                      ModernQuickActionCard(
                                        icon: Icons.assessment,
                                        title: 'New Assessment',
                                        color: AppColors.success,
                                        onTap: () =>
                                            context.push('/assessment/pending'),
                                      ),
                                      ModernQuickActionCard(
                                        icon: Icons.fitness_center,
                                        title: 'Workouts',
                                        color: AppColors.warning,
                                        onTap: () => context.push('/workouts'),
                                      ),
                                      ModernQuickActionCard(
                                        icon: Icons.restaurant_menu,
                                        title: 'Meal Planning',
                                        color: AppColors.info,
                                        onTap: () =>
                                            context.push('/nutrition/plan'),
                                      ),
                                      ModernQuickActionCard(
                                        icon: Icons.calendar_today,
                                        title: 'Schedule Session',
                                        color: AppColors.accent,
                                        onTap: () =>
                                            context.push('/schedule/new'),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 32),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Text(
                                    'Recent Activity',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(
                                          color: AppColors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.4,
                                    child: ActivityTimeline(
                                      activities: data.activities,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 24),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
            );
          }
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: const Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            ),
          );
        },
      ),
    );
  }
}
