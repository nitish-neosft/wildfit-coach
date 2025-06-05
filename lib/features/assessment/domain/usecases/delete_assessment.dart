import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/assessment_repository.dart';

class DeleteAssessment implements UseCase<void, DeleteParams> {
  final AssessmentRepository repository;

  DeleteAssessment(this.repository);

  @override
  Future<Either<Failure, void>> call(DeleteParams params) async {
    return await repository.deleteAssessment(params.id);
  }
}

class DeleteParams extends Equatable {
  final String id;

  const DeleteParams({required this.id});

  @override
  List<Object> get props => [id];
}
