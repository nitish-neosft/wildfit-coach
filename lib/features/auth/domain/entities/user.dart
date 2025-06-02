import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/// Represents a user entity in the domain layer.
/// This class contains the core business logic properties of a user.
@immutable
class User extends Equatable {
  /// Unique identifier of the user
  final String id;

  /// Name of the user, can be null if not set
  final String? name;

  /// Email address of the user
  final String email;

  /// URL of the user's profile image, can be null if not set
  final String? profileImage;

  /// Role of the user in the system, can be null if not set
  final String? role;

  /// Date when the user joined the platform
  final DateTime joinedAt;

  /// Whether the user has completed the onboarding process
  final bool hasCompletedOnboarding;

  /// Creates a new [User] instance
  const User({
    required this.id,
    this.name,
    required this.email,
    this.profileImage,
    this.role,
    required this.joinedAt,
    this.hasCompletedOnboarding = false,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        profileImage,
        role,
        joinedAt,
        hasCompletedOnboarding,
      ];
}
