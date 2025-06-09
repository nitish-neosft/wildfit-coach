import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/profile_settings.dart';

class ProfileSettingsModel extends ProfileSettings {
  const ProfileSettingsModel({
    required String userId,
    required String name,
    required String email,
    required String avatar,
    required String role,
    required String specialization,
    required int yearsOfExperience,
    required List<String> certifications,
    required int totalMembers,
    required int activeMembers,
    required NotificationSettings notifications,
    required String language,
    required bool hasUnpaidDues,
  }) : super(
          userId: userId,
          name: name,
          email: email,
          avatar: avatar,
          role: role,
          specialization: specialization,
          yearsOfExperience: yearsOfExperience,
          certifications: certifications,
          totalMembers: totalMembers,
          activeMembers: activeMembers,
          notifications: notifications,
          language: language,
          hasUnpaidDues: hasUnpaidDues,
        );

  factory ProfileSettingsModel.fromJson(Map<String, dynamic> json) {
    return ProfileSettingsModel(
      userId: json['user_id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      avatar: json['avatar'] as String,
      role: json['role'] as String,
      specialization: json['specialization'] as String,
      yearsOfExperience: json['years_of_experience'] as int,
      certifications: List<String>.from(json['certifications'] as List),
      totalMembers: json['total_members'] as int,
      activeMembers: json['active_members'] as int,
      notifications: NotificationSettingsModel.fromJson(
          json['notifications'] as Map<String, dynamic>),
      language: json['language'] as String,
      hasUnpaidDues: json['has_unpaid_dues'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'name': name,
      'email': email,
      'avatar': avatar,
      'role': role,
      'specialization': specialization,
      'years_of_experience': yearsOfExperience,
      'certifications': certifications,
      'total_members': totalMembers,
      'active_members': activeMembers,
      'notifications': (notifications as NotificationSettingsModel).toJson(),
      'language': language,
      'has_unpaid_dues': hasUnpaidDues,
    };
  }
}

class NotificationSettingsModel extends NotificationSettings {
  const NotificationSettingsModel({
    required bool memberCheckInAlerts,
    required bool memberAssessmentReminders,
    required bool memberProgressAlerts,
    required bool membershipExpiryAlerts,
    required bool newMemberAssignments,
    required bool staffMeetingReminders,
    required bool paymentReminders,
  }) : super(
          memberCheckInAlerts: memberCheckInAlerts,
          memberAssessmentReminders: memberAssessmentReminders,
          memberProgressAlerts: memberProgressAlerts,
          membershipExpiryAlerts: membershipExpiryAlerts,
          newMemberAssignments: newMemberAssignments,
          staffMeetingReminders: staffMeetingReminders,
          paymentReminders: paymentReminders,
        );

  factory NotificationSettingsModel.fromJson(Map<String, dynamic> json) {
    return NotificationSettingsModel(
      memberCheckInAlerts: json['member_check_in_alerts'] as bool,
      memberAssessmentReminders: json['member_assessment_reminders'] as bool,
      memberProgressAlerts: json['member_progress_alerts'] as bool,
      membershipExpiryAlerts: json['membership_expiry_alerts'] as bool,
      newMemberAssignments: json['new_member_assignments'] as bool,
      staffMeetingReminders: json['staff_meeting_reminders'] as bool,
      paymentReminders: json['payment_reminders'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'member_check_in_alerts': memberCheckInAlerts,
      'member_assessment_reminders': memberAssessmentReminders,
      'member_progress_alerts': memberProgressAlerts,
      'membership_expiry_alerts': membershipExpiryAlerts,
      'new_member_assignments': newMemberAssignments,
      'staff_meeting_reminders': staffMeetingReminders,
      'payment_reminders': paymentReminders,
    };
  }
}
