import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user_assessment.dart';
import '../repositories/assessment_repository.dart';

class GetAssessmentById implements UseCase<UserAssessment?, Params> {
  final AssessmentRepository repository;

  GetAssessmentById(this.repository);

  @override
  Future<Either<Failure, UserAssessment?>> call(Params params) async {
    return await repository.getAssessmentById(params.id);
  }
}

class Params extends Equatable {
  final String id;

  const Params({required this.id});

  @override
  List<Object> get props => [id];
}
