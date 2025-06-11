import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/colors.dart';
import '../bloc/schedule_session_bloc.dart';
import '../bloc/schedule_session_event.dart';
import '../bloc/schedule_session_state.dart';

class ScheduleSessionScreen extends StatelessWidget {
  const ScheduleSessionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ScheduleSessionBloc(),
      child: BlocConsumer<ScheduleSessionBloc, ScheduleSessionState>(
        listener: (context, state) {
          if (state is ScheduleSessionError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.error,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is! ScheduleSessionData) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = state;

          return Scaffold(
            appBar: AppBar(
              title: const Text('Schedule Session'),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select Date & Time',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  SizedBox(height: 20.h),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.darkCard,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.darkDivider),
                    ),
                    child: TableCalendar(
                      firstDay: DateTime.now(),
                      lastDay: DateTime.now().add(const Duration(days: 365)),
                      focusedDay: data.selectedDate ?? DateTime.now(),
                      selectedDayPredicate: (day) =>
                          isSameDay(data.selectedDate, day),
                      onDaySelected: (selectedDay, focusedDay) {
                        context
                            .read<ScheduleSessionBloc>()
                            .add(DateSelected(selectedDay));
                      },
                      calendarStyle: CalendarStyle(
                        selectedDecoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                        todayDecoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.3),
                          shape: BoxShape.circle,
                        ),
                        defaultTextStyle:
                            const TextStyle(color: AppColors.white),
                        weekendTextStyle:
                            const TextStyle(color: AppColors.white),
                        outsideTextStyle:
                            TextStyle(color: AppColors.white.withOpacity(0.5)),
                      ),
                      headerStyle: const HeaderStyle(
                        titleTextStyle: TextStyle(
                          color: AppColors.white,
                          fontSize: 17,
                        ),
                        formatButtonVisible: false,
                        leftChevronIcon:
                            Icon(Icons.chevron_left, color: AppColors.white),
                        rightChevronIcon:
                            Icon(Icons.chevron_right, color: AppColors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  if (data.selectedDate != null) ...[
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Selected Date: ${DateFormat('MMM dd, yyyy').format(data.selectedDate!)}',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: AppColors.white,
                                ),
                          ),
                        ),
                        TextButton.icon(
                          icon: const Icon(Icons.access_time),
                          label: Text(
                            data.selectedTime?.format(context) ?? 'Select Time',
                            style: const TextStyle(color: AppColors.white),
                          ),
                          onPressed: () async {
                            final time = await showTimePicker(
                              context: context,
                              initialTime: data.selectedTime ?? TimeOfDay.now(),
                            );
                            if (time != null) {
                              context
                                  .read<ScheduleSessionBloc>()
                                  .add(TimeSelected(time));
                            }
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                  ],
                  Text(
                    'Session Details',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  SizedBox(height: 10.h),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Session Title',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: AppColors.darkCard,
                    ),
                    style: const TextStyle(color: AppColors.white),
                    onChanged: (value) => context
                        .read<ScheduleSessionBloc>()
                        .add(TitleChanged(value)),
                  ),
                  SizedBox(height: 10.h),
                  TextField(
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: 'Notes',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: AppColors.darkCard,
                    ),
                    style: const TextStyle(color: AppColors.white),
                    onChanged: (value) => context
                        .read<ScheduleSessionBloc>()
                        .add(NotesChanged(value)),
                  ),
                  SizedBox(height: 20.h),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: data.isSubmitting
                          ? null
                          : () {
                              context
                                  .read<ScheduleSessionBloc>()
                                  .add(SubmitSession());
                            },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        backgroundColor: AppColors.primary,
                      ),
                      child: data.isSubmitting
                          ? const CircularProgressIndicator()
                          : const Text('Schedule Session'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
