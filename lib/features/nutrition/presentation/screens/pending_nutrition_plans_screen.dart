import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/colors.dart';
import '../../domain/entities/nutrition_plan.dart';
import '../bloc/nutrition_bloc.dart';
import '../widgets/nutrition_plan_card.dart';
import '../widgets/member_nutrition_list.dart';

class PendingNutritionPlansScreen extends StatefulWidget {
  const PendingNutritionPlansScreen({super.key});

  @override
  State<PendingNutritionPlansScreen> createState() =>
      _PendingNutritionPlansScreenState();
}

class _PendingNutritionPlansScreenState
    extends State<PendingNutritionPlansScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        title: const Text('Nutrition Plans'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Members'),
            Tab(text: 'Pending Plans'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/nutrition-plans/new'),
          ),
        ],
      ),
      body: BlocBuilder<NutritionBloc, NutritionState>(
        builder: (context, state) {
          if (state is NutritionInitial) {
            context.read<NutritionBloc>()
              ..add(const LoadNutritionPlans())
              ..add(const LoadMembersNeedingPlans());
          }

          if (state is NutritionLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
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
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppColors.white,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<NutritionBloc>()
                        ..add(const LoadNutritionPlans())
                        ..add(const LoadMembersNeedingPlans());
                    },
                    child: const Text('Try Again'),
                  ),
                ],
              ),
            );
          }

          return TabBarView(
            controller: _tabController,
            children: [
              // Members Tab
              if (state is MembersNeedingPlansLoaded)
                MemberNutritionList(
                  members: state.members,
                  onMemberTap: (memberId) {
                    // Show bottom sheet with pending plans to assign
                    if (state is NutritionPlansLoaded) {
                      _showAssignPlanBottomSheet(
                        context,
                        memberId,
                        (state as NutritionPlansLoaded)
                            .plans
                            .where((plan) => !plan.isActive)
                            .toList(),
                      );
                    }
                  },
                )
              else
                const Center(child: CircularProgressIndicator()),

              // Pending Plans Tab
              if (state is NutritionPlansLoaded)
                RefreshIndicator(
                  onRefresh: () async {
                    context.read<NutritionBloc>()
                      ..add(const LoadNutritionPlans())
                      ..add(const LoadMembersNeedingPlans());
                  },
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount:
                        state.plans.where((plan) => !plan.isActive).length,
                    itemBuilder: (context, index) {
                      final pendingPlans =
                          state.plans.where((plan) => !plan.isActive).toList();
                      final plan = pendingPlans[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: NutritionPlanCard(
                          nutritionPlan: plan,
                          onTap: () => context.push(
                            '/nutrition-plans/detail/${plan.id}',
                            extra: {'plan': plan},
                          ),
                          onEdit: () => context.push(
                            '/nutrition-plans/${plan.id}/edit',
                            extra: {'plan': plan},
                          ),
                          onDelete: () {
                            context.read<NutritionBloc>().add(
                                  DeleteNutritionPlanEvent(
                                    planId: plan.id,
                                    memberId: plan.memberId,
                                  ),
                                );
                          },
                        ),
                      );
                    },
                  ),
                )
              else
                const Center(child: CircularProgressIndicator()),
            ],
          );
        },
      ),
    );
  }

  void _showAssignPlanBottomSheet(
    BuildContext context,
    String memberId,
    List<NutritionPlan> pendingPlans,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.darkCard,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select a Plan to Assign',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.white,
                  ),
            ),
            const SizedBox(height: 16),
            if (pendingPlans.isEmpty)
              Center(
                child: Text(
                  'No pending plans available',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.white.withOpacity(0.7),
                      ),
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: pendingPlans.length,
                  itemBuilder: (context, index) {
                    final plan = pendingPlans[index];
                    return ListTile(
                      title: Text(
                        plan.name,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: AppColors.white,
                                ),
                      ),
                      subtitle: Text(
                        plan.description,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.white.withOpacity(0.7),
                            ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      onTap: () {
                        context.read<NutritionBloc>().add(
                              AssignNutritionPlanToMember(
                                memberId: memberId,
                                planId: plan.id,
                              ),
                            );
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
