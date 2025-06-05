import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user_assessment.dart';
import '../repositories/assessment_repository.dart';

class SaveAssessment implements UseCase<void, SaveParams> {
  final AssessmentRepository repository;

  SaveAssessment(this.repository);

  @override
  Future<Either<Failure, void>> call(SaveParams params) async {
    return await repository.saveAssessment(params.assessment);
  }
}

class SaveParams extends Equatable {
  final UserAssessment assessment;

  const SaveParams({required this.assessment});

  @override
  List<Object> get props => [assessment];
}
