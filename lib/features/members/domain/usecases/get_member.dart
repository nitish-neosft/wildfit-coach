import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/member.dart';
import '../repositories/member_repository.dart';

class GetMember {
  final MemberRepository repository;

  GetMember(this.repository);

  Future<Either<Failure, Member>> call(String id) async {
    return await repository.getMember(id);
  }
}
