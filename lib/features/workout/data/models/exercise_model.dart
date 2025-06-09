import 'package:equatable/equatable.dart';
import '../../domain/entities/exercise.dart';

class ExerciseModel extends Equatable {
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

  const ExerciseModel({
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

  factory ExerciseModel.fromJson(Map<String, dynamic> json) {
    return ExerciseModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      videoUrl: json['video_url'] as String?,
      imageUrl: json['image_url'] as String?,
      sets: json['sets'] as int,
      reps: json['reps'] as int?,
      weight:
          json['weight'] == null ? null : (json['weight'] as num).toDouble(),
      duration: json['duration'] as int?,
      restTime: json['rest_time'] as int,
      metadata: json['metadata'] as Map<String, dynamic>,
    );
  }

  factory ExerciseModel.fromEntity(Exercise entity) {
    return ExerciseModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      videoUrl: entity.videoUrl,
      imageUrl: entity.imageUrl,
      sets: entity.sets,
      reps: entity.reps,
      weight: entity.weight,
      duration: entity.duration,
      restTime: entity.restTime,
      metadata: Map<String, dynamic>.from(entity.metadata),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'video_url': videoUrl,
      'image_url': imageUrl,
      'sets': sets,
      'reps': reps,
      'weight': weight,
      'duration': duration,
      'rest_time': restTime,
      'metadata': metadata,
    };
  }

  Exercise toEntity() {
    return Exercise(
      id: id,
      name: name,
      description: description,
      videoUrl: videoUrl,
      imageUrl: imageUrl,
      sets: sets,
      reps: reps,
      weight: weight,
      duration: duration,
      restTime: restTime,
      metadata: Map<String, dynamic>.from(metadata),
    );
  }

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
}
