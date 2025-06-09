import 'package:equatable/equatable.dart';

class Exercise extends Equatable {
  final String id;
  final String name;
  final String description;
  final String? videoUrl;
  final String? imageUrl;
  final int sets;
  final int? reps;
  final double? weight;
  final int? duration;
  final int restTime;
  final Map<String, dynamic> metadata;

  const Exercise({
    required this.id,
    required this.name,
    required this.description,
    this.videoUrl,
    this.imageUrl,
    required this.sets,
    this.reps,
    this.weight,
    this.duration,
    required this.restTime,
    required this.metadata,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        videoUrl,
        imageUrl,
        sets,
        reps,
        weight,
        duration,
        restTime,
        metadata,
      ];

  Exercise copyWith({
    String? id,
    String? name,
    String? description,
    String? videoUrl,
    String? imageUrl,
    int? sets,
    int? reps,
    double? weight,
    int? duration,
    int? restTime,
    Map<String, dynamic>? metadata,
  }) {
    return Exercise(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      videoUrl: videoUrl ?? this.videoUrl,
      imageUrl: imageUrl ?? this.imageUrl,
      sets: sets ?? this.sets,
      reps: reps ?? this.reps,
      weight: weight ?? this.weight,
      duration: duration ?? this.duration,
      restTime: restTime ?? this.restTime,
      metadata: metadata ?? this.metadata,
    );
  }
}
