import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/colors.dart';
import '../../../../widgets/measurement_input_field.dart';
import '../bloc/cardio_fitness/cardio_fitness_bloc.dart';
import '../../domain/entities/vital_signs.dart';
import '../../domain/entities/body_measurements.dart';

import '../../domain/entities/muscular_endurance.dart';
import '../../domain/entities/flexibility_tests.dart';
import '../../domain/usecases/save_assessment.dart';

class CardioFitnessScreen extends StatefulWidget {
  final DateTime? selectedMonth;

  const CardioFitnessScreen({
    super.key,
    this.selectedMonth,
  });

  @override
  State<CardioFitnessScreen> createState() => _CardioFitnessScreenState();
}

class _CardioFitnessScreenState extends State<CardioFitnessScreen> {
  final _formKey = GlobalKey<FormState>();

  // Rockport Test Controllers
  final _timeController = TextEditingController();
  final _distanceController = TextEditingController();
  final _pulseController = TextEditingController();
  final _vo2maxController = TextEditingController();

  // YMCA Step Test Controllers
  final _ymcaHeartRateController = TextEditingController();

  final List<String> _fitnessCategories = [
    'Excellent',
    'Good',
    'Above Average',
    'Average',
    'Below Average',
    'Poor',
  ];

  @override
  void dispose() {
    _timeController.dispose();
    _distanceController.dispose();
    _pulseController.dispose();
    _vo2maxController.dispose();
    _ymcaHeartRateController.dispose();
    super.dispose();
  }

  void _handleNext() {
    if (_formKey.currentState!.validate()) {
      context.read<CardioFitnessBloc>().add(
            SaveCardioFitness(
              time: double.parse(_timeController.text),
              distance: double.parse(_distanceController.text),
              pulse: int.parse(_pulseController.text),
              vo2max: double.parse(_vo2maxController.text),
              rockportFitnessCategory: context.read<CardioFitnessBloc>().state
                      is CardioFitnessInitial
                  ? (context.read<CardioFitnessBloc>().state
                          as CardioFitnessInitial)
                      .rockportFitnessCategory
                  : 'Average',
              ymcaHeartRate: int.parse(_ymcaHeartRateController.text),
              ymcaFitnessCategory: context.read<CardioFitnessBloc>().state
                      is CardioFitnessInitial
                  ? (context.read<CardioFitnessBloc>().state
                          as CardioFitnessInitial)
                      .ymcaFitnessCategory
                  : 'Average',
              date: widget.selectedMonth ?? DateTime.now(),
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
              muscularEndurance: const MuscularEndurance(
                pushUps: 0,
                pushUpType: '',
                squats: 0,
                squatType: '',
                pullUps: 0,
              ),
              flexibilityTests: const FlexibilityTests(
                quadriceps: false,
                hamstring: false,
                hipFlexors: false,
                shoulderMobility: false,
                sitAndReach: false,
              ),
            ),
          );
    }
  }

  String? _validateNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    if (double.tryParse(value) == null) {
      return 'Please enter a valid number';
    }
    return null;
  }

  Widget _buildTestSection(
      String title, String description, List<Widget> fields) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          description,
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
            children: fields,
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CardioFitnessBloc(
        saveAssessment: context.read<SaveAssessment>(),
      ),
      child: BlocConsumer<CardioFitnessBloc, CardioFitnessState>(
        listener: (context, state) {
          if (state is CardioFitnessSaved) {
            context.pop();
          } else if (state is CardioFitnessError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Cardio-Respiratory Fitness'),
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
                        _buildTestSection(
                          'Rockport 1-Mile Test',
                          'Record your performance for the 1-mile walk test',
                          [
                            MeasurementInputField(
                              label: 'Time',
                              controller: _timeController,
                              unit: 'minutes',
                              textInputAction: TextInputAction.next,
                            ),
                            const SizedBox(height: 16),
                            MeasurementInputField(
                              label: 'Distance',
                              controller: _distanceController,
                              unit: 'miles',
                              textInputAction: TextInputAction.next,
                            ),
                            const SizedBox(height: 16),
                            MeasurementInputField(
                              label: 'Post-test Pulse',
                              controller: _pulseController,
                              unit: 'bpm',
                              textInputAction: TextInputAction.next,
                            ),
                            const SizedBox(height: 16),
                            MeasurementInputField(
                              label: 'VO2 Max',
                              controller: _vo2maxController,
                              unit: 'ml/kg/min',
                              textInputAction: TextInputAction.next,
                            ),
                            const SizedBox(height: 16),
                            BlocBuilder<CardioFitnessBloc, CardioFitnessState>(
                              builder: (context, state) {
                                return DropdownButtonFormField<String>(
                                  value: state is CardioFitnessInitial
                                      ? state.rockportFitnessCategory
                                      : 'Average',
                                  decoration: const InputDecoration(
                                    labelText: 'Fitness Category',
                                    border: InputBorder.none,
                                  ),
                                  dropdownColor: AppColors.darkCard,
                                  style:
                                      const TextStyle(color: AppColors.white),
                                  items: _fitnessCategories.map((category) {
                                    return DropdownMenuItem(
                                      value: category,
                                      child: Text(category),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    if (value != null) {
                                      context.read<CardioFitnessBloc>().add(
                                            UpdateRockportCategory(value),
                                          );
                                    }
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                        _buildTestSection(
                          'YMCA Step Test',
                          'Record your heart rate after completing the 3-minute step test',
                          [
                            MeasurementInputField(
                              label: 'Heart Rate',
                              controller: _ymcaHeartRateController,
                              unit: 'bpm',
                              textInputAction: TextInputAction.next,
                            ),
                            const SizedBox(height: 16),
                            BlocBuilder<CardioFitnessBloc, CardioFitnessState>(
                              builder: (context, state) {
                                return DropdownButtonFormField<String>(
                                  value: state is CardioFitnessInitial
                                      ? state.ymcaFitnessCategory
                                      : 'Average',
                                  decoration: const InputDecoration(
                                    labelText: 'Fitness Category',
                                    border: InputBorder.none,
                                  ),
                                  dropdownColor: AppColors.darkCard,
                                  style:
                                      const TextStyle(color: AppColors.white),
                                  items: _fitnessCategories.map((category) {
                                    return DropdownMenuItem(
                                      value: category,
                                      child: Text(category),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    if (value != null) {
                                      context.read<CardioFitnessBloc>().add(
                                            UpdateYmcaCategory(value),
                                          );
                                    }
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: state is! CardioFitnessSaving
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
                              if (state is CardioFitnessSaving) ...[
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
                              if (state is! CardioFitnessSaving) ...[
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
      ),
    );
  }
}
