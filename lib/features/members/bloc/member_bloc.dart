import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../features/dashboard/domain/entities/dashboard_member.dart';
import '../../../features/dashboard/domain/repositories/dashboard_repository.dart';

// Events
abstract class MemberEvent extends Equatable {
  const MemberEvent();

  @override
  List<Object?> get props => [];
}

class LoadMemberDetails extends MemberEvent {
  final String memberId;

  const LoadMemberDetails(this.memberId);

  @override
  List<Object?> get props => [memberId];
}

// States
abstract class MemberState extends Equatable {
  const MemberState();

  @override
  List<Object?> get props => [];
}

class MemberInitial extends MemberState {}

class MemberLoading extends MemberState {}

class MemberLoaded extends MemberState {
  final DashboardMember member;

  const MemberLoaded(this.member);

  @override
  List<Object?> get props => [member];
}

class MemberError extends MemberState {
  final String message;

  const MemberError(this.message);

  @override
  List<Object?> get props => [message];
}

// Bloc
class MemberBloc extends Bloc<MemberEvent, MemberState> {
  final DashboardRepository repository;

  MemberBloc({required this.repository}) : super(MemberInitial()) {
    on<LoadMemberDetails>(_onLoadMemberDetails);
  }

  Future<void> _onLoadMemberDetails(
    LoadMemberDetails event,
    Emitter<MemberState> emit,
  ) async {
    emit(MemberLoading());
    try {
      final result = await repository.getMemberDetails(event.memberId);
      result.fold(
        (failure) => emit(MemberError(failure.message)),
        (member) => emit(MemberLoaded(member)),
      );
    } catch (e) {
      emit(MemberError(e.toString()));
    }
  }
}
