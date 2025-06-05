import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/colors.dart';
import '../../../../widgets/test_result_row.dart';
import '../bloc/muscular_flexibility/muscular_flexibility_bloc.dart';
import '../../domain/usecases/save_assessment.dart';
import '../../domain/entities/muscular_endurance.dart';
import '../../domain/entities/flexibility_tests.dart';

class MuscularFlexibilityScreen extends StatefulWidget {
  final DateTime? selectedMonth;

  const MuscularFlexibilityScreen({
    super.key,
    this.selectedMonth,
  });

  @override
  State<MuscularFlexibilityScreen> createState() =>
      _MuscularFlexibilityScreenState();
}

class _MuscularFlexibilityScreenState extends State<MuscularFlexibilityScreen> {
  final _formKey = GlobalKey<FormState>();
  final _pushUpsController = TextEditingController();
  final _squatsController = TextEditingController();
  final _pullUpsController = TextEditingController();

  final List<String> _pushUpTypes = [
    'Standard',
    'Modified',
    'Wall',
  ];

  final List<String> _squatTypes = [
    'Body Weight',
    'Weighted',
    'Assisted',
  ];

  final Map<String, bool> _flexibilityTests = {
    'Quadriceps Flexibility': false,
    'Hamstring Flexibility': false,
    'Hip Flexors Mobility': false,
    'Shoulder Mobility': false,
    'Sit and Reach': false,
  };

  @override
  void dispose() {
    _pushUpsController.dispose();
    _squatsController.dispose();
    _pullUpsController.dispose();
    super.dispose();
  }

  void _handleNext() {
    if (_formKey.currentState!.validate()) {
      final state = context.read<MuscularFlexibilityBloc>().state;
      final pushUpType =
          state is MuscularFlexibilityInitial ? state.pushUpType : 'Standard';
      final squatType =
          state is MuscularFlexibilityInitial ? state.squatType : 'Body Weight';

      final muscularEndurance = MuscularEndurance(
        pushUps: int.parse(_pushUpsController.text),
        pushUpType: pushUpType,
        squats: int.parse(_squatsController.text),
        squatType: squatType,
        pullUps: int.parse(_pullUpsController.text),
      );

      final flexibilityTests = FlexibilityTests(
        quadriceps: _flexibilityTests['Quadriceps Flexibility']!,
        hamstring: _flexibilityTests['Hamstring Flexibility']!,
        hipFlexors: _flexibilityTests['Hip Flexors Mobility']!,
        shoulderMobility: _flexibilityTests['Shoulder Mobility']!,
        sitAndReach: _flexibilityTests['Sit and Reach']!,
      );

      context.read<MuscularFlexibilityBloc>().add(
            SaveMuscularFlexibility(
              pushUps: muscularEndurance.pushUps,
              pushUpType: muscularEndurance.pushUpType,
              squats: muscularEndurance.squats,
              squatType: muscularEndurance.squatType,
              pullUps: muscularEndurance.pullUps,
              quadricepsPass: flexibilityTests.quadriceps,
              hamstringPass: flexibilityTests.hamstring,
              hipFlexorsPass: flexibilityTests.hipFlexors,
              shoulderMobilityPass: flexibilityTests.shoulderMobility,
              sitAndReachPass: flexibilityTests.sitAndReach,
              date: widget.selectedMonth ?? DateTime.now(),
            ),
          );
    }
  }

  String? _validateNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    if (int.tryParse(value) == null) {
      return 'Please enter a valid number';
    }
    return null;
  }

  Widget _buildEnduranceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Muscular Endurance',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Record your performance for each exercise',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.darkGrey,
              ),
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: AppColors.darkCard,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.darkDivider,
              width: 1,
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              BlocBuilder<MuscularFlexibilityBloc, MuscularFlexibilityState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      DropdownButtonFormField<String>(
                        value: state is MuscularFlexibilityInitial
                            ? state.pushUpType
                            : 'Standard',
                        decoration: const InputDecoration(
                          labelText: 'Push-up Type',
                        ),
                        dropdownColor: AppColors.darkCard,
                        style: const TextStyle(color: AppColors.white),
                        items: _pushUpTypes.map((type) {
                          return DropdownMenuItem(
                            value: type,
                            child: Text(type),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            context.read<MuscularFlexibilityBloc>().add(
                                  UpdatePushUpType(value),
                                );
                          }
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _pushUpsController,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: AppColors.white),
                        decoration: const InputDecoration(
                          labelText: 'Push-up Repetitions',
                          hintText: '20',
                        ),
                        validator: _validateNumber,
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 24),
              BlocBuilder<MuscularFlexibilityBloc, MuscularFlexibilityState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      DropdownButtonFormField<String>(
                        value: state is MuscularFlexibilityInitial
                            ? state.squatType
                            : 'Body Weight',
                        decoration: const InputDecoration(
                          labelText: 'Squat Type',
                        ),
                        dropdownColor: AppColors.darkCard,
                        style: const TextStyle(color: AppColors.white),
                        items: _squatTypes.map((type) {
                          return DropdownMenuItem(
                            value: type,
                            child: Text(type),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            context.read<MuscularFlexibilityBloc>().add(
                                  UpdateSquatType(value),
                                );
                          }
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _squatsController,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: AppColors.white),
                        decoration: const InputDecoration(
                          labelText: 'Squat Repetitions',
                          hintText: '25',
                        ),
                        validator: _validateNumber,
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _pullUpsController,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: AppColors.white),
                decoration: const InputDecoration(
                  labelText: 'TRX Pull-ups',
                  hintText: '10',
                ),
                validator: _validateNumber,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFlexibilitySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Flexibility Tests',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Mark each test as pass or fail',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.darkGrey,
              ),
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: AppColors.darkCard,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.darkDivider,
              width: 1,
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TestResultsList(
                testResults: _flexibilityTests,
                onTestTap: (test, currentValue) {
                  setState(() {
                    _flexibilityTests[test] = !currentValue;
                  });
                },
              ),
              const SizedBox(height: 16),
              TestResultsSummary(
                testResults: _flexibilityTests,
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MuscularFlexibilityBloc(
        saveAssessment: context.read<SaveAssessment>(),
      ),
      child: BlocConsumer<MuscularFlexibilityBloc, MuscularFlexibilityState>(
        listener: (context, state) {
          if (state is MuscularFlexibilitySaved) {
            context.pop();
          } else if (state is MuscularFlexibilityError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Muscular Flexibility'),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildEnduranceSection(),
                      const SizedBox(height: 32),
                      _buildFlexibilitySection(),
                      const SizedBox(height: 48),
                      ElevatedButton(
                        onPressed: state is! MuscularFlexibilitySaving
                            ? _handleNext
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.white,
                          minimumSize: const Size(double.infinity, 56),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (state is MuscularFlexibilitySaving) ...[
                              const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  color: AppColors.white,
                                  strokeWidth: 2,
                                ),
                              ),
                              const SizedBox(width: 12),
                            ],
                            const Text(
                              'Continue',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (state is! MuscularFlexibilitySaving) ...[
                              const SizedBox(width: 8),
                              const Icon(Icons.arrow_forward),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
