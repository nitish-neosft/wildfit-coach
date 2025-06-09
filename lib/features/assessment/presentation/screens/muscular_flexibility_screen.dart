import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/loading_view.dart';
import '../../domain/entities/vital_signs.dart';
import '../bloc/muscular_flexibility/muscular_flexibility_bloc.dart';

class MuscularFlexibilityScreen extends StatefulWidget {
  final String memberId;
  final DateTime? selectedMonth;

  const MuscularFlexibilityScreen({
    required this.memberId,
    this.selectedMonth,
    super.key,
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
  String _pushUpType = 'Standard';
  String _squatType = 'Body Weight';
  final Map<String, bool> _flexibilityTests = {
    'Quadriceps': false,
    'Hamstring': false,
    'Hip Flexors': false,
    'Shoulder Mobility': false,
    'Sit and Reach': false,
  };

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

  @override
  void dispose() {
    _pushUpsController.dispose();
    _squatsController.dispose();
    _pullUpsController.dispose();
    super.dispose();
  }

  void _onSave() {
    if (_formKey.currentState!.validate()) {
      final pushUps = int.parse(_pushUpsController.text);
      final squats = int.parse(_squatsController.text);
      final pullUps = int.parse(_pullUpsController.text);

      final vitalSigns = VitalSigns(
        bloodPressure: 'N/A',
        restingHeartRate: 0,
        bpCategory: 'N/A',
      );

      context.read<MuscularFlexibilityBloc>().add(
            SaveMuscularFlexibility(
              vitalSigns: vitalSigns,
              pushUps: pushUps,
              pushUpType: _pushUpType,
              squats: squats,
              squatType: _squatType,
              pullUps: pullUps,
              quadricepsPass: _flexibilityTests['Quadriceps']!,
              hamstringPass: _flexibilityTests['Hamstring']!,
              hipFlexorsPass: _flexibilityTests['Hip Flexors']!,
              shoulderMobilityPass: _flexibilityTests['Shoulder Mobility']!,
              sitAndReachPass: _flexibilityTests['Sit and Reach']!,
            ),
          );
    }
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
          body: state is MuscularFlexibilitySaving
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
                            controller: _pushUpsController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Push-ups',
                              hintText: 'Enter number of push-ups',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter number of push-ups';
                              }
                              final pushUps = int.tryParse(value);
                              if (pushUps == null ||
                                  pushUps < 0 ||
                                  pushUps > 100) {
                                return 'Please enter a valid number (0-100)';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          DropdownButtonFormField<String>(
                            value: _pushUpType,
                            decoration: const InputDecoration(
                              labelText: 'Push-up Type',
                            ),
                            items: _pushUpTypes.map((type) {
                              return DropdownMenuItem(
                                value: type,
                                child: Text(type),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _pushUpType = value!;
                              });
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _squatsController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Squats',
                              hintText: 'Enter number of squats',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter number of squats';
                              }
                              final squats = int.tryParse(value);
                              if (squats == null ||
                                  squats < 0 ||
                                  squats > 100) {
                                return 'Please enter a valid number (0-100)';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          DropdownButtonFormField<String>(
                            value: _squatType,
                            decoration: const InputDecoration(
                              labelText: 'Squat Type',
                            ),
                            items: _squatTypes.map((type) {
                              return DropdownMenuItem(
                                value: type,
                                child: Text(type),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _squatType = value!;
                              });
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _pullUpsController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Pull-ups',
                              hintText: 'Enter number of pull-ups',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter number of pull-ups';
                              }
                              final pullUps = int.tryParse(value);
                              if (pullUps == null ||
                                  pullUps < 0 ||
                                  pullUps > 50) {
                                return 'Please enter a valid number (0-50)';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 24),
                          const Text(
                            'Flexibility Tests',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          ..._flexibilityTests.entries.map((entry) {
                            return CheckboxListTile(
                              title: Text(entry.key),
                              value: entry.value,
                              onChanged: (value) {
                                setState(() {
                                  _flexibilityTests[entry.key] = value!;
                                });
                              },
                            );
                          }).toList(),
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
