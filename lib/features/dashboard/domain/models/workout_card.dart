class WorkoutCard {
  final String id;
  final String title;
  final String description;
  final DateTime assignedDate;
  final String assignedBy;
  final String memberId;
  final List<Exercise> exercises;
  final WorkoutStatus status;

  const WorkoutCard({
    required this.id,
    required this.title,
    required this.description,
    required this.assignedDate,
    required this.assignedBy,
    required this.memberId,
    required this.exercises,
    this.status = WorkoutStatus.pending,
  });

  factory WorkoutCard.fromJson(Map<String, dynamic> json) {
    return WorkoutCard(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      assignedDate: DateTime.parse(json['assignedDate'] as String),
      assignedBy: json['assignedBy'] as String,
      memberId: json['memberId'] as String,
      exercises: (json['exercises'] as List)
          .map((e) => Exercise.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: WorkoutStatus.values
          .firstWhere((e) => e.toString() == json['status'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'assignedDate': assignedDate.toIso8601String(),
      'assignedBy': assignedBy,
      'memberId': memberId,
      'exercises': exercises.map((e) => e.toJson()).toList(),
      'status': status.toString(),
    };
  }
}

class Exercise {
  final String name;
  final int sets;
  final int reps;
  final String? weight;
  final String? notes;

  const Exercise({
    required this.name,
    required this.sets,
    required this.reps,
    this.weight,
    this.notes,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      name: json['name'] as String,
      sets: json['sets'] as int,
      reps: json['reps'] as int,
      weight: json['weight'] as String?,
      notes: json['notes'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'sets': sets,
      'reps': reps,
      'weight': weight,
      'notes': notes,
    };
  }
}

enum WorkoutStatus { pending, inProgress, completed, cancelled }
