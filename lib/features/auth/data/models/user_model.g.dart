// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as String,
      name: json['name'] as String?,
      email: json['email'] as String,
      profileImage: json['profile_image'] as String?,
      role: json['role'] as String?,
      joinedAt: DateTime.parse(json['created_at'] as String),
      hasCompletedOnboarding:
          json['has_completed_onboarding'] as bool? ?? false,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'role': instance.role,
      'profile_image': instance.profileImage,
      'created_at': instance.joinedAt.toIso8601String(),
      'has_completed_onboarding': instance.hasCompletedOnboarding,
    };
