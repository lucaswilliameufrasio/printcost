import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Local notification when a print finishes or fails.
abstract interface class PrintNotifier {
  Future<void> requestPermission();
  Future<void> show({
    required int id,
    required String title,
    required String body,
  });
}

class LocalPrintNotifier implements PrintNotifier {
  LocalPrintNotifier({required this.channelName});
  final String channelName;
  final _plugin = FlutterLocalNotificationsPlugin();
  bool _initialized = false;

  Future<void> _init() async {
    if (_initialized) return;
    await _plugin.initialize(
      settings: const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(),
      ),
    );
    _initialized = true;
  }

  @override
  Future<void> requestPermission() async {
    await _init();
    await _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();
  }

  @override
  Future<void> show({
    required int id,
    required String title,
    required String body,
  }) async {
    await _init();
    await _plugin.show(
      id: id,
      title: title,
      body: body,
      notificationDetails: NotificationDetails(
        android: AndroidNotificationDetails(
          'printer_status',
          channelName,
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: const DarwinNotificationDetails(),
      ),
    );
  }
}

class NoopPrintNotifier implements PrintNotifier {
  final shown = <(String, String)>[];

  @override
  Future<void> requestPermission() async {}

  @override
  Future<void> show({
    required int id,
    required String title,
    required String body,
  }) async => shown.add((title, body));
}
