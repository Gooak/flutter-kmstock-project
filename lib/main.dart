// @dart=2.9

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:untitled/app.dart';
import 'package:untitled/src/controller/app_controller.dart';
import 'package:untitled/src/init.binding.dart';
import 'package:untitled/src/page/Financial/financial_chart.dart';
import 'package:untitled/src/page/event/event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/src/page/homeMain/tap/news.dart';
import 'package:untitled/src/page/homeMain/tap/reportmain.dart';
import 'package:untitled/src/page/stockMain/stock.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:untitled/root.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //FirebaseMessaging.onBackgroundMessage(firebasePushHandler);
/*  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(channelKey: 'key1', channelName: 'proto Coders Point', channelDescription: 'Notification example',
      defaultColor: Color(0XFF9050DD),
      ledColor: Colors.white,
      playSound: true,
      enableLights: true,
      enableVibration: true
      )
    ]
  );*/
  runApp(MyApp());
  configLoading();
}
void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Icon(
          Icons.apartment_outlined,
          size: MediaQuery.of(context).size.width * 0.785,
        ),
      ),
    );
  }
}
class MyApp extends StatelessWidget {
  static const MaterialColor kToDark = const MaterialColor(
    0xff000000, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    const <int, Color>{
      50: const Color(0xff000000),//10%
      100: const Color(0xff000000),//20%
      200: const Color(0xff000000),//30%
      300: const Color(0xff000000),//40%
      400: const Color(0xff000000),//50%
      500: const Color(0xff000000),//60%
      600: const Color(0xff000000),//70%
      700: const Color(0xff000000),//80%
      800: const Color(0xff000000),//90%
      900: const Color(0xff000000),//100%
    },
  );

  //Timer? _timer;
  //aconst MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.grey,
      systemNavigationBarColor: Colors.black,
    ));
/*    final ThemeData _darkTheme = ThemeData(
        accentColor: Colors.red,
        brightness: Brightness.dark,
        primaryColor: Colors.amber,
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.amber,
          disabledColor: Colors.grey,
        ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(primary: Colors.white),
      ),
    );*/
    final textStyle = TextStyle(color: Colors.white);
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
      title: 'KM Stock',
        builder: EasyLoading.init(),
      initialBinding: InitBinding(),
      themeMode: ThemeMode.system,
      theme: ThemeData(
        primaryColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),/*ThemeData.light().copyWith(
        textTheme: ThemeData.light().textTheme.apply(
          fontFamily: 'text',
        ),
        primaryTextTheme: ThemeData.light().textTheme.apply(
          fontFamily: 'text',
        ),
        primaryColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),*/
      darkTheme: ThemeData.dark().copyWith(
        textTheme: ThemeData.dark().textTheme.apply(
          fontFamily: 'text',
        ),
        primaryTextTheme: ThemeData.dark().textTheme.apply(
          fontFamily: 'text',
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: Colors.white,
          ),
        ),
      ),
      home: Root(),
/*      getPages: [
        GetPage(name: "/report/:reportid", page: ()=>Report()),
        GetPage(name: "/news/:newsid", page: ()=>News()),
        GetPage(name: "/event/:eventid", page: ()=>Event()),
        GetPage(name: "/stock/:stockid", page: ()=>Stock()),
        GetPage(name: "/fin_chart/:fin_chartid", page: ()=>Fin_Chart()),]*/
    );
  }
}
/*Future<void> firebasePushHandler(RemoteMessage message) {
  print("Message ${message.data}");

  FirebaseMessaging.onMessage.listen((message) async{

    print(message.messageId);
    print(message.contentAvailable);
    print(message.notification.body);

  });

  AwesomeNotifications().createNotificationFromJsonData(message.data);
}*/


