import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/loading_view.dart';
import '../bloc/blood_pressure/blood_pressure_bloc.dart';

class BloodPressureScreen extends StatefulWidget {
  final String memberId;
  final DateTime? selectedMonth;

  const BloodPressureScreen({
    required this.memberId,
    this.selectedMonth,
    super.key,
  });

  @override
  State<BloodPressureScreen> createState() => _BloodPressureScreenState();
}

class _BloodPressureScreenState extends State<BloodPressureScreen> {
  final _formKey = GlobalKey<FormState>();
  final _systolicController = TextEditingController();
  final _diastolicController = TextEditingController();
  final _restingHeartRateController = TextEditingController();

  @override
  void dispose() {
    _systolicController.dispose();
    _diastolicController.dispose();
    _restingHeartRateController.dispose();
    super.dispose();
  }

  String _getBPCategory(int systolic, int diastolic) {
    if (systolic < 120 && diastolic < 80) {
      return 'Normal';
    } else if (systolic < 130 && diastolic < 80) {
      return 'Elevated';
    } else if (systolic < 140 || diastolic < 90) {
      return 'Stage 1 Hypertension';
    } else {
      return 'Stage 2 Hypertension';
    }
  }

  void _onSave() {
    if (_formKey.currentState!.validate()) {
      final systolic = int.parse(_systolicController.text);
      final diastolic = int.parse(_diastolicController.text);
      final restingHeartRate = int.parse(_restingHeartRateController.text);
      final bpCategory = _getBPCategory(systolic, diastolic);

      context.read<BloodPressureBloc>().add(
            SaveBloodPressure(
              systolic: systolic,
              diastolic: diastolic,
              restingHeartRate: restingHeartRate,
              bpCategory: bpCategory,
            ),
          );
    }
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
          body: state is BloodPressureSaving
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
                            controller: _systolicController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Systolic (mmHg)',
                              hintText: 'Enter systolic blood pressure',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter systolic blood pressure';
                              }
                              final systolic = int.tryParse(value);
                              if (systolic == null ||
                                  systolic < 70 ||
                                  systolic > 200) {
                                return 'Please enter a valid systolic blood pressure (70-200)';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _diastolicController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Diastolic (mmHg)',
                              hintText: 'Enter diastolic blood pressure',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter diastolic blood pressure';
                              }
                              final diastolic = int.tryParse(value);
                              if (diastolic == null ||
                                  diastolic < 40 ||
                                  diastolic > 130) {
                                return 'Please enter a valid diastolic blood pressure (40-130)';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _restingHeartRateController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Resting Heart Rate (bpm)',
                              hintText: 'Enter resting heart rate',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter resting heart rate';
                              }
                              final restingHeartRate = int.tryParse(value);
                              if (restingHeartRate == null ||
                                  restingHeartRate < 40 ||
                                  restingHeartRate > 200) {
                                return 'Please enter a valid resting heart rate (40-200)';
                              }
                              return null;
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
