import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/colors.dart';
import '../bloc/today_sessions_bloc.dart';
import '../../domain/entities/session.dart';
import '../../../../core/di/injection_container.dart' as di;

class TodaySessionsScreen extends StatelessWidget {
  const TodaySessionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<TodaySessionsBloc>()..add(LoadTodaySessions()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Today\'s Sessions'),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => context.push('/schedule-session'),
            ),
          ],
        ),
        body: BlocBuilder<TodaySessionsBloc, TodaySessionsState>(
          builder: (context, state) {
            if (state is TodaySessionsLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is TodaySessionsError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: AppColors.error),
                ),
              );
            }

            if (state is TodaySessionsLoaded) {
              if (state.sessions.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 64.w,
                        color: AppColors.white.withOpacity(0.5),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'No sessions scheduled for today',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: AppColors.white.withOpacity(0.5),
                            ),
                      ),
                      SizedBox(height: 16.h),
                      ElevatedButton.icon(
                        onPressed: () => context.push('/schedule-session'),
                        icon: const Icon(Icons.add),
                        label: const Text('Schedule a Session'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: EdgeInsets.symmetric(
                            horizontal: 24.w,
                            vertical: 12.h,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }

              return ListView.separated(
                padding: EdgeInsets.all(16.w),
                itemCount: state.sessions.length,
                separatorBuilder: (context, index) => SizedBox(height: 16.h),
                itemBuilder: (context, index) {
                  final session = state.sessions[index];
                  return _SessionCard(session: session);
                },
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class _SessionCard extends StatelessWidget {
  final Session session;

  const _SessionCard({required this.session});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.darkCard,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
        side: BorderSide(
          color: session.isCompleted
              ? AppColors.success.withOpacity(0.5)
              : AppColors.darkDivider,
        ),
      ),
      child: InkWell(
        onTap: () {
          // TODO: Navigate to session details
        },
        borderRadius: BorderRadius.circular(16.r),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: _getTypeColor(session.type).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      session.type,
                      style: TextStyle(
                        color: _getTypeColor(session.type),
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    session.time.format(context),
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              Text(
                session.title,
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (session.notes != null) ...[
                SizedBox(height: 4.h),
                Text(
                  session.notes!,
                  style: TextStyle(
                    color: AppColors.white.withOpacity(0.7),
                    fontSize: 14.sp,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              if (session.memberName != null) ...[
                SizedBox(height: 12.h),
                Row(
                  children: [
                    if (session.memberAvatar != null)
                      CircleAvatar(
                        radius: 16.r,
                        backgroundImage: NetworkImage(session.memberAvatar!),
                      )
                    else
                      CircleAvatar(
                        radius: 16.r,
                        backgroundColor: AppColors.primary.withOpacity(0.1),
                        child: Icon(
                          Icons.person,
                          size: 20.r,
                          color: AppColors.primary,
                        ),
                      ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        session.memberName!,
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 14.sp,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (session.isCompleted)
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.success.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.check_circle,
                              size: 16.r,
                              color: AppColors.success,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              'Completed',
                              style: TextStyle(
                                color: AppColors.success,
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'workout':
        return AppColors.warning;
      case 'assessment':
        return AppColors.success;
      case 'nutrition':
        return AppColors.info;
      default:
        return AppColors.primary;
    }
  }
}
