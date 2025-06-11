import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/session.dart';

abstract class SessionRepository {
  Future<Either<Failure, List<Session>>> getTodaySessions();
  Future<Either<Failure, Session>> createSession(Session session);
  Future<Either<Failure, void>> updateSession(Session session);
  Future<Either<Failure, void>> deleteSession(String id);
  Future<Either<Failure, void>> completeSession(String id);
}
