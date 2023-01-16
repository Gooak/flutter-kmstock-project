import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:untitled/app.dart';
import 'package:untitled/src/controller/auth_controller.dart';
import 'package:untitled/src/page/Financial/newbie/newbie_financial.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:untitled/src/page/homeMain/homeMain.dart';
import 'dart:async';

import '../../User/mystock.dart';

class Home extends StatefulWidget {
  @override
  Home_main createState() => Home_main();
}

class Home_main extends State<Home> {
  final GoogleSignIn googleSignIn = GoogleSignIn();

  @override
  void initState() {
    // TODO: implement initState
    print(AuthController.to.user.value.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: refresh,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text("KmStock"),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(16.0),
              ),
            ),
          ),
          body: HomeMain(),
          /*CustomScrollView(
            slivers: [
*/ /*              SliverAppBar(
                centerTitle: true,
                title: Text("KmStock"),
                floating: true,
                snap: true,

              ),*/ /*
              SliverList(
                  delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return GestureDetector(
                      onTap: (){},
                      child: HomeMain(),
                    );
                    },
                    childCount: 1,
                ),
              ),
            ],
          ),*/
          endDrawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                // 프로젝트에 assets 폴더 생성 후 이미지 2개 넣기
                // pubspec.yaml 파일에 assets 주석에 이미지 추가하기
                UserAccountsDrawerHeader(
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: AssetImage('images/계명대학교.jpg'),
                    backgroundColor: Colors.white,
                  ),
                  otherAccountsPictures: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage('images/계명대학교.jpg'),
                    ),
                    // CircleAvatar(
                    //   backgroundColor: Colors.white,
                    //   backgroundImage: AssetImage('assets/profile2.png'),
                    // )
                  ],
                  accountName:
                      Text(AuthController.to.user.value.name.toString()),
                  accountEmail:
                      Text(AuthController.to.user.value.description.toString()),
/*                onDetailsPressed: () {
                  print('arrow is clicked');
                },*/
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40.0),
                          bottomRight: Radius.circular(40.0))),
                ),
                ListTile(
                  leading: Icon(
                    Icons.account_balance_wallet_outlined,
                  ),
                  title: Text('내 주식목록'),
                  onTap: () {
                    Get.to(() => mystock());
                  },
                ),
              ListTile(
                leading: const Icon(Icons.lightbulb_outline,),
                title: Text('Dark/Light'),
                onTap: () {
                  Get.changeTheme(
                    Get.isDarkMode ? ThemeData.light() : ThemeData.dark(),
                  );
                },
              ),
                ListTile(
                  leading: Icon(
                    Icons.logout,
                  ),
                  title: Text('Logout'),
                  onTap: () {
                    print('로그아웃');
                    FirebaseAuth.instance.signOut();
                    googleSignIn.signOut();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> refresh() async {
    HomeMain_new home = HomeMain_new();
    home.initState();
    await Future.delayed(Duration(seconds: 2));
    home.setState(() {});
  }
}
