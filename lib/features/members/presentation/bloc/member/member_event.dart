import 'package:equatable/equatable.dart';
import '../../../domain/entities/member.dart';
import '../../../domain/entities/assessment.dart';

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

class UpdateMemberEvent extends MemberEvent {
  final Member member;

  const UpdateMemberEvent(this.member);

  @override
  List<Object?> get props => [member];
}

class AddAssessmentEvent extends MemberEvent {
  final String memberId;
  final Assessment assessment;

  const AddAssessmentEvent({
    required this.memberId,
    required this.assessment,
  });

  @override
  List<Object?> get props => [memberId, assessment];
}
