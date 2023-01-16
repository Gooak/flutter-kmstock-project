import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/src/controller/app_controller.dart';
import 'package:untitled/src/page/Financial/financial.dart';
import 'package:untitled/src/page/Financial/search.dart';
import 'package:untitled/src/page/community/community.dart';
import 'package:untitled/src/page/event/event.dart';
import 'package:untitled/src/page/homeMain/home.dart';
import 'package:untitled/src/page/stockMain/stock.dart';

class App extends GetView<AppController>{
  App({Key? key}) : super(key: key);

  GlobalKey<NavigatorState> navi_key = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return  Obx(()=>Scaffold(
        body: IndexedStack(index: controller.curretIndex.value,
          children:[
            Navigator(
              key: navi_key,
              onGenerateRoute: (routeSettings){
                return MaterialPageRoute(
                    builder: (context)=> Home()
                );
              },
            ),
            Navigator(
              onGenerateRoute: (routeSettings){
                return MaterialPageRoute(
                    builder: (context)=> search_fin()
                );
              },
            ),
            Navigator(
              onGenerateRoute: (routeSettings){
                return MaterialPageRoute(
                    builder: (context)=> Stock()
                );
              },
            ),
            Navigator(
              onGenerateRoute: (routeSettings){
                return MaterialPageRoute(
                    builder: (context)=> Event()
                );
              },
            ),
            Navigator(
              onGenerateRoute: (routeSettings){
                return MaterialPageRoute(
                    builder: (context)=> Community()
                );
              },
            ),
        ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.curretIndex.value,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          onTap: controller.changePage,
          items: const[
          BottomNavigationBarItem(
              icon: Icon(Icons.home,color: Colors.black,),
              label: '홈',
              activeIcon: Icon(Icons.home,color: Colors.blue,)),
          BottomNavigationBarItem(
              icon: Icon(Icons.text_snippet_outlined,color: Colors.black,),
              label: '종목',
              activeIcon: Icon(Icons.text_snippet_outlined,color: Colors.blue,)),
          BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart,color: Colors.black,),
              label: '증시시황',
              activeIcon: Icon(Icons.bar_chart,color: Colors.blue,)),
          BottomNavigationBarItem(
              icon: Icon(Icons.search,color: Colors.black,),
              label: '종목발굴',
              activeIcon: Icon(Icons.search,color: Colors.blue,)),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat,color: Colors.black,),
              label: '커뮤니티',
              activeIcon: Icon(Icons.chat,color: Colors.blue,)),
        ],selectedLabelStyle: TextStyle(color: Colors.black),
        ),
      ));
  }
}
