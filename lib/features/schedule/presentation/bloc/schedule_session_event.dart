import 'package:flutter/material.dart';

abstract class ScheduleSessionEvent {}

class DateSelected extends ScheduleSessionEvent {
  final DateTime selectedDate;

  DateSelected(this.selectedDate);
}

class TimeSelected extends ScheduleSessionEvent {
  final TimeOfDay selectedTime;

  TimeSelected(this.selectedTime);
}

class TitleChanged extends ScheduleSessionEvent {
  final String title;

  TitleChanged(this.title);
}

class NotesChanged extends ScheduleSessionEvent {
  final String notes;

  NotesChanged(this.notes);
}

class SubmitSession extends ScheduleSessionEvent {}
