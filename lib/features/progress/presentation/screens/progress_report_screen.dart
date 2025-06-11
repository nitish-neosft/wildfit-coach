import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_chart/fl_chart.dart';
import '../bloc/progress_bloc.dart';
import '../../domain/entities/progress_report.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ProgressReportScreen extends StatelessWidget {
  final String? memberId;

  const ProgressReportScreen({this.memberId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(memberId != null
            ? 'Client Progress Report'
            : 'All Clients Progress'),
      ),
      body: BlocBuilder<ProgressBloc, ProgressState>(
        builder: (context, state) {
          if (state is ProgressLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProgressError) {
            return Center(child: Text(state.message));
          } else if (state is SingleClientProgressLoaded) {
            return _SingleClientProgressView(report: state.report);
          } else if (state is AllClientsProgressLoaded) {
            return _AllClientsProgressView(reports: state.reports);
          }
          return const Center(child: Text('No data available'));
        },
      ),
    );
  }
}

class _SingleClientProgressView extends StatelessWidget {
  final ProgressReport report;

  const _SingleClientProgressView({required this.report});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ClientHeader(report: report),
          SizedBox(height: 24.h),
          _ProgressSummaryCards(report: report),
          SizedBox(height: 24.h),
          _WeightProgressChart(weightHistory: report.weightHistory),
          SizedBox(height: 24.h),
          _BodyFatProgressChart(bodyFatHistory: report.bodyFatHistory),
          SizedBox(height: 24.h),
          _AchievementsList(achievements: report.achievements),
        ],
      ),
    );
  }
}

class _ClientHeader extends StatelessWidget {
  final ProgressReport report;

  const _ClientHeader({required this.report});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 30.r,
          backgroundImage: NetworkImage(report.memberAvatar),
        ),
        SizedBox(width: 16.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              report.memberName,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              'Adherence Rate: ${(report.adherenceRate * 100).toStringAsFixed(1)}%',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ],
    );
  }
}

class _ProgressSummaryCards extends StatelessWidget {
  final ProgressReport report;

  const _ProgressSummaryCards({required this.report});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 16.h,
      crossAxisSpacing: 16.w,
      childAspectRatio: 1.5,
      children: [
        _ProgressCard(
          title: 'Weight Change',
          value: '${report.weightChange.toStringAsFixed(1)} kg',
          isPositive: report.weightChange <= 0,
        ),
        _ProgressCard(
          title: 'Body Fat Change',
          value: '${report.bodyFatChange.toStringAsFixed(1)}%',
          isPositive: report.bodyFatChange <= 0,
        ),
        _ProgressCard(
          title: 'Total Workouts',
          value: report.totalWorkouts.toString(),
          isPositive: true,
        ),
        _ProgressCard(
          title: 'Nutrition Sessions',
          value: report.totalNutritionSessions.toString(),
          isPositive: true,
        ),
      ],
    );
  }
}

class _ProgressCard extends StatelessWidget {
  final String title;
  final String value;
  final bool isPositive;

  const _ProgressCard({
    required this.title,
    required this.value,
    required this.isPositive,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                  color: isPositive ? Colors.green : Colors.red,
                  size: 20.r,
                ),
                SizedBox(width: 4.w),
                Text(
                  value,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: isPositive ? Colors.green : Colors.red,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _WeightProgressChart extends StatelessWidget {
  final List<WeightEntry> weightHistory;

  const _WeightProgressChart({required this.weightHistory});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Weight Progress',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 16.h),
            SizedBox(
              height: 200.h,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          if (value.toInt() >= 0 &&
                              value.toInt() < weightHistory.length) {
                            return Text(
                              '${weightHistory[value.toInt()].date.day}/${weightHistory[value.toInt()].date.month}',
                              style: Theme.of(context).textTheme.bodySmall,
                            );
                          }
                          return const Text('');
                        },
                      ),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  borderData: FlBorderData(show: true),
                  lineBarsData: [
                    LineChartBarData(
                      spots: weightHistory
                          .asMap()
                          .entries
                          .map((entry) => FlSpot(
                                entry.key.toDouble(),
                                entry.value.weight,
                              ))
                          .toList(),
                      isCurved: true,
                      color: Theme.of(context).primaryColor,
                      barWidth: 3,
                      dotData: FlDotData(show: true),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BodyFatProgressChart extends StatelessWidget {
  final List<BodyFatEntry> bodyFatHistory;

  const _BodyFatProgressChart({required this.bodyFatHistory});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Body Fat Progress',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 16.h),
            SizedBox(
              height: 200.h,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          if (value.toInt() >= 0 &&
                              value.toInt() < bodyFatHistory.length) {
                            return Text(
                              '${bodyFatHistory[value.toInt()].date.day}/${bodyFatHistory[value.toInt()].date.month}',
                              style: Theme.of(context).textTheme.bodySmall,
                            );
                          }
                          return const Text('');
                        },
                      ),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  borderData: FlBorderData(show: true),
                  lineBarsData: [
                    LineChartBarData(
                      spots: bodyFatHistory
                          .asMap()
                          .entries
                          .map((entry) => FlSpot(
                                entry.key.toDouble(),
                                entry.value.percentage,
                              ))
                          .toList(),
                      isCurved: true,
                      color: Colors.orange,
                      barWidth: 3,
                      dotData: FlDotData(show: true),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AchievementsList extends StatelessWidget {
  final List<String> achievements;

  const _AchievementsList({required this.achievements});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Achievements',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 16.h),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: achievements.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(
                    Icons.emoji_events,
                    color: Colors.amber,
                    size: 24.r,
                  ),
                  title: Text(achievements[index]),
                  dense: true,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _AllClientsProgressView extends StatelessWidget {
  final List<ProgressReport> reports;

  const _AllClientsProgressView({required this.reports});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: reports.length,
      itemBuilder: (context, index) {
        final report = reports[index];
        return Card(
          margin: EdgeInsets.only(bottom: 16.h),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(report.memberAvatar),
            ),
            title: Text(report.memberName),
            subtitle: Text(
              'Weight Change: ${report.weightChange.toStringAsFixed(1)} kg • '
              'Body Fat: ${report.bodyFatChange.toStringAsFixed(1)}%',
            ),
            trailing: Icon(Icons.chevron_right, size: 24.r),
            onTap: () {
              context.push('/progress/${report.memberId}');
            },
          ),
        );
      },
    );
  }
}
