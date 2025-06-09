import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/loading_view.dart';
import '../../../members/domain/entities/member.dart';
import '../bloc/pending_assessments/pending_assessments_bloc.dart';

class PendingAssessmentsScreen extends StatelessWidget {
  const PendingAssessmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pending Assessments'),
      ),
      body: BlocBuilder<PendingAssessmentsBloc, PendingAssessmentsState>(
        builder: (context, state) {
          if (state is PendingAssessmentsLoading) {
            return const LoadingView();
          } else if (state is PendingAssessmentsError) {
            return ErrorView(message: state.message);
          } else if (state is PendingAssessmentsLoaded) {
            return _buildContent(context, state.membersWithPendingAssessments);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, List<Member> members) {
    if (members.isEmpty) {
      return const Center(
        child: Text(
          'No pending assessments',
          style: TextStyle(fontSize: 16),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: members.length,
      itemBuilder: (context, index) {
        final member = members[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            leading: CircleAvatar(
              backgroundColor: AppColors.primary,
              child: Text(
                member.name[0].toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Text(
              member.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Text(
                  'Pending Assessments:',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Wrap(
                  spacing: 8,
                  children: _buildPendingAssessmentChips(member),
                ),
              ],
            ),
            onTap: () => _onMemberTap(context, member),
          ),
        );
      },
    );
  }

  List<Widget> _buildPendingAssessmentChips(Member member) {
    final pendingAssessments = _getPendingAssessments(member);
    return pendingAssessments.map((type) {
      return Chip(
        backgroundColor: AppColors.primary.withOpacity(0.1),
        label: Text(
          type,
          style: const TextStyle(
            color: AppColors.primary,
            fontSize: 12,
          ),
        ),
      );
    }).toList();
  }

  List<String> _getPendingAssessments(Member member) {
    final List<String> pending = [];

    // Check which assessments are pending based on member data
    if (!member.hasBloodPressureAssessment) {
      pending.add('Blood Pressure');
    }
    if (!member.hasCardioFitnessAssessment) {
      pending.add('Cardio Fitness');
    }
    if (!member.hasMuscularFlexibilityAssessment) {
      pending.add('Muscular Flexibility');
    }
    if (!member.hasDetailedMeasurementsAssessment) {
      pending.add('Detailed Measurements');
    }

    return pending;
  }

  void _onMemberTap(BuildContext context, Member member) {
    showModalBottomSheet(
      context: context,
      builder: (context) => _AssessmentTypeSelector(member: member),
    );
  }
}

class _AssessmentTypeSelector extends StatelessWidget {
  final Member member;

  const _AssessmentTypeSelector({required this.member});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Assessment Type',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          ..._buildAssessmentOptions(context),
        ],
      ),
    );
  }

  List<Widget> _buildAssessmentOptions(BuildContext context) {
    final pendingAssessments = _getPendingAssessments();
    return pendingAssessments.map((type) {
      return ListTile(
        leading: const Icon(Icons.assessment, color: AppColors.primary),
        title: Text(type),
        onTap: () => _startAssessment(context, type),
      );
    }).toList();
  }

  List<String> _getPendingAssessments() {
    final List<String> pending = [];

    if (!member.hasBloodPressureAssessment) {
      pending.add('Blood Pressure');
    }
    if (!member.hasCardioFitnessAssessment) {
      pending.add('Cardio Fitness');
    }
    if (!member.hasMuscularFlexibilityAssessment) {
      pending.add('Muscular Flexibility');
    }
    if (!member.hasDetailedMeasurementsAssessment) {
      pending.add('Detailed Measurements');
    }

    return pending;
  }

  void _startAssessment(BuildContext context, String type) {
    context.pop(); // Close bottom sheet

    switch (type) {
      case 'Blood Pressure':
        context.push('/assessment/blood-pressure/${member.id}');
        break;
      case 'Cardio Fitness':
        context.push('/assessment/cardio-fitness/${member.id}');
        break;
      case 'Muscular Flexibility':
        context.push('/assessment/muscular-flexibility/${member.id}');
        break;
      case 'Detailed Measurements':
        context.push('/assessment/detailed-measurements/${member.id}');
        break;
    }
  }
}
