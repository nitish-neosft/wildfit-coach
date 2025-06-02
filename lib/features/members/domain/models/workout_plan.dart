enum WorkoutType {
  strength,
  cardio,
  flexibility,
  hiit,
  endurance,
}

enum Difficulty {
  beginner,
  intermediate,
  advanced,
  expert,
}

class WorkoutPlan {
  final String id;
  final String memberId;
  final String name;
  final WorkoutType type;
  final int durationWeeks;
  final int sessionsPerWeek;
  final Difficulty difficulty;
  final DateTime createdAt;
  final DateTime lastUpdated;
  final List<WorkoutDay> schedule;
  final List<Exercise> exercises;

  const WorkoutPlan({
    required this.id,
    required this.memberId,
    required this.name,
    required this.type,
    required this.durationWeeks,
    required this.sessionsPerWeek,
    required this.difficulty,
    required this.createdAt,
    required this.lastUpdated,
    required this.schedule,
    required this.exercises,
  });

  factory WorkoutPlan.fromJson(Map<String, dynamic> json) {
    return WorkoutPlan(
      id: json['id'] as String,
      memberId: json['memberId'] as String,
      name: json['name'] as String,
      type: WorkoutType.values.firstWhere(
        (e) => e.toString() == 'WorkoutType.${json['type']}',
      ),
      durationWeeks: json['durationWeeks'] as int,
      sessionsPerWeek: json['sessionsPerWeek'] as int,
      difficulty: Difficulty.values.firstWhere(
        (e) => e.toString() == 'Difficulty.${json['difficulty']}',
      ),
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
      schedule: (json['schedule'] as List)
          .map((e) => WorkoutDay.fromJson(e as Map<String, dynamic>))
          .toList(),
      exercises: (json['exercises'] as List)
          .map((e) => Exercise.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'memberId': memberId,
      'name': name,
      'type': type.toString().split('.').last,
      'durationWeeks': durationWeeks,
      'sessionsPerWeek': sessionsPerWeek,
      'difficulty': difficulty.toString().split('.').last,
      'createdAt': createdAt.toIso8601String(),
      'lastUpdated': lastUpdated.toIso8601String(),
      'schedule': schedule.map((e) => e.toJson()).toList(),
      'exercises': exercises.map((e) => e.toJson()).toList(),
    };
  }
}

class WorkoutDay {
  final int dayNumber;
  final String name;
  final String description;
  final List<String> exerciseIds;

  const WorkoutDay({
    required this.dayNumber,
    required this.name,
    required this.description,
    required this.exerciseIds,
  });

  factory WorkoutDay.fromJson(Map<String, dynamic> json) {
    return WorkoutDay(
      dayNumber: json['dayNumber'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      exerciseIds: (json['exerciseIds'] as List).cast<String>(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dayNumber': dayNumber,
      'name': name,
      'description': description,
      'exerciseIds': exerciseIds,
    };
  }
}

class Exercise {
  final String id;
  final String name;
  final String description;
  final int sets;
  final int reps;
  final double? weight;
  final Duration? duration;
  final String? notes;

  const Exercise({
    required this.id,
    required this.name,
    required this.description,
    required this.sets,
    required this.reps,
    this.weight,
    this.duration,
    this.notes,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      sets: json['sets'] as int,
      reps: json['reps'] as int,
      weight: json['weight'] as double?,
      duration: json['duration'] == null
          ? null
          : Duration(seconds: json['duration'] as int),
      notes: json['notes'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'sets': sets,
      'reps': reps,
      'weight': weight,
      'duration': duration?.inSeconds,
      'notes': notes,
    };
  }
}
