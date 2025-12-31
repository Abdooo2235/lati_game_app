import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void showNotification() {
  // ignore: unused_local_variable
  AndroidNotificationDetails androidNotificationDetails =
      const AndroidNotificationDetails(
    "",
    "",
    icon: "",
    importance: Importance.high,
    priority: Priority.max,
    enableVibration: true,
    showWhen: false,
  );
}
