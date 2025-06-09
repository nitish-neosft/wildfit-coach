import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../bloc/notification_bloc.dart';
import '../../domain/models/notification_model.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Clear All Notifications'),
                  content: const Text(
                    'Are you sure you want to clear all notifications?',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        context
                            .read<NotificationBloc>()
                            .add(ClearAllNotifications());
                        Navigator.pop(context);
                      },
                      child: const Text('Clear All'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
          if (state is NotificationLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is NotificationError) {
            return Center(child: Text(state.message));
          }

          if (state is NotificationLoaded) {
            if (state.notifications.isEmpty) {
              return const Center(
                child: Text('No notifications'),
              );
            }

            return ListView.builder(
              itemCount: state.notifications.length,
              itemBuilder: (context, index) {
                final notification = state.notifications[index];
                return NotificationTile(notification: notification);
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class NotificationTile extends StatelessWidget {
  final NotificationModel notification;

  const NotificationTile({
    super.key,
    required this.notification,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dismissible(
      key: Key(notification.id),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16.0),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (_) {
        context
            .read<NotificationBloc>()
            .add(DeleteNotification(notification.id));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Notification deleted')),
        );
      },
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: notification.isRead
              ? theme.colorScheme.surfaceVariant
              : theme.colorScheme.primary,
          child: Icon(
            Icons.notifications,
            color: notification.isRead
                ? theme.colorScheme.onSurfaceVariant
                : theme.colorScheme.onPrimary,
          ),
        ),
        title: Text(
          notification.title,
          style: TextStyle(
            fontWeight:
                notification.isRead ? FontWeight.normal : FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(notification.body),
            const SizedBox(height: 4),
            Text(
              DateFormat.yMMMd().add_jm().format(notification.timestamp),
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
        onTap: () {
          if (!notification.isRead) {
            context
                .read<NotificationBloc>()
                .add(MarkNotificationAsRead(notification.id));
          }
          _showNotificationDetails(context, notification);
        },
      ),
    );
  }

  void _showNotificationDetails(
    BuildContext context,
    NotificationModel notification,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              notification.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              DateFormat.yMMMd().add_jm().format(notification.timestamp),
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 16),
            Text(
              notification.body,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            if (notification.data != null) ...[
              const SizedBox(height: 16),
              const Text(
                'Additional Data:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(notification.data.toString()),
            ],
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
