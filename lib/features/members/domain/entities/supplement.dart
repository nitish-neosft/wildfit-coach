import 'package:equatable/equatable.dart';

class Supplement extends Equatable {
  final String id;
  final String name;
  final String type;
  final String dosage;
  final String frequency;
  final Map<String, dynamic>? instructions;

  const Supplement({
    required this.id,
    required this.name,
    required this.type,
    required this.dosage,
    required this.frequency,
    this.instructions,
  });

  Supplement copyWith({
    String? id,
    String? name,
    String? type,
    String? dosage,
    String? frequency,
    Map<String, dynamic>? instructions,
  }) {
    return Supplement(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      dosage: dosage ?? this.dosage,
      frequency: frequency ?? this.frequency,
      instructions: instructions ?? this.instructions,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        type,
        dosage,
        frequency,
        instructions,
      ];
}
