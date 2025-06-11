import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/progress_report.dart';
import '../../domain/repositories/progress_repository.dart';

// Events
abstract class ProgressEvent extends Equatable {
  const ProgressEvent();

  @override
  List<Object?> get props => [];
}

class LoadClientProgress extends ProgressEvent {
  final String memberId;

  const LoadClientProgress(this.memberId);

  @override
  List<Object?> get props => [memberId];
}

class LoadAllClientsProgress extends ProgressEvent {}

// States
abstract class ProgressState extends Equatable {
  const ProgressState();

  @override
  List<Object?> get props => [];
}

class ProgressInitial extends ProgressState {}

class ProgressLoading extends ProgressState {}

class SingleClientProgressLoaded extends ProgressState {
  final ProgressReport report;

  const SingleClientProgressLoaded(this.report);

  @override
  List<Object?> get props => [report];
}

class AllClientsProgressLoaded extends ProgressState {
  final List<ProgressReport> reports;

  const AllClientsProgressLoaded(this.reports);

  @override
  List<Object?> get props => [reports];
}

class ProgressError extends ProgressState {
  final String message;

  const ProgressError(this.message);

  @override
  List<Object?> get props => [message];
}

// Bloc
class ProgressBloc extends Bloc<ProgressEvent, ProgressState> {
  final ProgressRepository repository;

  ProgressBloc({required this.repository}) : super(ProgressInitial()) {
    on<LoadClientProgress>(_onLoadClientProgress);
    on<LoadAllClientsProgress>(_onLoadAllClientsProgress);
  }

  Future<void> _onLoadClientProgress(
    LoadClientProgress event,
    Emitter<ProgressState> emit,
  ) async {
    emit(ProgressLoading());
    try {
      final result = await repository.getClientProgress(event.memberId);
      result.fold(
        (failure) => emit(ProgressError(failure.message)),
        (report) => emit(SingleClientProgressLoaded(report)),
      );
    } catch (e) {
      emit(ProgressError(e.toString()));
    }
  }

  Future<void> _onLoadAllClientsProgress(
    LoadAllClientsProgress event,
    Emitter<ProgressState> emit,
  ) async {
    emit(ProgressLoading());
    try {
      final result = await repository.getAllClientsProgress();
      result.fold(
        (failure) => emit(ProgressError(failure.message)),
        (reports) => emit(AllClientsProgressLoaded(reports)),
      );
    } catch (e) {
      emit(ProgressError(e.toString()));
    }
  }
}
