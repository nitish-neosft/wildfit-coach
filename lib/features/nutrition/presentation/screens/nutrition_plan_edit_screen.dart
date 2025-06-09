import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/colors.dart';
import '../../domain/entities/nutrition_plan.dart';
import '../bloc/nutrition_bloc.dart';
import '../widgets/nutrition_plan_form.dart';

class NutritionPlanEditScreen extends StatelessWidget {
  final String memberId;
  final NutritionPlan? plan;

  const NutritionPlanEditScreen({
    super.key,
    required this.memberId,
    this.plan,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            plan == null ? 'Create Nutrition Plan' : 'Edit Nutrition Plan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: NutritionPlanForm(
          nutritionPlan: plan,
          memberId: memberId,
          onSubmit: (plan) {
            context.read<NutritionBloc>().add(
                  CreateNewNutritionPlan(nutritionPlan: plan),
                );
          },
        ),
      ),
    );
  }
}
