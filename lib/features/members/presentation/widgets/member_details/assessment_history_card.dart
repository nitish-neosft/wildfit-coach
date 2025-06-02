import 'package:flutter/material.dart';
import '../../../../../core/constants/colors.dart';
import '../../../domain/models/member.dart';

class AssessmentHistoryCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final List<Assessment> assessments;
  final VoidCallback onAddTap;

  const AssessmentHistoryCard({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.assessments,
    required this.onAddTap,
  });

  void _showAssessmentDetails(BuildContext context, Assessment assessment) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.7,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          expand: false,
          builder: (context, scrollController) {
            return Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Assessment Details',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const Divider(),
                  Expanded(
                    child: ListView(
                      controller: scrollController,
                      children: [
                        _buildAssessmentDetailsContent(assessment),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildAssessmentDetailsContent(Assessment assessment) {
    switch (assessment.type) {
      case AssessmentType.bloodPressure:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('Date', _formatDate(assessment.date)),
            _buildDetailRow('Blood Pressure',
                '${assessment.data['systolic']}/${assessment.data['diastolic']} mmHg'),
            _buildDetailRow('Category', assessment.data['bpCategory']),
            _buildDetailRow('Pulse', '${assessment.data['pulse']} bpm'),
            _buildDetailRow('Resting Heart Rate',
                '${assessment.data['restingHeartRate']} bpm'),
          ],
        );

      case AssessmentType.cardioFitness:
        final rockportTest =
            assessment.data['rockportTest'] as Map<String, dynamic>;
        final ymcaTest =
            assessment.data['ymcaStepTest'] as Map<String, dynamic>;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('Date', _formatDate(assessment.date)),
            const Text(
              'Rockport Test',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildDetailRow('Time', '${rockportTest['time']} minutes'),
            _buildDetailRow('Distance', '${rockportTest['distance']} km'),
            _buildDetailRow('Pulse', '${rockportTest['pulse']} bpm'),
            _buildDetailRow('VO2 Max', '${rockportTest['vo2max']} ml/kg/min'),
            _buildDetailRow(
                'Fitness Category', rockportTest['fitnessCategory']),
            const SizedBox(height: 16),
            const Text(
              'YMCA Step Test',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildDetailRow('Heart Rate', '${ymcaTest['heartRate']} bpm'),
            _buildDetailRow('Fitness Category', ymcaTest['fitnessCategory']),
          ],
        );

      case AssessmentType.muscularFlexibility:
        final testResults = assessment.data['testResults'] as Map<String, bool>;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('Date', _formatDate(assessment.date)),
            const Text(
              'Flexibility Test Results',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...testResults.entries.map((e) => _buildTestResultRow(
                  e.key.replaceAll(RegExp(r'(?=[A-Z])'), ' '),
                  e.value,
                )),
          ],
        );

      case AssessmentType.detailedMeasurements:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('Date', _formatDate(assessment.date)),
            _buildDetailRow('Height', '${assessment.data['height']} cm'),
            _buildDetailRow('Weight', '${assessment.data['weight']} kg'),
            _buildDetailRow(
                'Body Fat', '${assessment.data['bodyFatPercentage']}%'),
            const SizedBox(height: 16),
            const Text(
              'Circumference Measurements',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildDetailRow('Chest', '${assessment.data['chest']} cm'),
            _buildDetailRow('Waist', '${assessment.data['waist']} cm'),
            _buildDetailRow('Hips', '${assessment.data['hips']} cm'),
            _buildDetailRow('Arms', '${assessment.data['arms']} cm'),
            _buildDetailRow('Forearm', '${assessment.data['forearm']} cm'),
            _buildDetailRow('Neck', '${assessment.data['neck']} cm'),
            _buildDetailRow('Calf', '${assessment.data['calf']} cm'),
            _buildDetailRow('Mid-Thigh', '${assessment.data['midThigh']} cm'),
          ],
        );
    }
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTestResultRow(String test, bool passed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            test,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          Icon(
            passed ? Icons.check_circle : Icons.cancel,
            color: passed ? AppColors.success : AppColors.error,
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${_getMonthName(date.month)} ${date.day}, ${date.year}';
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

  AssessmentType _getAssessmentType(String title) {
    switch (title) {
      case 'Blood Pressure':
        return AssessmentType.bloodPressure;
      case 'Cardio Fitness':
        return AssessmentType.cardioFitness;
      case 'Muscular Flexibility':
        return AssessmentType.muscularFlexibility;
      case 'Detailed Measurements':
        return AssessmentType.detailedMeasurements;
      default:
        throw Exception('Unknown assessment type: $title');
    }
  }

  String _getAssessmentSummary(Assessment assessment) {
    switch (assessment.type) {
      case AssessmentType.bloodPressure:
        final systolic = assessment.data['systolic'];
        final diastolic = assessment.data['diastolic'];
        return 'BP: $systolic/$diastolic mmHg';
      case AssessmentType.cardioFitness:
        final vo2max = assessment.data['rockportTest']?['vo2max'] ??
            assessment.data['vo2max'];
        return 'VO2 Max: $vo2max ml/kg/min';
      case AssessmentType.muscularFlexibility:
        final passedTests =
            (assessment.data['testResults'] as Map<String, bool>)
                .values
                .where((passed) => passed)
                .length;
        return '$passedTests/5 tests passed';
      case AssessmentType.detailedMeasurements:
        final weight = assessment.data['weight'];
        final bodyFat = assessment.data['bodyFatPercentage'];
        return 'Weight: $weight kg, Body Fat: $bodyFat%';
    }
  }

  @override
  Widget build(BuildContext context) {
    // Sort assessments by date in descending order and take last 3
    final recentAssessments = assessments
        .where((a) => a.type == _getAssessmentType(title))
        .toList()
      ..sort((a, b) => b.date.compareTo(a.date));
    final last3Months = recentAssessments.take(3).toList();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(icon, color: color),
                    const SizedBox(width: 8),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline),
                  color: AppColors.primary,
                  onPressed: onAddTap,
                ),
              ],
            ),
            if (last3Months.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  'No assessments yet',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: last3Months.length,
                itemBuilder: (context, index) {
                  final assessment = last3Months[index];
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      '${_getMonthName(assessment.date.month)} ${assessment.date.year}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Text(
                      _getAssessmentSummary(assessment),
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.chevron_right),
                      onPressed: () =>
                          _showAssessmentDetails(context, assessment),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
