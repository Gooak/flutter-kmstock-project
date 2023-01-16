import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:untitled/src/page/Financial/financial.dart';
import 'package:untitled/src/page/event/event.dart';
import 'package:untitled/src/page/homeMain/tap/news.dart';
import 'package:untitled/src/page/homeMain/tap/reportmain.dart';
import 'package:untitled/src/page/stockMain/stock.dart';
import 'package:http/http.dart' as https;
import 'dart:convert';

class Query_home {

  String kmstock1 = '';
  String kmstock2 = '';
  String kmstock3 = '';
  Future<void> Find_kmstock() async
  {
    String url1 = "http://kmuproject.kro.kr:5568/kmscore";
    String Changed_String1 = url1.replaceAll(' ', '!');
    var response1 = await https.get(Uri.parse(Changed_String1));

    var statusCode1 = response1.statusCode;
    var responseHeaders1 = response1.headers;
    var responseBody1 = response1.body;

    List list1 = jsonDecode(responseBody1);

/*    print("statusCode: ${statusCode1}");
    print("responseHeaders: ${responseHeaders1}");*/
    print("responseBody: ${responseBody1}");

    kmstock1 = list1[0]["stock_name"].toString();
    kmstock2 = list1[1]["stock_name"].toString();
    kmstock3 = list1[2]["stock_name"].toString();
  }

  //////////////뉴스데이터
  String title1="";
  String title2="";
  String title3="";
  String title4="";
  String title5="";

  String link1="";
  String link2="";
  String link3="";
  String link4="";
  String link5="";

  String date1="";
  String date2="";
  String date3="";
  String date4="";
  String date5="";

  Future<void> Find_hot_news(String hot_news,) async
  {
    String url1 = "http://kmuproject.kro.kr:5568/sql/${hot_news}";
    String Changed_String1 = url1.replaceAll(' ', '!');
    var response1 = await https.get(Uri.parse(Changed_String1));

    var statusCode1 = response1.statusCode;
    var responseHeaders1 = response1.headers;
    var responseBody1 = response1.body;

    List list1 = jsonDecode(responseBody1);

/*    print("statusCode: ${statusCode1}");
    print("responseHeaders: ${responseHeaders1}");*/
    print("responseBody: ${responseBody1}");


    title1 = list1[0]['title'].toString(); //퍼센트

    title2 = list1[1]['title'].toString();

    title3 = list1[2]['title'].toString();

    title4 = list1[3]['title'].toString();

    title5 = list1[4]['title'].toString();

    link1 = list1[0]['link'].toString(); //퍼센트

    link2 = list1[1]['link'].toString();

    link3 = list1[2]['link'].toString();

    link4 = list1[3]['link'].toString();

    link5 = list1[4]['link'].toString();

    date1 = list1[0]['date'].toString(); //퍼센트

    date2 = list1[1]['date'].toString();

    date3 = list1[2]['date'].toString();

    date4 = list1[3]['date'].toString();

    date5 = list1[4]['date'].toString();

  }
  //////////////뉴스데이터

  /////////////종목

  String name1="";
  String name2="";
  String name3="";
  String name4="";
  String name5="";

  String current_price1="";
  String current_price2="";
  String current_price3="";
  String current_price4="";
  String current_price5="";

  String percent1="";
  String percent2="";
  String percent3="";
  String percent4="";
  String percent5="";

  Future<void> Find_stock(String stock) async
  {
    String url1 = "http://kmuproject.kro.kr:5568/sql/${stock}";
    String Changed_String1 = url1.replaceAll(' ', '!');
    var response1 = await https.get(Uri.parse(Changed_String1));

    var statusCode1 = response1.statusCode;
    var responseHeaders1 = response1.headers;
    var responseBody1 = response1.body;

    List list1 = jsonDecode(responseBody1);

    print("statusCode: ${statusCode1}");
    print("responseHeaders: ${responseHeaders1}");
    print("responseBody: ${responseBody1}");


    name1 = list1[0]["\uc885\ubaa9\uba85"].toString(); //퍼센트
    current_price1 = list1[0]["\ud604\uc7ac\uac00"].toString();
    percent1 = list1[0]["\ub4f1\ub77d\uc728"].toString();

    name2 = list1[1]["\uc885\ubaa9\uba85"].toString(); //퍼센트
    current_price2 = list1[1]["\ud604\uc7ac\uac00"].toString();
    percent2 = list1[1]["\ub4f1\ub77d\uc728"].toString();

    name3 = list1[2]["\uc885\ubaa9\uba85"].toString(); //퍼센트
    current_price3 = list1[2]["\ud604\uc7ac\uac00"].toString();
    percent3 = list1[2]["\ub4f1\ub77d\uc728"].toString();

    name4 = list1[3]["\uc885\ubaa9\uba85"].toString(); //퍼센트
    current_price4 = list1[3]["\ud604\uc7ac\uac00"].toString();
    percent4 = list1[3]["\ub4f1\ub77d\uc728"].toString();

    name5 = list1[4]["\uc885\ubaa9\uba85"].toString(); //퍼센트
    current_price5 = list1[4]["\ud604\uc7ac\uac00"].toString();
    percent5 = list1[4]["\ub4f1\ub77d\uc728"].toString();
  }
  /////////////종목
  String Kospi1 = '';
  String Kospi2 = '';

  String Kospdaq1 = '';
  String Kospdaq2 = '';

  Future<void> Find_Kospi_kosdaq(String stock) async
  {
    String url1 = "http://kmuproject.kro.kr:5568/${stock}";
    String Changed_String1 = url1.replaceAll(' ', '!');
    var response1 = await https.get(Uri.parse(Changed_String1));

    var statusCode1 = response1.statusCode;
    var responseHeaders1 = response1.headers;
    var responseBody1 = response1.body;

    List list1 = jsonDecode(responseBody1);

/*    print("statusCode: ${statusCode1}");
    print("responseHeaders: ${responseHeaders1}");*/
    //print("responseBody: ${responseBody1}");

    Kospi1 = list1[0][0];
    Kospi2 = list1[0][1];

    Kospdaq1 = list1[1][0];
    Kospdaq2 = list1[1][1];
  }
}
