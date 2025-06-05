import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/colors.dart';
import '../../../../widgets/measurement_input_field.dart';
import '../bloc/blood_pressure/blood_pressure_bloc.dart';
import '../../domain/usecases/save_assessment.dart';

class BloodPressureScreen extends StatefulWidget {
  final DateTime? selectedMonth;

  const BloodPressureScreen({
    super.key,
    this.selectedMonth,
  });

  @override
  State<BloodPressureScreen> createState() => _BloodPressureScreenState();
}

class _BloodPressureScreenState extends State<BloodPressureScreen> {
  final _formKey = GlobalKey<FormState>();
  final _systolicController = TextEditingController();
  final _diastolicController = TextEditingController();
  final _pulseController = TextEditingController();
  final _restingHeartRateController = TextEditingController();

  @override
  void dispose() {
    _systolicController.dispose();
    _diastolicController.dispose();
    _pulseController.dispose();
    _restingHeartRateController.dispose();
    super.dispose();
  }

  void _handleNext() {
    if (_formKey.currentState!.validate()) {
      final systolic = int.parse(_systolicController.text);
      final diastolic = int.parse(_diastolicController.text);
      final pulse = int.parse(_pulseController.text);
      final restingHeartRate = int.parse(_restingHeartRateController.text);

      String bpCategory;
      if (systolic < 120 && diastolic < 80) {
        bpCategory = 'Normal';
      } else if (systolic < 130 && diastolic < 80) {
        bpCategory = 'Elevated';
      } else if (systolic < 140 || diastolic < 90) {
        bpCategory = 'Stage 1 Hypertension';
      } else {
        bpCategory = 'Stage 2 Hypertension';
      }

      context.read<BloodPressureBloc>().add(
            SaveBloodPressure(
              systolic: systolic,
              diastolic: diastolic,
              pulse: pulse,
              restingHeartRate: restingHeartRate,
              bpCategory: bpCategory,
              date: widget.selectedMonth ?? DateTime.now(),
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BloodPressureBloc(
        saveAssessment: context.read<SaveAssessment>(),
      ),
      child: BlocConsumer<BloodPressureBloc, BloodPressureState>(
        listener: (context, state) {
          if (state is BloodPressureSaved) {
            context.pop();
          } else if (state is BloodPressureError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Blood Pressure'),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Blood Pressure & Heart Rate',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: AppColors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Enter your blood pressure and heart rate measurements',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.darkGrey,
                            ),
                      ),
                      const SizedBox(height: 24),
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
                            Row(
                              children: [
                                Expanded(
                                  child: MeasurementInputField(
                                    label: 'Systolic',
                                    controller: _systolicController,
                                    unit: 'mmHg',
                                    textInputAction: TextInputAction.next,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: MeasurementInputField(
                                    label: 'Diastolic',
                                    controller: _diastolicController,
                                    unit: 'mmHg',
                                    textInputAction: TextInputAction.next,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: MeasurementInputField(
                                    label: 'Pulse',
                                    controller: _pulseController,
                                    unit: 'bpm',
                                    textInputAction: TextInputAction.next,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: MeasurementInputField(
                                    label: 'Resting Heart Rate',
                                    controller: _restingHeartRateController,
                                    unit: 'bpm',
                                    textInputAction: TextInputAction.done,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 48),
                      ElevatedButton(
                        onPressed:
                            state is! BloodPressureSaving ? _handleNext : null,
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
                            if (state is BloodPressureSaving) ...[
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
                            if (state is! BloodPressureSaving) ...[
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
