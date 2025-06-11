import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Session extends Equatable {
  final String id;
  final String title;
  final String? notes;
  final DateTime date;
  final TimeOfDay time;
  final String? memberId;
  final String? memberName;
  final String? memberAvatar;
  final String type;
  final bool isCompleted;

  const Session({
    required this.id,
    required this.title,
    this.notes,
    required this.date,
    required this.time,
    this.memberId,
    this.memberName,
    this.memberAvatar,
    required this.type,
    this.isCompleted = false,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        notes,
        date,
        time,
        memberId,
        memberName,
        memberAvatar,
        type,
        isCompleted,
      ];
}
