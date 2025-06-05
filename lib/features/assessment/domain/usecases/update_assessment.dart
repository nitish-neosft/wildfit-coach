import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user_assessment.dart';
import '../repositories/assessment_repository.dart';

class UpdateAssessment implements UseCase<void, UpdateParams> {
  final AssessmentRepository repository;

  UpdateAssessment(this.repository);

  @override
  Future<Either<Failure, void>> call(UpdateParams params) async {
    return await repository.updateAssessment(params.assessment);
  }
}

class UpdateParams extends Equatable {
  final UserAssessment assessment;

  const UpdateParams({required this.assessment});

  @override
  List<Object> get props => [assessment];
}
