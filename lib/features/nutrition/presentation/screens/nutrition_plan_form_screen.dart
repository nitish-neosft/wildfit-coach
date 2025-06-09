import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/colors.dart';
import '../../domain/entities/nutrition_plan.dart';
import '../bloc/nutrition_bloc.dart';
import '../widgets/nutrition_plan_form.dart';

class NutritionPlanFormScreen extends StatelessWidget {
  final String memberId;
  final NutritionPlan? nutritionPlan;

  const NutritionPlanFormScreen({
    Key? key,
    required this.memberId,
    this.nutritionPlan,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        title: Text(
          nutritionPlan == null ? 'Create Plan' : 'Edit Plan',
        ),
      ),
      body: BlocListener<NutritionBloc, NutritionState>(
        listener: (context, state) {
          if (state is NutritionPlanCreated) {
            Navigator.pop(context);
          } else if (state is NutritionError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: NutritionPlanForm(
          memberId: memberId,
          nutritionPlan: nutritionPlan,
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
