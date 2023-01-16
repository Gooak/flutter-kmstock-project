import 'package:get/get.dart';

class AppController extends GetxService{
  static AppController get to =>Get.find();
  RxInt curretIndex = 0.obs;

  void changePage(int index){
    curretIndex(index);
  }
}