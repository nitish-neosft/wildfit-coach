import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../features/members/domain/entities/member.dart';
import '../../../../../features/members/domain/repositories/member_repository.dart';

part 'pending_assessments_event.dart';
part 'pending_assessments_state.dart';

class PendingAssessmentsBloc
    extends Bloc<PendingAssessmentsEvent, PendingAssessmentsState> {
  final MemberRepository memberRepository;

  PendingAssessmentsBloc({
    required this.memberRepository,
  }) : super(PendingAssessmentsInitial()) {
    on<LoadPendingAssessments>(_onLoadPendingAssessments);
  }

  Future<void> _onLoadPendingAssessments(
    LoadPendingAssessments event,
    Emitter<PendingAssessmentsState> emit,
  ) async {
    emit(PendingAssessmentsLoading());
    final result = await memberRepository.getMembersWithPendingAssessments();
    result.fold(
      (failure) => emit(PendingAssessmentsError(failure.message)),
      (members) => emit(PendingAssessmentsLoaded(members)),
    );
  }
}
