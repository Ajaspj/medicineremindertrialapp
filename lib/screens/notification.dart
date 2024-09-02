import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

class NotificationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notificationsPlugin =
        Provider.of<FlutterLocalNotificationsPlugin>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Scheduled Notifications',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            letterSpacing: 1.2,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder<List<PendingNotificationRequest>>(
        future: _getPendingNotifications(notificationsPlugin),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No notifications scheduled.'));
          } else {
            final notifications = snapshot.data!;

            return ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];

                return ListTile(
                  title: Text(notification.title ?? 'No Title'),
                  subtitle: Text(notification.body ?? 'No Body'),
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<List<PendingNotificationRequest>> _getPendingNotifications(
      FlutterLocalNotificationsPlugin plugin) async {
    try {
      return await plugin.pendingNotificationRequests();
    } catch (e) {
      print('Error fetching notifications: $e');
      return [];
    }
  }
}
