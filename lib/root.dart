import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:untitled/app.dart';
import 'package:untitled/src/User/singup/login.dart';
import 'package:untitled/src/User/singup/signup_page.dart';
import 'package:untitled/src/controller/auth_controller.dart';

import 'src/model/model.dart';

class Root extends GetView<AuthController> {
  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder (
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext _, AsyncSnapshot<User?> user) {
        if(user.hasData) {
          print("hasdata : ${user.data}");
            return FutureBuilder<KmUser?>(
                future: controller.loginUser(user.data!.uid),
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                    return App();
                  }
                  else{
                    return Obx(
                            ()=> controller.user.value.uid !=null
                                ? App()
                                :SignupPage(uid: user.data!.uid));
                  }
            });
          }
        else {
          return Login();
        }
      },
    );
  }

/*  @override
  Widget build(BuildContext context) {
    return StreamBuilder (
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext _, AsyncSnapshot<User?> user) {
        if(user.hasData) {
          return FutureBuilder<KmUser?>(
              future: controller.loginUser(user.data!.uid),
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  return App();
                }
                else{
                  return SignupPage(uid: user.data!.uid);
                }
                return App();
              });
        }
        else {
          return Login();
        }
      },
    );
  }*/
}
