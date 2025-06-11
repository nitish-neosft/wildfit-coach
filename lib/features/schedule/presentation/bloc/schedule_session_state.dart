import 'package:flutter/material.dart';

abstract class ScheduleSessionState {}

class ScheduleSessionInitial extends ScheduleSessionState {}

class ScheduleSessionLoading extends ScheduleSessionState {}

class ScheduleSessionError extends ScheduleSessionState {
  final String message;

  ScheduleSessionError(this.message);
}

class ScheduleSessionData extends ScheduleSessionState {
  final DateTime? selectedDate;
  final TimeOfDay? selectedTime;
  final String title;
  final String notes;
  final bool isSubmitting;

  ScheduleSessionData({
    this.selectedDate,
    this.selectedTime,
    this.title = '',
    this.notes = '',
    this.isSubmitting = false,
  });

  ScheduleSessionData copyWith({
    DateTime? selectedDate,
    TimeOfDay? selectedTime,
    String? title,
    String? notes,
    bool? isSubmitting,
  }) {
    return ScheduleSessionData(
      selectedDate: selectedDate ?? this.selectedDate,
      selectedTime: selectedTime ?? this.selectedTime,
      title: title ?? this.title,
      notes: notes ?? this.notes,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }
}
