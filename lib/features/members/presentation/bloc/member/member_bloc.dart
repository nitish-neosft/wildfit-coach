import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/error/failures.dart';
import '../../../domain/usecases/get_member.dart';
import '../../../domain/usecases/update_member.dart';
import '../../../domain/usecases/add_assessment.dart';
import 'member_event.dart';
import 'member_state.dart';

class MemberBloc extends Bloc<MemberEvent, MemberState> {
  final GetMember getMember;
  final UpdateMember updateMember;
  final AddAssessment addAssessment;

  MemberBloc({
    required this.getMember,
    required this.updateMember,
    required this.addAssessment,
  }) : super(MemberInitial()) {
    on<LoadMemberDetails>(_onLoadMemberDetails);
    on<UpdateMemberEvent>(_onUpdateMember);
    on<AddAssessmentEvent>(_onAddAssessment);
  }

  Future<void> _onLoadMemberDetails(
    LoadMemberDetails event,
    Emitter<MemberState> emit,
  ) async {
    emit(MemberLoading());
    final result = await getMember(event.memberId);
    result.fold(
      (failure) => _handleFailure(failure, emit),
      (member) => emit(MemberLoaded(member)),
    );
  }

  Future<void> _onUpdateMember(
    UpdateMemberEvent event,
    Emitter<MemberState> emit,
  ) async {
    emit(MemberLoading());
    final result = await updateMember(event.member);
    result.fold(
      (failure) => _handleFailure(failure, emit),
      (_) => add(LoadMemberDetails(event.member.id)),
    );
  }

  Future<void> _onAddAssessment(
    AddAssessmentEvent event,
    Emitter<MemberState> emit,
  ) async {
    emit(MemberLoading());
    final result = await addAssessment(event.memberId, event.assessment);
    result.fold(
      (failure) => _handleFailure(failure, emit),
      (_) => add(LoadMemberDetails(event.memberId)),
    );
  }

  void _handleFailure(Failure failure, Emitter<MemberState> emit) {
    if (failure is UnauthorizedFailure) {
      emit(MemberAuthError(failure.message));
    } else if (failure is NetworkFailure) {
      emit(MemberNetworkError(failure.message));
    } else if (failure is NotFoundFailure) {
      emit(MemberNotFound(failure.message));
    } else {
      emit(MemberError(failure.message));
    }
  }
}
