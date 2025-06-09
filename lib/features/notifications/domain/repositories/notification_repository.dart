import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/notification_model.dart';

class NotificationRepository {
  static const String _storageKey = 'notifications';
  final SharedPreferences _prefs;

  NotificationRepository(this._prefs);

  Future<List<NotificationModel>> getNotifications() async {
    final String? notificationsJson = _prefs.getString(_storageKey);
    if (notificationsJson == null) return [];

    final List<dynamic> decodedList = json.decode(notificationsJson);
    return decodedList.map((item) => NotificationModel.fromJson(item)).toList()
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
  }

  Future<void> saveNotification(NotificationModel notification) async {
    final notifications = await getNotifications();
    notifications.insert(0, notification);
    await _saveNotifications(notifications);
  }

  Future<void> markAsRead(String notificationId) async {
    final notifications = await getNotifications();
    final index = notifications.indexWhere((n) => n.id == notificationId);
    if (index != -1) {
      notifications[index] = notifications[index].copyWith(isRead: true);
      await _saveNotifications(notifications);
    }
  }

  Future<void> deleteNotification(String notificationId) async {
    final notifications = await getNotifications();
    notifications.removeWhere((n) => n.id == notificationId);
    await _saveNotifications(notifications);
  }

  Future<void> clearAll() async {
    await _prefs.remove(_storageKey);
  }

  Future<void> _saveNotifications(List<NotificationModel> notifications) async {
    final encodedList = notifications.map((n) => n.toJson()).toList();
    await _prefs.setString(_storageKey, json.encode(encodedList));
  }
}
