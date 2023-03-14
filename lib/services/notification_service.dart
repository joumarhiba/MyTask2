
import 'package:awesome_notifications/awesome_notifications.dart';

class NotificationService {
  displayNotification() {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 33,
            channelKey: 'basic_channel',
            title: 'Notification test',
            body: 'IT WORKED'));
  }
}
