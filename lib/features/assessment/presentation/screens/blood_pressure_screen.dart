import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/colors.dart';
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

  final List<String> _bpCategories = [
    'Normal',
    'Elevated',
    'Stage 1 Hypertension',
    'Stage 2 Hypertension',
    'Hypertensive Crisis',
  ];

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
      context.read<BloodPressureBloc>().add(
            SaveBloodPressure(
              systolic: int.parse(_systolicController.text),
              diastolic: int.parse(_diastolicController.text),
              pulse: int.parse(_pulseController.text),
              restingHeartRate: int.parse(_restingHeartRateController.text),
              bpCategory: context.read<BloodPressureBloc>().state
                      is BloodPressureInitial
                  ? (context.read<BloodPressureBloc>().state
                          as BloodPressureInitial)
                      .bpCategory
                  : 'Normal',
              date: widget.selectedMonth ?? DateTime.now(),
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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BloodPressureBloc, BloodPressureState>(
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
            title: const Text('Blood Pressure Assessment'),
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
                      Text(
                        'Vital Signs',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: AppColors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Enter your blood pressure readings and heart rate',
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
                                  child: TextFormField(
                                    controller: _systolicController,
                                    keyboardType: TextInputType.number,
                                    style:
                                        const TextStyle(color: AppColors.white),
                                    decoration: const InputDecoration(
                                      labelText: 'Systolic',
                                      suffixText: 'mmHg',
                                      hintText: '120',
                                    ),
                                    validator: _validateNumber,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: TextFormField(
                                    controller: _diastolicController,
                                    keyboardType: TextInputType.number,
                                    style:
                                        const TextStyle(color: AppColors.white),
                                    decoration: const InputDecoration(
                                      labelText: 'Diastolic',
                                      suffixText: 'mmHg',
                                      hintText: '80',
                                    ),
                                    validator: _validateNumber,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: _pulseController,
                                    keyboardType: TextInputType.number,
                                    style:
                                        const TextStyle(color: AppColors.white),
                                    decoration: const InputDecoration(
                                      labelText: 'Pulse',
                                      suffixText: 'bpm',
                                      hintText: '72',
                                    ),
                                    validator: _validateNumber,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: TextFormField(
                                    controller: _restingHeartRateController,
                                    keyboardType: TextInputType.number,
                                    style:
                                        const TextStyle(color: AppColors.white),
                                    decoration: const InputDecoration(
                                      labelText: 'Resting Heart Rate',
                                      suffixText: 'bpm',
                                      hintText: '65',
                                    ),
                                    validator: _validateNumber,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'BP Category',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: AppColors.white,
                              fontWeight: FontWeight.bold,
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
                        child: DropdownButtonFormField<String>(
                          value: state is BloodPressureInitial
                              ? state.bpCategory
                              : 'Normal',
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 16),
                          ),
                          dropdownColor: AppColors.darkCard,
                          style: const TextStyle(color: AppColors.white),
                          items: _bpCategories.map((category) {
                            return DropdownMenuItem(
                              value: category,
                              child: Text(category),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value != null) {
                              context.read<BloodPressureBloc>().add(
                                    UpdateBPCategory(value),
                                  );
                            }
                          },
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
                              'Save',
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
          ),
        );
      },
    );
  }
}
