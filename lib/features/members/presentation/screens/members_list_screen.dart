import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/di/injection_container.dart';
import '../../../dashboard/presentation/widgets/modern_member_card.dart';
import '../../../dashboard/presentation/bloc/dashboard_bloc.dart';
import '../../../members/domain/entities/member.dart';

class MembersListScreen extends StatefulWidget {
  const MembersListScreen({super.key});

  @override
  State<MembersListScreen> createState() => _MembersListScreenState();
}

class _MembersListScreenState extends State<MembersListScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedFilter = 'All';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Member> _filterMembers(List<Member> members) {
    return members.where((member) {
      final matchesSearch =
          member.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              member.email.toLowerCase().contains(_searchQuery.toLowerCase());

      if (_selectedFilter == 'All') {
        return matchesSearch;
      } else {
        return matchesSearch && member.plan == _selectedFilter;
      }
    }).toList();
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.darkCard,
          title: const Text(
            'Filter by Plan',
            style: TextStyle(color: AppColors.white),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              'All',
              'Basic',
              'Premium',
              'Pro',
            ].map((filter) {
              return ListTile(
                title: Text(
                  filter,
                  style: const TextStyle(color: AppColors.white),
                ),
                selected: _selectedFilter == filter,
                selectedTileColor: AppColors.primary.withOpacity(0.1),
                onTap: () {
                  setState(() {
                    _selectedFilter = filter;
                  });
                  context.pop();
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<DashboardBloc>()..add(LoadMembers()),
      child: Scaffold(
        backgroundColor: AppColors.darkBackground,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'Active Members',
            style: TextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      style: const TextStyle(color: AppColors.white),
                      decoration: InputDecoration(
                        hintText: 'Search members...',
                        hintStyle: TextStyle(
                          color: AppColors.white.withOpacity(0.5),
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: AppColors.white.withOpacity(0.5),
                        ),
                        filled: true,
                        fillColor: AppColors.darkCard,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.darkCard,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      icon:
                          const Icon(Icons.filter_list, color: AppColors.white),
                      onPressed: _showFilterDialog,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<DashboardBloc, DashboardState>(
                builder: (context, state) {
                  if (state is DashboardLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    );
                  }

                  if (state is DashboardError ||
                      state is DashboardAuthError ||
                      state is DashboardNetworkError) {
                    final message = state is DashboardError
                        ? state.message
                        : state is DashboardAuthError
                            ? state.message
                            : (state as DashboardNetworkError).message;
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Error: $message',
                            style: const TextStyle(
                              color: AppColors.error,
                            ),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              context.read<DashboardBloc>().add(LoadMembers());
                            },
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  }

                  if (state is MembersLoaded) {
                    final filteredMembers = _filterMembers(state.members);

                    if (filteredMembers.isEmpty) {
                      return Center(
                        child: Text(
                          _searchQuery.isEmpty && _selectedFilter == 'All'
                              ? 'No active members found'
                              : 'No members match your search',
                          style: const TextStyle(
                            color: AppColors.white,
                          ),
                        ),
                      );
                    }

                    return RefreshIndicator(
                      onRefresh: () async {
                        context.read<DashboardBloc>().add(LoadMembers());
                      },
                      child: GridView.builder(
                        padding: const EdgeInsets.all(16),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.75,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                        itemCount: filteredMembers.length,
                        itemBuilder: (context, index) {
                          final dashboardMember = filteredMembers[index];
                          // Convert DashboardMember to Member
                          final member = Member(
                            id: dashboardMember.id,
                            name: dashboardMember.name,
                            email: dashboardMember.email,
                            avatar: dashboardMember.avatar,
                            joinedAt: dashboardMember.joinedAt,
                            plan: dashboardMember.plan,
                            membershipExpiryDate:
                                dashboardMember.membershipExpiryDate,
                            height: dashboardMember.height,
                            weight: dashboardMember.weight,
                            bodyFat: dashboardMember.bodyFat,
                            muscleMass: dashboardMember.muscleMass,
                            bmi: dashboardMember.bmi,
                            trainerName: dashboardMember.trainerName,
                            lastCheckIn: dashboardMember.lastCheckIn,
                            daysPresent: dashboardMember.daysPresent,
                            weeklyWorkoutGoal:
                                dashboardMember.weeklyWorkoutGoal,
                            measurements: dashboardMember.measurements,
                            currentStreak: dashboardMember.currentStreak,
                          );
                          return ModernMemberCard(member: member);
                        },
                      ),
                    );
                  }

                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // TODO: Implement add new member functionality
            context.push('/members/new');
          },
          backgroundColor: AppColors.primary,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
