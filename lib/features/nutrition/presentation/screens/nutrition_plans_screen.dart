import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/colors.dart';
import '../bloc/nutrition_bloc.dart';
import '../widgets/nutrition_plan_card.dart';

class NutritionPlansScreen extends StatelessWidget {
  final String memberId;

  const NutritionPlansScreen({
    Key? key,
    required this.memberId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        title: const Text('Nutrition Plans'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push(
              '/nutrition-plans/new',
              extra: {'memberId': memberId},
            ),
          ),
        ],
      ),
      body: BlocBuilder<NutritionBloc, NutritionState>(
        builder: (context, state) {
          if (state is NutritionInitial) {
            context
                .read<NutritionBloc>()
                .add(LoadMemberNutritionPlans(memberId));
          }

          if (state is NutritionLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is NutritionError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 48,
                    color: Colors.red,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    state.message,
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context
                          .read<NutritionBloc>()
                          .add(LoadMemberNutritionPlans(memberId));
                    },
                    child: const Text('Try Again'),
                  ),
                ],
              ),
            );
          }

          if (state is NutritionPlansLoaded) {
            if (state.plans.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.restaurant_menu,
                      size: 64,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No nutrition plans yet',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Create a new nutrition plan to get started',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () => context.push(
                        '/nutrition-plans/new',
                        extra: {'memberId': memberId},
                      ),
                      icon: const Icon(Icons.add),
                      label: const Text('Create Plan'),
                    ),
                  ],
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: () async {
                context
                    .read<NutritionBloc>()
                    .add(LoadMemberNutritionPlans(memberId));
              },
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.plans.length,
                itemBuilder: (context, index) {
                  final plan = state.plans[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: NutritionPlanCard(
                      nutritionPlan: plan,
                      onTap: () => context.push(
                        '/nutrition-plans/detail/${plan.id}',
                        extra: {'memberId': memberId, 'plan': plan},
                      ),
                      onEdit: () => context.push(
                        '/nutrition-plans/${plan.id}/edit',
                        extra: {'memberId': memberId, 'plan': plan},
                      ),
                      onDelete: () {
                        context.read<NutritionBloc>().add(
                              DeleteNutritionPlanEvent(
                                planId: plan.id,
                                memberId: memberId,
                              ),
                            );
                      },
                    ),
                  );
                },
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
