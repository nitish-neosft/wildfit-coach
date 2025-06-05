import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/member.dart';
import '../repositories/member_repository.dart';

class UpdateMember {
  final MemberRepository repository;

  UpdateMember(this.repository);

  Future<Either<Failure, void>> call(Member member) async {
    return await repository.updateMember(member);
  }
}
