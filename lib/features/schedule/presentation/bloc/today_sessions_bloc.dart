import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/session.dart';
import '../../domain/repositories/session_repository.dart';

// Events
abstract class TodaySessionsEvent extends Equatable {
  const TodaySessionsEvent();

  @override
  List<Object?> get props => [];
}

class LoadTodaySessions extends TodaySessionsEvent {}

// States
abstract class TodaySessionsState extends Equatable {
  const TodaySessionsState();

  @override
  List<Object?> get props => [];
}

class TodaySessionsInitial extends TodaySessionsState {}

class TodaySessionsLoading extends TodaySessionsState {}

class TodaySessionsLoaded extends TodaySessionsState {
  final List<Session> sessions;

  const TodaySessionsLoaded(this.sessions);

  @override
  List<Object?> get props => [sessions];
}

class TodaySessionsError extends TodaySessionsState {
  final String message;

  const TodaySessionsError(this.message);

  @override
  List<Object?> get props => [message];
}

// Bloc
class TodaySessionsBloc extends Bloc<TodaySessionsEvent, TodaySessionsState> {
  final SessionRepository sessionRepository;

  TodaySessionsBloc({required this.sessionRepository})
      : super(TodaySessionsInitial()) {
    on<LoadTodaySessions>(_onLoadTodaySessions);
  }

  Future<void> _onLoadTodaySessions(
    LoadTodaySessions event,
    Emitter<TodaySessionsState> emit,
  ) async {
    emit(TodaySessionsLoading());
    try {
      final result = await sessionRepository.getTodaySessions();
      result.fold(
        (failure) => emit(TodaySessionsError(failure.message)),
        (sessions) => emit(TodaySessionsLoaded(sessions)),
      );
    } catch (e) {
      emit(TodaySessionsError(e.toString()));
    }
  }
}
