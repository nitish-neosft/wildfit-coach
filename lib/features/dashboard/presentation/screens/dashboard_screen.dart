import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/constants/colors.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_state.dart';
import '../bloc/dashboard_bloc.dart';
import '../widgets/stats_card.dart';
import '../widgets/member_card.dart';
import '../widgets/quick_action_card.dart';
import '../widgets/activity_timeline.dart';
import '../widgets/network_image.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<DashboardBloc>()..add(LoadDashboard()),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, authState) {
          if (authState is Authenticated && authState.user != null) {
            final user = authState.user!;
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
                          backgroundColor: AppColors.darkBackground,
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
                            IconButton(
                              icon: Stack(
                                children: [
                                  const Icon(
                                    Icons.notifications_outlined,
                                    color: AppColors.white,
                                  ),
                                  if (data.activities.isNotEmpty)
                                    Positioned(
                                      right: 0,
                                      top: 0,
                                      child: Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: const BoxDecoration(
                                          color: AppColors.error,
                                          shape: BoxShape.circle,
                                        ),
                                        constraints: const BoxConstraints(
                                          minWidth: 8,
                                          minHeight: 8,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              onPressed: () => context.push('/notifications'),
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
                        body: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                StatsCard(stats: data.stats),
                                const SizedBox(height: 24),
                                Text(
                                  'Recent Members',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                        color: AppColors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                const SizedBox(height: 16),
                                SizedBox(
                                  height: 160,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: data.members.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(right: 16),
                                        child: MemberCard(
                                          member: data.members[index],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(height: 24),
                                Text(
                                  'Quick Actions',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                        color: AppColors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                const SizedBox(height: 16),
                                GridView.count(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 16,
                                  crossAxisSpacing: 16,
                                  children: [
                                    QuickActionCard(
                                      icon: Icons.assessment,
                                      title: 'New Assessment',
                                      onTap: () =>
                                          context.push('/assessment/new'),
                                    ),
                                    QuickActionCard(
                                      icon: Icons.fitness_center,
                                      title: 'Create Workout',
                                      onTap: () => context.push('/workout/new'),
                                    ),
                                    QuickActionCard(
                                      icon: Icons.restaurant_menu,
                                      title: 'Meal Planning',
                                      onTap: () =>
                                          context.push('/nutrition/plan'),
                                    ),
                                    QuickActionCard(
                                      icon: Icons.calendar_today,
                                      title: 'Schedule Session',
                                      onTap: () =>
                                          context.push('/schedule/new'),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 24),
                                Text(
                                  'Recent Activity',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                        color: AppColors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                const SizedBox(height: 16),
                                ActivityTimeline(
                                  activities: data.activities,
                                ),
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
