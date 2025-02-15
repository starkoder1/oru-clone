import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications_plugin.dart';

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    await requestPermissionAndSubscribe();
    await _setupLocalNotifications();

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Foreground Notification Received: ${message.notification?.title}");
      _showLocalNotification(message);
    });

    // Handle background/tapped messages
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("User tapped on notification: ${message.notification?.title}");
      // Handle navigation or actions here
    });

    // Handle terminated state messages
    _firebaseMessaging.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        print("Notification received when app was terminated: ${message.notification?.title}");
        // Handle navigation here if needed
      }
    });
  }

  // Request permission & subscribe to topic
  Future<void> requestPermissionAndSubscribe() async {
    try {
      await _firebaseMessaging.requestPermission();
      final token = await _firebaseMessaging.getToken();
      print("FCM Token: $token");

      if (token != null) {
        await saveFCMToken(token);
      } else {
        print("Failed to get FCM token.");
      }

      await _firebaseMessaging.subscribeToTopic('test');
      print("Subscribed to topic: test");
    } catch (e) {
      print("Error in requestPermissionAndSubscribe: $e");
    }
  }

  // Save FCM token if not already stored
  Future<void> saveFCMToken(String token) async {
    final DatabaseReference dbRef = FirebaseDatabase.instance.ref();

    try {
      final snapshot = await dbRef.child('fcmTokens').orderByChild('fcmToken').equalTo(token).get();

      if (snapshot.exists) {
        print('FCM Token already exists.');
      } else {
        await dbRef.child('fcmTokens').push().set({
          'fcmToken': token,
          'createdAt': ServerValue.timestamp,
        });
        print('FCM Token saved successfully.');
      }
    } catch (e) {
      print('Failed to save FCM token: $e');
    }
  }

  // Set up local notifications
  Future<void> _setupLocalNotifications() async {
    const AndroidInitializationSettings androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings settings = InitializationSettings(android: androidSettings);
    await _flutterLocalNotificationsPlugin.initialize(settings);

    // Create notification channel for Android
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'channel_id', // Unique channel ID
      'High Importance Notifications', // User-visible name
      description: 'For high-priority notifications', // Optional description
      importance: Importance.high,
      playSound: true,
    );

    await _flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  }

  // Show local notification when app is open
  Future<void> _showLocalNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'channel_id', // Use the same channel ID as created above
      'High Importance Notifications', // User-visible name
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails = NotificationDetails(android: androidDetails);

    await _flutterLocalNotificationsPlugin.show(
     DateTime.now().millisecondsSinceEpoch % 1073741824, // Dynamic ID
      message.notification?.title ?? "No Title",
      message.notification?.body ?? "No Body",
      notificationDetails,
    );
  }
}