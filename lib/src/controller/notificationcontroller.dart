import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationController extends GetxController{
  static NotificationController get to => Get.find();
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  @override
  void onInit() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    // 한번 이걸 프린트해서 콘솔에서 확인해봐도 된다.
    print(settings.authorizationStatus);
    _getToken();
    _onMessage();
    super.onInit();
    super.onInit();
  }
  void _getToken() async{
    String? token= await messaging.getToken();
    try{
      print(token);
    } catch(e) {}
  }


  final AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.', // description
    importance: Importance.max,
  );
  // 2.
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  void _onMessage() async{
    /// * local_notification 관련한 플러그인 활용 *
    ///
    /// 1. 위에서 생성한 channel 을 플러그인 통해 메인 채널로 설정한다.
    /// 2. 플러그인을 초기화하여 추가 설정을 해준다.

    // 1.
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    // 2.
    await flutterLocalNotificationsPlugin.initialize(
        const InitializationSettings(
            android: AndroidInitializationSettings('@mipmap/launcher_icon'), iOS: IOSInitializationSettings()),
        onSelectNotification: (String? payload) async {});

    /// * onMessage 설정 - 이것만 설정해줘도 알림을 받아낼 수 있다. *

    // 1. 콘솔에서 발송하는 메시지를 message 파라미터로 받아온다.
    /// 메시지가 올 때마다 listen 내부 콜백이 실행된다.
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      // android 일 때만 flutterLocalNotification 을 대신 보여주는 거임. 그래서 아래와 같은 조건문 설정.
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description
            ),
          ),


          // 넘겨줄 데이터가 있으면 아래 코드를 써주면 됨.
          // payload: message.data['argument']
        );
      }
      // 개발 확인 용으로 print 구문 추가
      print('foreground 상황에서 메시지를 받았다.');
      // 데이터 유무 확인
      print('Message data: ${message.data}');
      // notification 유무 확인
      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification!.body}');
      }
    });
  }
}