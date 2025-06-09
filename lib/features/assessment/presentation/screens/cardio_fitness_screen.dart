import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/loading_view.dart';
import '../../domain/entities/vital_signs.dart';
import '../../domain/entities/cardio_fitness.dart';
import '../bloc/cardio_fitness/cardio_fitness_bloc.dart';

class CardioFitnessScreen extends StatefulWidget {
  final String memberId;
  final DateTime? selectedMonth;

  const CardioFitnessScreen({
    required this.memberId,
    this.selectedMonth,
    super.key,
  });

  @override
  State<CardioFitnessScreen> createState() => _CardioFitnessScreenState();
}

class _CardioFitnessScreenState extends State<CardioFitnessScreen> {
  final _formKey = GlobalKey<FormState>();
  final _vo2MaxController = TextEditingController();
  final _ymcaHeartRateController = TextEditingController();
  String _rockportFitnessCategory = 'Average';
  String _ymcaFitnessCategory = 'Average';

  final List<String> _fitnessCategories = [
    'Poor',
    'Below Average',
    'Average',
    'Above Average',
    'Excellent',
  ];

  @override
  void dispose() {
    _vo2MaxController.dispose();
    _ymcaHeartRateController.dispose();
    super.dispose();
  }

  void _onSave() {
    if (_formKey.currentState!.validate()) {
      final vo2Max = double.parse(_vo2MaxController.text);
      final ymcaHeartRate = int.parse(_ymcaHeartRateController.text);

      final vitalSigns = VitalSigns(
        bloodPressure: 'N/A',
        restingHeartRate: ymcaHeartRate,
        bpCategory: 'N/A',
      );

      final cardioFitness = CardioFitness(
        vo2Max: vo2Max,
        rockportTestResult: _rockportFitnessCategory,
        ymcaStepTestResult: _ymcaFitnessCategory,
        ymcaHeartRate: ymcaHeartRate,
      );

      context.read<CardioFitnessBloc>().add(
            SaveCardioFitness(
              vitalSigns: vitalSigns,
              cardioFitness: cardioFitness,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CardioFitnessBloc, CardioFitnessState>(
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
            title: const Text('Cardio Fitness Assessment'),
          ),
          body: state is CardioFitnessSaving
              ? const LoadingView()
              : SafeArea(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            controller: _vo2MaxController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'VO2 Max (ml/kg/min)',
                              hintText: 'Enter VO2 Max',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter VO2 Max';
                              }
                              final vo2Max = double.tryParse(value);
                              if (vo2Max == null ||
                                  vo2Max < 20 ||
                                  vo2Max > 90) {
                                return 'Please enter a valid VO2 Max (20-90)';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _ymcaHeartRateController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'YMCA Heart Rate (bpm)',
                              hintText: 'Enter YMCA Heart Rate',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter YMCA Heart Rate';
                              }
                              final heartRate = int.tryParse(value);
                              if (heartRate == null ||
                                  heartRate < 40 ||
                                  heartRate > 200) {
                                return 'Please enter a valid heart rate (40-200)';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          DropdownButtonFormField<String>(
                            value: _rockportFitnessCategory,
                            decoration: const InputDecoration(
                              labelText: 'Rockport Fitness Category',
                            ),
                            items: _fitnessCategories.map((category) {
                              return DropdownMenuItem(
                                value: category,
                                child: Text(category),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _rockportFitnessCategory = value!;
                              });
                            },
                          ),
                          const SizedBox(height: 16),
                          DropdownButtonFormField<String>(
                            value: _ymcaFitnessCategory,
                            decoration: const InputDecoration(
                              labelText: 'YMCA Fitness Category',
                            ),
                            items: _fitnessCategories.map((category) {
                              return DropdownMenuItem(
                                value: category,
                                child: Text(category),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _ymcaFitnessCategory = value!;
                              });
                            },
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: _onSave,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: const Text(
                              'Save Assessment',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }
}
