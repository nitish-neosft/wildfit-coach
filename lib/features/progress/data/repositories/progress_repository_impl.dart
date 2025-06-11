import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/progress_report.dart';
import '../../domain/repositories/progress_repository.dart';

class ProgressRepositoryImpl implements ProgressRepository {
  @override
  Future<Either<Failure, ProgressReport>> getClientProgress(
      String memberId) async {
    try {
      // Mock data for demonstration
      return Right(
        ProgressReport(
          memberId: memberId,
          memberName: 'John Smith',
          memberAvatar: 'https://i.pravatar.cc/150?img=1',
          initialWeight: 85.0,
          currentWeight: 80.5,
          weightChange: -4.5,
          initialBodyFat: 22.0,
          currentBodyFat: 18.5,
          bodyFatChange: -3.5,
          totalWorkouts: 24,
          totalNutritionSessions: 8,
          adherenceRate: 0.85,
          weightHistory: [
            WeightEntry(
                date: DateTime.now().subtract(const Duration(days: 30)),
                weight: 85.0),
            WeightEntry(
                date: DateTime.now().subtract(const Duration(days: 25)),
                weight: 84.2),
            WeightEntry(
                date: DateTime.now().subtract(const Duration(days: 20)),
                weight: 83.1),
            WeightEntry(
                date: DateTime.now().subtract(const Duration(days: 15)),
                weight: 82.3),
            WeightEntry(
                date: DateTime.now().subtract(const Duration(days: 10)),
                weight: 81.4),
            WeightEntry(
                date: DateTime.now().subtract(const Duration(days: 5)),
                weight: 80.8),
            WeightEntry(date: DateTime.now(), weight: 80.5),
          ],
          bodyFatHistory: [
            BodyFatEntry(
                date: DateTime.now().subtract(const Duration(days: 30)),
                percentage: 22.0),
            BodyFatEntry(
                date: DateTime.now().subtract(const Duration(days: 25)),
                percentage: 21.2),
            BodyFatEntry(
                date: DateTime.now().subtract(const Duration(days: 20)),
                percentage: 20.5),
            BodyFatEntry(
                date: DateTime.now().subtract(const Duration(days: 15)),
                percentage: 19.8),
            BodyFatEntry(
                date: DateTime.now().subtract(const Duration(days: 10)),
                percentage: 19.2),
            BodyFatEntry(
                date: DateTime.now().subtract(const Duration(days: 5)),
                percentage: 18.8),
            BodyFatEntry(date: DateTime.now(), percentage: 18.5),
          ],
          achievements: [
            'Lost first 5kg',
            'Completed 20 workouts',
            'Achieved 85% adherence rate',
            'Reduced body fat by 3%',
          ],
        ),
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProgressReport>>> getAllClientsProgress() async {
    try {
      // Mock data for demonstration
      return Right([
        ProgressReport(
          memberId: '1',
          memberName: 'John Smith',
          memberAvatar: 'https://i.pravatar.cc/150?img=1',
          initialWeight: 85.0,
          currentWeight: 80.5,
          weightChange: -4.5,
          initialBodyFat: 22.0,
          currentBodyFat: 18.5,
          bodyFatChange: -3.5,
          totalWorkouts: 24,
          totalNutritionSessions: 8,
          adherenceRate: 0.85,
          weightHistory: [
            WeightEntry(
                date: DateTime.now().subtract(const Duration(days: 30)),
                weight: 85.0),
            WeightEntry(date: DateTime.now(), weight: 80.5),
          ],
          bodyFatHistory: [
            BodyFatEntry(
                date: DateTime.now().subtract(const Duration(days: 30)),
                percentage: 22.0),
            BodyFatEntry(date: DateTime.now(), percentage: 18.5),
          ],
          achievements: ['Lost first 5kg', 'Completed 20 workouts'],
        ),
        ProgressReport(
          memberId: '2',
          memberName: 'Sarah Johnson',
          memberAvatar: 'https://i.pravatar.cc/150?img=2',
          initialWeight: 65.0,
          currentWeight: 62.0,
          weightChange: -3.0,
          initialBodyFat: 28.0,
          currentBodyFat: 25.0,
          bodyFatChange: -3.0,
          totalWorkouts: 18,
          totalNutritionSessions: 6,
          adherenceRate: 0.78,
          weightHistory: [
            WeightEntry(
                date: DateTime.now().subtract(const Duration(days: 30)),
                weight: 65.0),
            WeightEntry(date: DateTime.now(), weight: 62.0),
          ],
          bodyFatHistory: [
            BodyFatEntry(
                date: DateTime.now().subtract(const Duration(days: 30)),
                percentage: 28.0),
            BodyFatEntry(date: DateTime.now(), percentage: 25.0),
          ],
          achievements: ['Completed 15 workouts', 'Achieved 75% adherence'],
        ),
        ProgressReport(
          memberId: '3',
          memberName: 'Mike Wilson',
          memberAvatar: 'https://i.pravatar.cc/150?img=3',
          initialWeight: 92.0,
          currentWeight: 85.0,
          weightChange: -7.0,
          initialBodyFat: 25.0,
          currentBodyFat: 20.0,
          bodyFatChange: -5.0,
          totalWorkouts: 30,
          totalNutritionSessions: 10,
          adherenceRate: 0.92,
          weightHistory: [
            WeightEntry(
                date: DateTime.now().subtract(const Duration(days: 30)),
                weight: 92.0),
            WeightEntry(date: DateTime.now(), weight: 85.0),
          ],
          bodyFatHistory: [
            BodyFatEntry(
                date: DateTime.now().subtract(const Duration(days: 30)),
                percentage: 25.0),
            BodyFatEntry(date: DateTime.now(), percentage: 20.0),
          ],
          achievements: [
            'Lost first 7kg',
            'Achieved 90% adherence',
            'Completed 30 workouts'
          ],
        ),
      ]);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
