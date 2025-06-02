import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/colors.dart';
import '../bloc/muscular_flexibility/muscular_flexibility_bloc.dart';
import '../../domain/entities/muscular_endurance.dart';
import '../../domain/entities/flexibility_tests.dart';
import '../../domain/entities/vital_signs.dart';
import '../../domain/entities/body_measurements.dart';
import '../../domain/entities/cardio_fitness.dart';
import '../../domain/entities/user_assessment.dart';
import '../../domain/usecases/save_assessment.dart';

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
    'Barbell Press',
  ];

  final List<String> _squatTypes = [
    'Body Weight',
    'Weighted',
  ];

  @override
  void dispose() {
    _pushUpsController.dispose();
    _squatsController.dispose();
    _pullUpsController.dispose();
    super.dispose();
  }

  void _handleFinish() {
    if (_formKey.currentState!.validate()) {
      final muscularEndurance = MuscularEndurance(
        pushUps: int.parse(_pushUpsController.text),
        pushUpType: context.read<MuscularFlexibilityBloc>().state
                is MuscularFlexibilityInitial
            ? (context.read<MuscularFlexibilityBloc>().state
                    as MuscularFlexibilityInitial)
                .pushUpType
            : 'Standard',
        squats: int.parse(_squatsController.text),
        squatType: context.read<MuscularFlexibilityBloc>().state
                is MuscularFlexibilityInitial
            ? (context.read<MuscularFlexibilityBloc>().state
                    as MuscularFlexibilityInitial)
                .squatType
            : 'Body Weight',
        pullUps: int.parse(_pullUpsController.text),
      );

      final flexibilityTests = FlexibilityTests(
        quadriceps: context.read<MuscularFlexibilityBloc>().state
                is MuscularFlexibilityInitial
            ? (context.read<MuscularFlexibilityBloc>().state
                        as MuscularFlexibilityInitial)
                    .flexibilityTests['quadriceps'] ??
                false
            : false,
        hamstring: context.read<MuscularFlexibilityBloc>().state
                is MuscularFlexibilityInitial
            ? (context.read<MuscularFlexibilityBloc>().state
                        as MuscularFlexibilityInitial)
                    .flexibilityTests['hamstring'] ??
                false
            : false,
        hipFlexors: context.read<MuscularFlexibilityBloc>().state
                is MuscularFlexibilityInitial
            ? (context.read<MuscularFlexibilityBloc>().state
                        as MuscularFlexibilityInitial)
                    .flexibilityTests['hipFlexors'] ??
                false
            : false,
        shoulderMobility: context.read<MuscularFlexibilityBloc>().state
                is MuscularFlexibilityInitial
            ? (context.read<MuscularFlexibilityBloc>().state
                        as MuscularFlexibilityInitial)
                    .flexibilityTests['shoulderMobility'] ??
                false
            : false,
        sitAndReach: context.read<MuscularFlexibilityBloc>().state
                is MuscularFlexibilityInitial
            ? (context.read<MuscularFlexibilityBloc>().state
                        as MuscularFlexibilityInitial)
                    .flexibilityTests['sitAndReach'] ??
                false
            : false,
      );

      final assessment = UserAssessment(
        name:
            'Muscular Flexibility Assessment ${widget.selectedMonth ?? DateTime.now()}',
        vitalSigns: const VitalSigns(
          bloodPressure: '',
          restingHeartRate: 0,
          bpCategory: '',
        ),
        bodyMeasurements: const BodyMeasurements(
          height: 0,
          weight: 0,
          chest: 0,
          waist: 0,
          hips: 0,
          arms: 0,
          neck: 0,
          forearm: 0,
          calf: 0,
          midThigh: 0,
        ),
        cardioFitness: const CardioFitness(
          vo2Max: 0,
          rockportTestResult: '',
          ymcaStepTestResult: '',
          ymcaHeartRate: 0,
        ),
        muscularEndurance: muscularEndurance,
        flexibilityTests: flexibilityTests,
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

  Widget _buildMuscularEnduranceSection() {
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
          child: BlocBuilder<MuscularFlexibilityBloc, MuscularFlexibilityState>(
            builder: (context, state) {
              final tests = state is MuscularFlexibilityInitial
                  ? state.flexibilityTests
                  : const {
                      'quadriceps': false,
                      'hamstring': false,
                      'hipFlexors': false,
                      'shoulderMobility': false,
                      'sitAndReach': false,
                    };

              return Column(
                children: [
                  _buildFlexibilityTest(
                      'Quadriceps', tests['quadriceps'] ?? false),
                  const Divider(color: AppColors.darkDivider),
                  _buildFlexibilityTest(
                      'Hamstring', tests['hamstring'] ?? false),
                  const Divider(color: AppColors.darkDivider),
                  _buildFlexibilityTest(
                      'Hip Flexors', tests['hipFlexors'] ?? false),
                  const Divider(color: AppColors.darkDivider),
                  _buildFlexibilityTest(
                      'Shoulder Mobility', tests['shoulderMobility'] ?? false),
                  const Divider(color: AppColors.darkDivider),
                  _buildFlexibilityTest(
                      'Sit and Reach', tests['sitAndReach'] ?? false),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFlexibilityTest(String test, bool passed) {
    // Convert display name to state key
    String stateKey =
        test.toLowerCase().replaceAll(' and ', 'And').replaceAll(' ', '');

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            test,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 16,
            ),
          ),
          Row(
            children: [
              OutlinedButton(
                onPressed: () {
                  context.read<MuscularFlexibilityBloc>().add(
                        UpdateFlexibilityTest(
                          test: stateKey,
                          passed: true,
                        ),
                      );
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor:
                      passed ? AppColors.primary : Colors.transparent,
                  side: BorderSide(
                    color: passed ? AppColors.primary : AppColors.darkDivider,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Pass',
                  style: TextStyle(
                    color: passed ? AppColors.white : AppColors.darkGrey,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              OutlinedButton(
                onPressed: () {
                  context.read<MuscularFlexibilityBloc>().add(
                        UpdateFlexibilityTest(
                          test: stateKey,
                          passed: false,
                        ),
                      );
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: !passed ? Colors.red : Colors.transparent,
                  side: BorderSide(
                    color: !passed ? Colors.red : AppColors.darkDivider,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  'Fail',
                  style: TextStyle(
                    color: !passed ? AppColors.white : AppColors.darkGrey,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MuscularFlexibilityBloc, MuscularFlexibilityState>(
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
            title: const Text('Muscular Flexibility Assessment'),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildMuscularEnduranceSection(),
                      const SizedBox(height: 32),
                      _buildFlexibilitySection(),
                      const SizedBox(height: 48),
                      ElevatedButton(
                        onPressed: state is! MuscularFlexibilitySaving
                            ? _handleFinish
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
                              'Save',
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
          ),
        );
      },
    );
  }
}
