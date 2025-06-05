import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/member.dart';
import '../entities/assessment.dart';

abstract class MemberRepository {
  Future<Either<Failure, List<Member>>> getMembers();
  Future<Either<Failure, Member>> getMember(String id);
  Future<Either<Failure, Member>> createMember(Member member);
  Future<Either<Failure, void>> updateMember(Member member);
  Future<Either<Failure, void>> deleteMember(String id);
  Future<Either<Failure, void>> updateMemberMeasurements(
      String id, Map<String, dynamic> measurements);
  Future<Either<Failure, void>> checkIn(String id);
  Future<Either<Failure, void>> updateMemberGoals({
    required String id,
    double? weightGoal,
    double? bodyFatGoal,
    int? weeklyWorkoutGoal,
  });
  Future<Either<Failure, void>> addAssessment(
      String memberId, Assessment assessment);
}
