import 'package:flutter_bloc/flutter_bloc.dart';
import 'schedule_session_event.dart';
import 'schedule_session_state.dart';

class ScheduleSessionBloc
    extends Bloc<ScheduleSessionEvent, ScheduleSessionState> {
  ScheduleSessionBloc() : super(ScheduleSessionData()) {
    on<DateSelected>(_onDateSelected);
    on<TimeSelected>(_onTimeSelected);
    on<TitleChanged>(_onTitleChanged);
    on<NotesChanged>(_onNotesChanged);
    on<SubmitSession>(_onSubmitSession);
  }

  void _onDateSelected(DateSelected event, Emitter<ScheduleSessionState> emit) {
    if (state is ScheduleSessionData) {
      final currentState = state as ScheduleSessionData;
      emit(currentState.copyWith(selectedDate: event.selectedDate));
    }
  }

  void _onTimeSelected(TimeSelected event, Emitter<ScheduleSessionState> emit) {
    if (state is ScheduleSessionData) {
      final currentState = state as ScheduleSessionData;
      emit(currentState.copyWith(selectedTime: event.selectedTime));
    }
  }

  void _onTitleChanged(TitleChanged event, Emitter<ScheduleSessionState> emit) {
    if (state is ScheduleSessionData) {
      final currentState = state as ScheduleSessionData;
      emit(currentState.copyWith(title: event.title));
    }
  }

  void _onNotesChanged(NotesChanged event, Emitter<ScheduleSessionState> emit) {
    if (state is ScheduleSessionData) {
      final currentState = state as ScheduleSessionData;
      emit(currentState.copyWith(notes: event.notes));
    }
  }

  Future<void> _onSubmitSession(
      SubmitSession event, Emitter<ScheduleSessionState> emit) async {
    if (state is ScheduleSessionData) {
      final currentState = state as ScheduleSessionData;

      if (currentState.selectedDate == null ||
          currentState.selectedTime == null) {
        emit(ScheduleSessionError('Please select both date and time'));
        emit(currentState);
        return;
      }

      if (currentState.title.isEmpty) {
        emit(ScheduleSessionError('Please enter a session title'));
        emit(currentState);
        return;
      }

      emit(currentState.copyWith(isSubmitting: true));

      try {
        // TODO: Implement session creation logic
        await Future.delayed(const Duration(seconds: 1)); // Simulated API call

        // For now, just print the session details
        print('Session scheduled:');
        print('Date: ${currentState.selectedDate}');
        print('Time: ${currentState.selectedTime}');
        print('Title: ${currentState.title}');
        print('Notes: ${currentState.notes}');
      } catch (e) {
        emit(ScheduleSessionError(e.toString()));
        emit(currentState.copyWith(isSubmitting: false));
        return;
      }
    }
  }
}
