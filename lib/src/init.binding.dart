import 'package:get/get.dart';
import 'package:untitled/src/controller/app_controller.dart';
import 'package:untitled/src/controller/auth_controller.dart';
import 'package:untitled/src/controller/notificationcontroller.dart';

class InitBinding implements Bindings{
  void dependencies(){
    Get.put(AppController(), permanent: true);
    Get.put(AuthController(),permanent: true);
    Get.put(NotificationController(),permanent: true);
  }
}