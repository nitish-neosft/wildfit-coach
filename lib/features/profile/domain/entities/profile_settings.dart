import 'package:equatable/equatable.dart';

class ProfileSettings extends Equatable {
  final String userId;
  final String name;
  final String email;
  final String avatar;
  final String role; // 'coach' or 'physio'
  final String specialization;
  final int yearsOfExperience;
  final List<String> certifications;
  final int totalMembers;
  final int activeMembers;
  final NotificationSettings notifications;
  final String language;
  final bool hasUnpaidDues;

  const ProfileSettings({
    required this.userId,
    required this.name,
    required this.email,
    required this.avatar,
    required this.role,
    required this.specialization,
    required this.yearsOfExperience,
    required this.certifications,
    required this.totalMembers,
    required this.activeMembers,
    required this.notifications,
    required this.language,
    required this.hasUnpaidDues,
  });

  @override
  List<Object?> get props => [
        userId,
        name,
        email,
        avatar,
        role,
        specialization,
        yearsOfExperience,
        certifications,
        totalMembers,
        activeMembers,
        notifications,
        language,
        hasUnpaidDues,
      ];
}

class NotificationSettings extends Equatable {
  final bool memberCheckInAlerts;
  final bool memberAssessmentReminders;
  final bool memberProgressAlerts;
  final bool membershipExpiryAlerts;
  final bool newMemberAssignments;
  final bool staffMeetingReminders;
  final bool paymentReminders;

  const NotificationSettings({
    required this.memberCheckInAlerts,
    required this.memberAssessmentReminders,
    required this.memberProgressAlerts,
    required this.membershipExpiryAlerts,
    required this.newMemberAssignments,
    required this.staffMeetingReminders,
    required this.paymentReminders,
  });

  @override
  List<Object?> get props => [
        memberCheckInAlerts,
        memberAssessmentReminders,
        memberProgressAlerts,
        membershipExpiryAlerts,
        newMemberAssignments,
        staffMeetingReminders,
        paymentReminders,
      ];
}
