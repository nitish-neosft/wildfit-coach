import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/di/injection_container.dart';
import '../widgets/member_details/index.dart';
import '../../domain/entities/member.dart';
import '../bloc/member/member_bloc.dart';
import '../bloc/member/member_state.dart';
import '../bloc/member/member_event.dart';

class MemberDetailsScreen extends StatelessWidget {
  final String memberId;

  const MemberDetailsScreen({
    super.key,
    required this.memberId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<MemberBloc>()..add(LoadMemberDetails(memberId)),
      child: Scaffold(
        backgroundColor: const Color(0xFF1A1C1E),
        appBar: AppBar(
          backgroundColor: AppColors.darkBackground,
          elevation: 0,
          title: const Text('Member Details'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.pop(),
          ),
        ),
        body: BlocBuilder<MemberBloc, MemberState>(
          builder: (context, state) {
            if (state is MemberLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                ),
              );
            }
            if (state is MemberError) {
              return Center(
                child: Text(
                  'Error: ${state.message}',
                  style: const TextStyle(color: Colors.white),
                ),
              );
            }
            if (state is MemberLoaded) {
              final member = state.member;
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildProfileHeader(member),
                    const SizedBox(height: 24),
                    _buildQuickStats(member),
                    const SizedBox(height: 24),
                    MembershipDetailsCard(member: member),
                    const SizedBox(height: 16),
                    MemberCardsSection(member: member),
                    const SizedBox(height: 16),
                    _buildHealthMetrics(member),
                    const SizedBox(height: 16),
                    _buildGoals(member),
                    const SizedBox(height: 16),
                    AssessmentHistoryCard(
                      title: 'Blood Pressure',
                      icon: Icons.favorite,
                      color: Colors.red,
                      assessments: const [],
                      onAddTap: () =>
                          _showMonthPicker(context, '/blood-pressure'),
                    ),
                    const SizedBox(height: 16),
                    AssessmentHistoryCard(
                      title: 'Cardio Fitness',
                      icon: Icons.directions_run,
                      color: Colors.green,
                      assessments: const [],
                      onAddTap: () =>
                          _showMonthPicker(context, '/cardio-fitness'),
                    ),
                    const SizedBox(height: 16),
                    AssessmentHistoryCard(
                      title: 'Muscular Flexibility',
                      icon: Icons.accessibility_new,
                      color: Colors.orange,
                      assessments: const [],
                      onAddTap: () =>
                          _showMonthPicker(context, '/muscular-flexibility'),
                    ),
                    const SizedBox(height: 16),
                    AssessmentHistoryCard(
                      title: 'Detailed Measurements',
                      icon: Icons.straighten,
                      color: Colors.blue,
                      assessments: const [],
                      onAddTap: () =>
                          _showMonthPicker(context, '/detailed-measurements'),
                    ),
                    Card(
                      child: ListTile(
                        leading: const Icon(Icons.fitness_center),
                        title: const Text('Workout Plans'),
                        subtitle: Text(
                          member.activePrograms != null &&
                                  member.activePrograms! > 0
                              ? '${member.activePrograms} Active Plans'
                              : 'No active plans',
                        ),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () =>
                            context.push('/workout-plans/member/${member.id}'),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Card(
                      child: ListTile(
                        leading: const Icon(Icons.restaurant_menu),
                        title: const Text('Nutrition Plans'),
                        subtitle: Text(
                          member.activeNutritionPlans != null &&
                                  member.activeNutritionPlans! > 0
                              ? '${member.activeNutritionPlans} Active Plans'
                              : 'No active plans',
                        ),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () => context
                            .push('/nutrition-plans/member/${member.id}'),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildProfileHeader(Member member) {
    return Card(
      color: AppColors.darkCard,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(member.avatar ?? ''),
            ),
            const SizedBox(height: 16),
            Text(
              member.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              member.email,
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 16,
              ),
            ),
            if (member.phone != null) ...[
              const SizedBox(height: 8),
              Text(
                member.phone!,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 16,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildQuickStats(Member member) {
    return Card(
      color: AppColors.darkCard,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Quick Stats',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatItem(
                  icon: Icons.calendar_today,
                  label: 'Member Since',
                  value: _formatDate(member.joinedAt),
                  color: AppColors.primary,
                ),
                _buildStatItem(
                  icon: Icons.local_fire_department,
                  label: 'Current Streak',
                  value: '${member.currentStreak ?? 0} days',
                  color: AppColors.warning,
                ),
                _buildStatItem(
                  icon: Icons.fitness_center,
                  label: 'Active Programs',
                  value: '${member.activePrograms ?? 0}',
                  color: AppColors.success,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Icon(
          icon,
          color: color,
          size: 24,
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return '${months[date.month - 1]} ${date.year}';
  }

  void _showMonthPicker(BuildContext context, String route) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Select Month for Assessment',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              // Show last 3 months
              ...List.generate(3, (index) {
                final month =
                    DateTime.now().subtract(Duration(days: index * 30));
                final monthStart = DateTime(month.year, month.month, 1);
                return ListTile(
                  title: Text(
                    '${_getMonthName(month.month)} ${month.year}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    context.push(route, extra: monthStart);
                  },
                );
              }),
            ],
          ),
        );
      },
    );
  }

  String _getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[month - 1];
  }

  Widget _buildHealthMetrics(Member member) {
    return Card(
      color: AppColors.darkCard,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Health Metrics',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Last Updated: ${_formatDate(member.lastCheckIn ?? DateTime.now())}',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildMetricItem(
                  icon: Icons.height,
                  label: 'Height',
                  value: '${member.height} cm',
                  color: AppColors.primary,
                ),
                _buildMetricItem(
                  icon: Icons.monitor_weight,
                  label: 'Weight',
                  value: '${member.weight} kg',
                  color: AppColors.warning,
                ),
                _buildMetricItem(
                  icon: Icons.speed,
                  label: 'BMI',
                  value: member.bmi?.toStringAsFixed(1) ?? 'N/A',
                  color: AppColors.success,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildMetricItem(
                  icon: Icons.percent,
                  label: 'Body Fat',
                  value: member.bodyFat != null ? '${member.bodyFat}%' : 'N/A',
                  color: AppColors.error,
                ),
                _buildMetricItem(
                  icon: Icons.fitness_center,
                  label: 'Muscle Mass',
                  value: member.muscleMass != null
                      ? '${member.muscleMass} kg'
                      : 'N/A',
                  color: AppColors.info,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGoals(Member member) {
    return Card(
      color: AppColors.darkCard,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Goals & Progress',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildGoalItem(
              icon: Icons.monitor_weight,
              label: 'Weight Goal',
              current: member.weight,
              target: member.weightGoal,
              unit: 'kg',
            ),
            const SizedBox(height: 12),
            _buildGoalItem(
              icon: Icons.percent,
              label: 'Body Fat Goal',
              current: member.bodyFat,
              target: member.bodyFatGoal,
              unit: '%',
            ),
            const SizedBox(height: 12),
            _buildGoalItem(
              icon: Icons.calendar_today,
              label: 'Weekly Workouts',
              current: member.daysPresent?.toDouble(),
              target: member.weeklyWorkoutGoal?.toDouble(),
              unit: 'days',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Icon(
          icon,
          color: color,
          size: 24,
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildGoalItem({
    required IconData icon,
    required String label,
    required double? current,
    required double? target,
    required String unit,
  }) {
    final progress = (current != null && target != null)
        ? (current / target).clamp(0.0, 1.0)
        : 0.0;
    final formattedCurrent = current?.toStringAsFixed(1) ?? 'N/A';
    final formattedTarget = target?.toStringAsFixed(1) ?? 'N/A';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: AppColors.primary,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: progress,
                  backgroundColor: AppColors.darkSurface,
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(AppColors.primary),
                  minHeight: 8,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Text(
              '$formattedCurrent / $formattedTarget $unit',
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
