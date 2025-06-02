import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/user.dart';

part 'user_model.g.dart';

/// A data model class that extends [User] entity and handles JSON serialization.
@JsonSerializable(fieldRename: FieldRename.snake)
class UserModel extends User {
  @override
  @JsonKey(name: 'profile_image')
  final String? profileImage;

  @override
  @JsonKey(name: 'created_at')
  final DateTime joinedAt;

  @override
  @JsonKey(name: 'has_completed_onboarding', defaultValue: false)
  final bool hasCompletedOnboarding;

  /// Creates a new [UserModel] instance
  const UserModel({
    required String id,
    String? name,
    required String email,
    this.profileImage,
    String? role,
    required this.joinedAt,
    this.hasCompletedOnboarding = false,
  }) : super(
          id: id,
          name: name,
          email: email,
          profileImage: profileImage,
          role: role,
          joinedAt: joinedAt,
          hasCompletedOnboarding: hasCompletedOnboarding,
        );

  /// Creates a [UserModel] instance from a JSON map
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  /// Converts this [UserModel] instance to a JSON map
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  /// Creates a copy of this [UserModel] with the given fields replaced with new values
  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? profileImage,
    String? role,
    DateTime? joinedAt,
    bool? hasCompletedOnboarding,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      profileImage: profileImage ?? this.profileImage,
      role: role ?? this.role,
      joinedAt: joinedAt ?? this.joinedAt,
      hasCompletedOnboarding:
          hasCompletedOnboarding ?? this.hasCompletedOnboarding,
    );
  }
}
