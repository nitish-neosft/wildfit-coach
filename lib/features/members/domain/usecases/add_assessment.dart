import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/assessment.dart';
import '../repositories/member_repository.dart';

class AddAssessment {
  final MemberRepository repository;

  AddAssessment(this.repository);

  Future<Either<Failure, void>> call(
      String memberId, Assessment assessment) async {
    return await repository.addAssessment(memberId, assessment);
  }
}
