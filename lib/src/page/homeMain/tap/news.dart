import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';
import 'dart:io';

class News extends StatefulWidget {

  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  final Completer<WebViewController> _controller = Completer<WebViewController>();
  String name =Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("뉴스"),
      ),
      body: Container(
        child: WebView(
          //initialUrl: 'https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=1&ie=utf8&query='+name,
          initialUrl: name,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
        ),
      ),
    floatingActionButton: FutureBuilder<WebViewController>(
    future: _controller.future,
        builder: (BuildContext context,
            AsyncSnapshot<WebViewController> controller) {
          if (controller.hasData) {
            return FloatingActionButton(
                child: Icon(Icons.arrow_back),
                onPressed: () {
                  controller.data!.goBack();
                });
          }
          return Container();
        }
    ),);
  }
}

