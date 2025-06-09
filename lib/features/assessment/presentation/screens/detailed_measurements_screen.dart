import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/colors.dart';
import '../../../../widgets/measurement_input_field.dart';
import '../bloc/detailed_measurements/detailed_measurements_bloc.dart';
import '../../../../core/di/injection_container.dart' as di;
import '../../domain/entities/vital_signs.dart';
import '../../domain/entities/body_measurements.dart';

class DetailedMeasurementsScreen extends StatefulWidget {
  final String memberId;
  final DateTime? selectedMonth;

  const DetailedMeasurementsScreen({
    required this.memberId,
    super.key,
    this.selectedMonth,
  });

  @override
  State<DetailedMeasurementsScreen> createState() =>
      _DetailedMeasurementsScreenState();
}

class _DetailedMeasurementsScreenState
    extends State<DetailedMeasurementsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final _armController = TextEditingController();
  final _calfController = TextEditingController();
  final _forearmController = TextEditingController();
  final _midThighController = TextEditingController();
  final _chestController = TextEditingController();
  final _abdomenController = TextEditingController();
  final _hipsController = TextEditingController();
  final _waistController = TextEditingController();
  final _neckController = TextEditingController();

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    _armController.dispose();
    _calfController.dispose();
    _forearmController.dispose();
    _midThighController.dispose();
    _chestController.dispose();
    _abdomenController.dispose();
    _hipsController.dispose();
    _waistController.dispose();
    _neckController.dispose();
    super.dispose();
  }

  void _handleNext() {
    if (_formKey.currentState!.validate()) {
      context.read<DetailedMeasurementsBloc>().add(
            SaveDetailedMeasurements(
              vitalSigns: VitalSigns(
                bloodPressure: '',
                restingHeartRate: 0,
                bpCategory: '',
              ),
              bodyMeasurements: BodyMeasurements(
                height: double.parse(_heightController.text),
                weight: double.parse(_weightController.text),
                arms: double.parse(_armController.text),
                calf: double.parse(_calfController.text),
                forearm: double.parse(_forearmController.text),
                midThigh: double.parse(_midThighController.text),
                chest: double.parse(_chestController.text),
                waist: double.parse(_waistController.text),
                hips: double.parse(_hipsController.text),
                neck: double.parse(_neckController.text),
              ),
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailedMeasurementsBloc(
        saveAssessment: di.sl(),
        memberId: widget.memberId,
      ),
      child: BlocConsumer<DetailedMeasurementsBloc, DetailedMeasurementsState>(
        listener: (context, state) {
          if (state is DetailedMeasurementsSaved) {
            context.pop();
          } else if (state is DetailedMeasurementsError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Detailed Measurements'),
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
                        'Body Measurements',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: AppColors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Enter all measurements in cm',
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
                                    label: 'Height',
                                    controller: _heightController,
                                    unit: 'cm',
                                    textInputAction: TextInputAction.next,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: MeasurementInputField(
                                    label: 'Weight',
                                    controller: _weightController,
                                    unit: 'kg',
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
                                    label: 'Arm',
                                    controller: _armController,
                                    unit: 'cm',
                                    textInputAction: TextInputAction.next,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: MeasurementInputField(
                                    label: 'Calf',
                                    controller: _calfController,
                                    unit: 'cm',
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
                                    label: 'Forearm',
                                    controller: _forearmController,
                                    unit: 'cm',
                                    textInputAction: TextInputAction.next,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: MeasurementInputField(
                                    label: 'Mid-Thigh',
                                    controller: _midThighController,
                                    unit: 'cm',
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
                                    label: 'Chest',
                                    controller: _chestController,
                                    unit: 'cm',
                                    textInputAction: TextInputAction.next,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: MeasurementInputField(
                                    label: 'Abdomen',
                                    controller: _abdomenController,
                                    unit: 'cm',
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
                                    label: 'Hips',
                                    controller: _hipsController,
                                    unit: 'cm',
                                    textInputAction: TextInputAction.next,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: MeasurementInputField(
                                    label: 'Waist',
                                    controller: _waistController,
                                    unit: 'cm',
                                    textInputAction: TextInputAction.next,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            MeasurementInputField(
                              label: 'Neck',
                              controller: _neckController,
                              unit: 'cm',
                              textInputAction: TextInputAction.done,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 48),
                      ElevatedButton(
                        onPressed: state is! DetailedMeasurementsSaving
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
                            if (state is DetailedMeasurementsSaving) ...[
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
                            if (state is! DetailedMeasurementsSaving) ...[
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
