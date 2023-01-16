import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/src/controller/auth_controller.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as https;
import '../../model/model.dart';

class SignupPage extends StatefulWidget {
  final String uid;
  const SignupPage({Key? key,required this.uid}) : super(key: key);

  State<SignupPage> createState() => _SignupPage();
}
class _SignupPage extends State<SignupPage>{

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  Widget _image(){
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
            child: SizedBox(
              height: 200,
              width: 200,
              child: Image.asset("images/계명대학교.jpg",fit: BoxFit.cover,),
            ),
        )
      ],
    );
  }
  Widget _name(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: TextField(
        controller: nameController,
        decoration: const InputDecoration(contentPadding: EdgeInsets.all(10),hintText: '별명'),
      ),
    );
  }

  Widget _description(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: TextField(
        controller: descriptionController,
        decoration: const InputDecoration(contentPadding: EdgeInsets.all(10),hintText: '간단 소개'),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('회원가입'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 30,
            ),
            _image(),
            SizedBox(
              height: 30,
            ),
            _name(),
            SizedBox(
              height: 30,
            ),
            _description(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 50),
        child: ElevatedButton(
        onPressed: (){
          var signupUser = KmUser(
            uid: widget.uid,
            name: nameController.text,
            description: descriptionController.text,
          );
          AuthController.to.signup(signupUser);
          _getToken();
        },
        child: const Text('회원가입'),
      ),),
    );
  }
  void _getToken() async{
    String? token= await FirebaseMessaging.instance.getToken();
    try{
      print(token);
      print(widget.uid);
      String url1 = "http://kmuproject.kro.kr:5568/token/${widget.uid}/${token}";
      String Changed_String1 = url1.replaceAll(' ', '!');
      var response1 = await https.get(Uri.parse(Changed_String1));

      var statusCode1 = response1.statusCode;
      var responseHeaders1 = response1.headers;
      var responseBody1 = response1.body;

      List list1 = jsonDecode(responseBody1);
      print(responseBody1);
    } catch(e) {}
  }
}
