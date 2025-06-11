import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/session.dart';

part 'session_model.g.dart';

class TimeOfDayConverter implements JsonConverter<TimeOfDay, String> {
  const TimeOfDayConverter();

  @override
  TimeOfDay fromJson(String json) {
    final parts = json.split(':');
    return TimeOfDay(
      hour: int.parse(parts[0]),
      minute: int.parse(parts[1]),
    );
  }

  @override
  String toJson(TimeOfDay time) =>
      '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
}

@JsonSerializable(fieldRename: FieldRename.snake)
class SessionModel extends Session {
  @TimeOfDayConverter()
  @override
  final TimeOfDay time;

  const SessionModel({
    required String id,
    required String title,
    String? notes,
    required DateTime date,
    required this.time,
    String? memberId,
    String? memberName,
    String? memberAvatar,
    required String type,
    bool isCompleted = false,
  }) : super(
          id: id,
          title: title,
          notes: notes,
          date: date,
          time: time,
          memberId: memberId,
          memberName: memberName,
          memberAvatar: memberAvatar,
          type: type,
          isCompleted: isCompleted,
        );

  factory SessionModel.fromJson(Map<String, dynamic> json) =>
      _$SessionModelFromJson(json);

  Map<String, dynamic> toJson() => _$SessionModelToJson(this);

  factory SessionModel.fromEntity(Session session) {
    return SessionModel(
      id: session.id,
      title: session.title,
      notes: session.notes,
      date: session.date,
      time: session.time,
      memberId: session.memberId,
      memberName: session.memberName,
      memberAvatar: session.memberAvatar,
      type: session.type,
      isCompleted: session.isCompleted,
    );
  }

  Session toEntity() => this;
}
