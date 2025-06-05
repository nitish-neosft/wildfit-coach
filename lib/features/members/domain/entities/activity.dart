import 'package:equatable/equatable.dart';

enum ActivityType {
  workout,
  nutrition,
  assessment,
  checkIn,
  other,
}

class Activity extends Equatable {
  final String name;
  final ActivityType type;
  final DateTime time;
  final Map<String, dynamic>? data;

  const Activity({
    required this.name,
    required this.type,
    required this.time,
    this.data,
  });

  @override
  List<Object?> get props => [name, type, time, data];
}
