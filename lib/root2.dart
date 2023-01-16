/*import 'dart:html';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project2/src/controller/app_controller.dart';
import 'package:project2/src/page/Financial/financial.dart';
import 'package:project2/src/page/community/community.dart';
import 'package:project2/src/page/event/event.dart';
import 'package:project2/src/page/homeMain/home.dart';
import 'package:project2/src/page/stockMain/stock.dart';

class App extends GetView<AppController> {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx((){
        if(controller.curretIndex.value==0)
          return Home();
        if(controller.curretIndex.value==1)
          return Financial();
        if(controller.curretIndex.value==2)
          return Stock();
        if(controller.curretIndex.value==3)
          return Event();
        if(controller.curretIndex.value==4)
          return Community();
      }),
      bottomNavigationBar: Obx(
            ()=>BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: controller.curretIndex.value,
        showUnselectedLabels: true,
        onTap: controller.changePage,
        items: [
      BottomNavigationBarItem(
      icon: Icon(Icons.home,color: Colors.black,),
        title: Text('홈',style: TextStyle(color: Colors.black),),
        activeIcon: Icon(Icons.home,color: Colors.blue,)),
      BottomNavigationBarItem(
        icon: Icon(Icons.text_snippet_outlined,color: Colors.black,),
        title: Text('재무제표',style: TextStyle(color: Colors.black),),
        activeIcon: Icon(Icons.text_snippet_outlined,color: Colors.blue,)),
      BottomNavigationBarItem(
        icon: Icon(Icons.bar_chart,color: Colors.black,),
        title: Text('증시시황',style: TextStyle(color: Colors.black),),
        activeIcon: Icon(Icons.bar_chart,color: Colors.blue,)),
      BottomNavigationBarItem(
        icon: Icon(Icons.search,color: Colors.black,),
        title: Text('종목발굴',style: TextStyle(color: Colors.black),),
        activeIcon: Icon(Icons.search,color: Colors.blue,)),
      BottomNavigationBarItem(
        icon: Icon(Icons.chat,color: Colors.black,),
        title: Text('커뮤니티',style: TextStyle(color: Colors.black),),
        activeIcon: Icon(Icons.chat,color: Colors.blue,)),
      ],
      ),),
    );
  }
}*/
