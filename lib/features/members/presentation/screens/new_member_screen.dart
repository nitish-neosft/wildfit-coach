import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/di/injection_container.dart';
import '../../../dashboard/presentation/bloc/dashboard_bloc.dart';
import '../../domain/entities/member.dart';

class NewMemberScreen extends StatefulWidget {
  const NewMemberScreen({super.key});

  @override
  State<NewMemberScreen> createState() => _NewMemberScreenState();
}

class _NewMemberScreenState extends State<NewMemberScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  String _selectedPlan = 'Basic';
  double _height = 170.0;
  double _weight = 70.0;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Add New Member',
          style: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                style: const TextStyle(color: AppColors.white),
                decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: TextStyle(
                    color: AppColors.white.withOpacity(0.7),
                  ),
                  filled: true,
                  fillColor: AppColors.darkCard,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                style: const TextStyle(color: AppColors.white),
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(
                    color: AppColors.white.withOpacity(0.7),
                  ),
                  filled: true,
                  fillColor: AppColors.darkCard,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              Text(
                'Membership Plan',
                style: TextStyle(
                  color: AppColors.white.withOpacity(0.7),
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.darkCard,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    'Basic',
                    'Premium',
                    'Pro',
                  ].map((plan) {
                    return RadioListTile<String>(
                      title: Text(
                        plan,
                        style: const TextStyle(color: AppColors.white),
                      ),
                      value: plan,
                      groupValue: _selectedPlan,
                      onChanged: (value) {
                        setState(() {
                          _selectedPlan = value!;
                        });
                      },
                      activeColor: AppColors.primary,
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Height (cm)',
                style: TextStyle(
                  color: AppColors.white.withOpacity(0.7),
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.darkCard,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Slider(
                        value: _height,
                        min: 100,
                        max: 220,
                        divisions: 120,
                        label: _height.round().toString(),
                        onChanged: (value) {
                          setState(() {
                            _height = value;
                          });
                        },
                        activeColor: AppColors.primary,
                      ),
                    ),
                    Text(
                      '${_height.round()} cm',
                      style: const TextStyle(
                        color: AppColors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Weight (kg)',
                style: TextStyle(
                  color: AppColors.white.withOpacity(0.7),
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.darkCard,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Slider(
                        value: _weight,
                        min: 30,
                        max: 200,
                        divisions: 170,
                        label: _weight.round().toString(),
                        onChanged: (value) {
                          setState(() {
                            _weight = value;
                          });
                        },
                        activeColor: AppColors.primary,
                      ),
                    ),
                    Text(
                      '${_weight.round()} kg',
                      style: const TextStyle(
                        color: AppColors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final newMember = Member(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      name: _nameController.text,
                      email: _emailController.text,
                      avatar: null,
                      joinedAt: DateTime.now(),
                      plan: _selectedPlan,
                      membershipExpiryDate:
                          DateTime.now().add(const Duration(days: 365)),
                      height: _height,
                      weight: _weight,
                      bodyFat: 0,
                      muscleMass: 0,
                      bmi: _weight / ((_height / 100) * (_height / 100)),
                      trainerName: '',
                      lastCheckIn: null,
                      daysPresent: 0,
                      weeklyWorkoutGoal: 3,
                      measurements: {},
                      currentStreak: 0,
                    );

                    // TODO: Implement create member functionality
                    context.pop();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Add Member',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
