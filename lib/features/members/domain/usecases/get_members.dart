import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/member.dart';
import '../repositories/member_repository.dart';

class GetMembers {
  final MemberRepository repository;

  GetMembers(this.repository);

  Future<Either<Failure, List<Member>>> call() async {
    return await repository.getMembers();
  }
}
