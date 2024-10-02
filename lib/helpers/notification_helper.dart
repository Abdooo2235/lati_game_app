import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void showNotification() {
  AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails(
        "",
        "",
        icon: "",
        importance: Importance.high,
        priority: Priority.max,
        enableVibration: true,
        showWhen: false,
      );
}
