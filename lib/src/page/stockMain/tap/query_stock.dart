import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as https;

import 'internal.dart';
String strToday ='';
String strYesterday='';
void getToday() {
  DateTime now = DateTime.now();
  DateTime Yester = now.subtract(Duration(days: 1));
  DateFormat formatter = DateFormat('yyyyMMdd');
  strToday = formatter.format(now);
  strYesterday = formatter.format(Yester);
  print(strToday);
  print(strYesterday);
}
class Query_stock{
  //////////////////////////////상승률
  String ascent_rate1 ='';
  String ascent_rate2 ='';
  String ascent_rate3 ='';
  String ascent_rate4 ='';
  String ascent_rate5 ='';

  String KOSDAQ_ascent_rate1 ='';
  String KOSDAQ_ascent_rate2 ='';
  String KOSDAQ_ascent_rate3 ='';
  String KOSDAQ_ascent_rate4 ='';
  String KOSDAQ_ascent_rate5 ='';
  /////////////////////////////이름

  String ascent_rate6 ='';
  String ascent_rate7 ='';
  String ascent_rate8 ='';
  String ascent_rate9 ='';
  String ascent_rate10 ='';

  String KOSDAQ_ascent_rate6 ='';
  String KOSDAQ_ascent_rate7 ='';
  String KOSDAQ_ascent_rate8 ='';
  String KOSDAQ_ascent_rate9 ='';
  String KOSDAQ_ascent_rate10 ='';
  /////////////////////////////퍼센트

  //////////////////////////////하락률
  String rate_of_decline1 ='';
  String rate_of_decline2 ='';
  String rate_of_decline3 ='';
  String rate_of_decline4 ='';
  String rate_of_decline5 ='';

  String KOSDAQ_rate_of_decline1 ='';
  String KOSDAQ_rate_of_decline2 ='';
  String KOSDAQ_rate_of_decline3 ='';
  String KOSDAQ_rate_of_decline4 ='';
  String KOSDAQ_rate_of_decline5 ='';
  /////////////////////////////이름

  String rate_of_decline6 ='';
  String rate_of_decline7 ='';
  String rate_of_decline8 ='';
  String rate_of_decline9 ='';
  String rate_of_decline10 ='';

  String KOSDAQ_rate_of_decline6 ='';
  String KOSDAQ_rate_of_decline7 ='';
  String KOSDAQ_rate_of_decline8 ='';
  String KOSDAQ_rate_of_decline9 ='';
  String KOSDAQ_rate_of_decline10 ='';
  /////////////////////////////퍼센트

  Future <void> Find_ascent_rate(String ascent_rate, rate_of_decline, KOSDAQ_ascent_rate, KOSDAQ_rate_of_decline) async
  {
    String url1 = "http://kmuproject.kro.kr:5568/sql/${ascent_rate}";
    String Changed_String1 = url1.replaceAll(' ', '!');
    var response1 = await https.get(Uri.parse(Changed_String1));

    var statusCode1 = response1.statusCode;
    var responseHeaders1 = response1.headers;
    var responseBody1 = response1.body;

    List list1 = jsonDecode(responseBody1);

    /*print("statusCode: ${statusCode1}");
    print("responseHeaders: ${responseHeaders1}");*/
    print("responseBody: ${responseBody1}");

    ascent_rate6 = list1[0]['\ub4f1\ub77d\uc728'].toString(); //퍼센트
    ascent_rate1 = list1[0]['\uc885\ubaa9\uba85'].toString(); //이름

    ascent_rate7 = list1[1]['\ub4f1\ub77d\uc728'].toString();
    ascent_rate2 = list1[1]['\uc885\ubaa9\uba85'].toString();

    ascent_rate8 =list1[2]['\ub4f1\ub77d\uc728'].toString();
    ascent_rate3 =list1[2]['\uc885\ubaa9\uba85'].toString();

    ascent_rate9 = list1[3]['\ub4f1\ub77d\uc728'].toString();
    ascent_rate4 =list1[3]['\uc885\ubaa9\uba85'].toString();

    ascent_rate10 = list1[4]['\ub4f1\ub77d\uc728'].toString();
    ascent_rate5 = list1[4]['\uc885\ubaa9\uba85'].toString();

/*  print(list1[0]['\ub4f1\ub77d\uc728']); //퍼센트
    print(list1[0]['\uc885\ubaa9\uba85']); //이름

    print(list1[1]['\ub4f1\ub77d\uc728']);
    print(list1[1]['\uc885\ubaa9\uba85']);

    print(list1[2]['\ub4f1\ub77d\uc728']);
    print(list1[2]['\uc885\ubaa9\uba85']);

    print(list1[3]['\ub4f1\ub77d\uc728']);
    print(list1[3]['\uc885\ubaa9\uba85']);

    print(list1[4]['\ub4f1\ub77d\uc728']);
    print(list1[4]['\uc885\ubaa9\uba85']);*/

    String url2 = "http://kmuproject.kro.kr:5568/sql/${rate_of_decline}";
    String Changed_String2 = url2.replaceAll(' ', '!');
    var response2 = await https.get(Uri.parse(Changed_String2));

    var statusCode2 = response2.statusCode;
    var responseHeaders2 = response2.headers;
    var responseBody2 = response2.body;

    List list2 = jsonDecode(responseBody2);

    /*print("statusCode: ${statusCode1}");
    print("responseHeaders: ${responseHeaders1}");*/
    print("responseBody: ${responseBody2}");

    rate_of_decline6 = list2[0]['\ub4f1\ub77d\uc728'].toString(); //퍼센트
    rate_of_decline1 = list2[0]['\uc885\ubaa9\uba85'].toString(); //이름

    rate_of_decline7 = list2[1]['\ub4f1\ub77d\uc728'].toString();
    rate_of_decline2 = list2[1]['\uc885\ubaa9\uba85'].toString();

    rate_of_decline8 =list2[2]['\ub4f1\ub77d\uc728'].toString();
    rate_of_decline3 =list2[2]['\uc885\ubaa9\uba85'].toString();

    rate_of_decline9 = list2[3]['\ub4f1\ub77d\uc728'].toString();
    rate_of_decline4 =list2[3]['\uc885\ubaa9\uba85'].toString();

    rate_of_decline10 = list2[4]['\ub4f1\ub77d\uc728'].toString();
    rate_of_decline5 = list2[4]['\uc885\ubaa9\uba85'].toString();

/*  print(list1[0]['\ub4f1\ub77d\uc728']); //퍼센트
    print(list1[0]['\uc885\ubaa9\uba85']); //이름

    print(list1[1]['\ub4f1\ub77d\uc728']);
    print(list1[1]['\uc885\ubaa9\uba85']);

    print(list1[2]['\ub4f1\ub77d\uc728']);
    print(list1[2]['\uc885\ubaa9\uba85']);

    print(list1[3]['\ub4f1\ub77d\uc728']);
    print(list1[3]['\uc885\ubaa9\uba85']);

    print(list1[4]['\ub4f1\ub77d\uc728']);
    print(list1[4]['\uc885\ubaa9\uba85']);*/

    String url3 = "http://kmuproject.kro.kr:5568/sql/${KOSDAQ_ascent_rate}";
    String Changed_String3 = url3.replaceAll(' ', '!');
    var response3 = await https.get(Uri.parse(Changed_String3));

    var statusCode3 = response3.statusCode;
    var responseHeaders3 = response3.headers;
    var responseBody3 = response3.body;

    List list3 = jsonDecode(responseBody3);

    /*print("statusCode: ${statusCode1}");
    print("responseHeaders: ${responseHeaders1}");*/
    //print("responseBody: ${responseBody1}");

    KOSDAQ_ascent_rate6 = list3[0]['\ub4f1\ub77d\uc728'].toString(); //퍼센트
    KOSDAQ_ascent_rate1 = list3[0]['\uc885\ubaa9\uba85'].toString(); //이름

    KOSDAQ_ascent_rate7 = list3[1]['\ub4f1\ub77d\uc728'].toString();
    KOSDAQ_ascent_rate2 = list3[1]['\uc885\ubaa9\uba85'].toString();

    KOSDAQ_ascent_rate8 =list3[2]['\ub4f1\ub77d\uc728'].toString();
    KOSDAQ_ascent_rate3 =list3[2]['\uc885\ubaa9\uba85'].toString();

    KOSDAQ_ascent_rate9 = list3[3]['\ub4f1\ub77d\uc728'].toString();
    KOSDAQ_ascent_rate4 =list3[3]['\uc885\ubaa9\uba85'].toString();

    KOSDAQ_ascent_rate10 = list3[4]['\ub4f1\ub77d\uc728'].toString();
    KOSDAQ_ascent_rate5 = list3[4]['\uc885\ubaa9\uba85'].toString();

/*  print(list1[0]['\ub4f1\ub77d\uc728']); //퍼센트
    print(list1[0]['\uc885\ubaa9\uba85']); //이름

    print(list1[1]['\ub4f1\ub77d\uc728']);
    print(list1[1]['\uc885\ubaa9\uba85']);

    print(list1[2]['\ub4f1\ub77d\uc728']);
    print(list1[2]['\uc885\ubaa9\uba85']);

    print(list1[3]['\ub4f1\ub77d\uc728']);
    print(list1[3]['\uc885\ubaa9\uba85']);

    print(list1[4]['\ub4f1\ub77d\uc728']);
    print(list1[4]['\uc885\ubaa9\uba85']);*/

    String url4 = "http://kmuproject.kro.kr:5568/sql/${KOSDAQ_rate_of_decline}";
    String Changed_String4 = url4.replaceAll(' ', '!');
    var response4 = await https.get(Uri.parse(Changed_String4));

    var statusCode4 = response4.statusCode;
    var responseHeaders4 = response4.headers;
    var responseBody4 = response4.body;

    List list4 = jsonDecode(responseBody4);

    /*print("statusCode: ${statusCode1}");
    print("responseHeaders: ${responseHeaders1}");*/
   //print("responseBody: ${responseBody4}");

    KOSDAQ_rate_of_decline6 = list4[0]['\ub4f1\ub77d\uc728'].toString(); //퍼센트
    KOSDAQ_rate_of_decline1 = list4[0]['\uc885\ubaa9\uba85'].toString(); //이름

    KOSDAQ_rate_of_decline7 = list4[1]['\ub4f1\ub77d\uc728'].toString();
    KOSDAQ_rate_of_decline2 = list4[1]['\uc885\ubaa9\uba85'].toString();

    KOSDAQ_rate_of_decline8 =list4[2]['\ub4f1\ub77d\uc728'].toString();
    KOSDAQ_rate_of_decline3 =list4[2]['\uc885\ubaa9\uba85'].toString();

    KOSDAQ_rate_of_decline9 = list4[3]['\ub4f1\ub77d\uc728'].toString();
    KOSDAQ_rate_of_decline4 =list4[3]['\uc885\ubaa9\uba85'].toString();

    KOSDAQ_rate_of_decline10 = list4[4]['\ub4f1\ub77d\uc728'].toString();
    KOSDAQ_rate_of_decline5 = list4[4]['\uc885\ubaa9\uba85'].toString();

/*  print(list1[0]['\ub4f1\ub77d\uc728']); //퍼센트
    print(list1[0]['\uc885\ubaa9\uba85']); //이름

    print(list1[1]['\ub4f1\ub77d\uc728']);
    print(list1[1]['\uc885\ubaa9\uba85']);

    print(list1[2]['\ub4f1\ub77d\uc728']);
    print(list1[2]['\uc885\ubaa9\uba85']);

    print(list1[3]['\ub4f1\ub77d\uc728']);
    print(list1[3]['\uc885\ubaa9\uba85']);

    print(list1[4]['\ub4f1\ub77d\uc728']);
    print(list1[4]['\uc885\ubaa9\uba85']);*/
  }

  //////////////////////////////신고가
  String high1 ='';
  String high2 ='';
  String high3 ='';
  String high4 ='';
  String high5 ='';

  String KOSDAQ_high1 ='';
  String KOSDAQ_high2 ='';
  String KOSDAQ_high3 ='';
  String KOSDAQ_high4 ='';
  String KOSDAQ_high5 ='';
  /////////////////////////////이름
  String high6 ='';
  String high7 ='';
  String high8 ='';
  String high9 ='';
  String high10 ='';

  String KOSDAQ_high6 ='';
  String KOSDAQ_high7 ='';
  String KOSDAQ_high8 ='';
  String KOSDAQ_high9 ='';
  String KOSDAQ_high10 ='';
  /////////////////////////////퍼센트

  //////////////////////////////신저가
  String low1 ='';
  String low2 ='';
  String low3 ='';
  String low4 ='';
  String low5 ='';

  String KOSDAQ_low1 ='';
  String KOSDAQ_low2 ='';
  String KOSDAQ_low3 ='';
  String KOSDAQ_low4 ='';
  String KOSDAQ_low5 ='';
  /////////////////////////////이름

  String low6 ='';
  String low7 ='';
  String low8 ='';
  String low9 ='';
  String low10 ='';

  String KOSDAQ_low6 ='';
  String KOSDAQ_low7 ='';
  String KOSDAQ_low8 ='';
  String KOSDAQ_low9 ='';
  String KOSDAQ_low10 ='';
  /////////////////////////////퍼센트
  Future <void> Find_low_high(String new_high, new_low, KOSDAQ_new_high, KOSDAQ_new_low) async
  {
    getToday();
    String url1 = "http://kmuproject.kro.kr:5568/sql/${new_high}";
    String Changed_String1 = url1.replaceAll(' ', '!');
    var response1 = await https.get(Uri.parse(Changed_String1));

    var statusCode1 = response1.statusCode;
    var responseHeaders1 = response1.headers;
    var responseBody1 = response1.body;

    List list1 = jsonDecode(responseBody1);

/*    print("statusCode: ${statusCode1}");
    print("responseHeaders: ${responseHeaders1}");
    print("responseBody: ${responseBody1}");*/

    Internal_main main = Internal_main();

    high6 = list1[0]["\ub4f1\ub77d\uc728"].toString(); //퍼센트
    high1 = list1[0]['\uc885\ubaa9\uba85'].toString(); //이름

    high7 = list1[1]["\ub4f1\ub77d\uc728"].toString();
    high2 = list1[1]['\uc885\ubaa9\uba85'].toString();

    high8 = list1[2]["\ub4f1\ub77d\uc728"].toString();
    high3 =list1[2]['\uc885\ubaa9\uba85'].toString();

    high9 = list1[3]["\ub4f1\ub77d\uc728"].toString();
    high4 =list1[3]['\uc885\ubaa9\uba85'].toString();

    high10 = list1[4]["\ub4f1\ub77d\uc728"].toString();
    high5 = list1[4]['\uc885\ubaa9\uba85'].toString();


    String url2 = "http://kmuproject.kro.kr:5568/sql/${new_low}";
    String Changed_String2 = url2.replaceAll(' ', '!');
    var response2 = await https.get(Uri.parse(Changed_String2));

    var statusCode2 = response2.statusCode;
    var responseHeaders2 = response2.headers;
    var responseBody2 = response2.body;

    List list2 = jsonDecode(responseBody2);

    /*print("statusCode: ${statusCode1}");
    print("responseHeaders: ${responseHeaders1}");*/
    //print("responseBody: ${responseBody2}");

    low6 = list2[0]["\ub4f1\ub77d\uc728"].toString(); //퍼센트
    low1 = list2[0]['\uc885\ubaa9\uba85'].toString(); //이름

    low7 = list2[1]["\ub4f1\ub77d\uc728"].toString();
    low2 = list2[1]['\uc885\ubaa9\uba85'].toString();

    low8 = list2[2]["\ub4f1\ub77d\uc728"].toString();
    low3 =list2[2]['\uc885\ubaa9\uba85'].toString();

    low9 = list2[3]["\ub4f1\ub77d\uc728"].toString();
    low4 =list2[3]['\uc885\ubaa9\uba85'].toString();

    low10 = list2[4]["\ub4f1\ub77d\uc728"].toString();
    low5 = list2[4]['\uc885\ubaa9\uba85'].toString();

    String url3 = "http://kmuproject.kro.kr:5568/sql/${KOSDAQ_new_high}";
    String Changed_String3 = url3.replaceAll(' ', '!');
    var response3 = await https.get(Uri.parse(Changed_String3));

    var statusCode3 = response3.statusCode;
    var responseHeaders3 = response3.headers;
    var responseBody3 = response3.body;

    List list3 = jsonDecode(responseBody3);
/*
    print("statusCode: ${statusCode1}");
    print("responseHeaders: ${responseHeaders1}");*/
    //print("responseBody: ${responseBody3}");


    KOSDAQ_high6 = list3[0]["\ub4f1\ub77d\uc728"].toString(); //퍼센트
    KOSDAQ_high1 = list3[0]['\uc885\ubaa9\uba85'].toString(); //이름

    KOSDAQ_high7 = list3[1]["\ub4f1\ub77d\uc728"].toString();
    KOSDAQ_high2 = list3[1]['\uc885\ubaa9\uba85'].toString();

    KOSDAQ_high8 = list3[2]["\ub4f1\ub77d\uc728"].toString();
    KOSDAQ_high3 =list3[2]['\uc885\ubaa9\uba85'].toString();

    KOSDAQ_high9 = list3[3]["\ub4f1\ub77d\uc728"].toString();
    KOSDAQ_high4 =list3[3]['\uc885\ubaa9\uba85'].toString();

    KOSDAQ_high10 = list3[4]["\ub4f1\ub77d\uc728"].toString();
    KOSDAQ_high5 = list3[4]['\uc885\ubaa9\uba85'].toString();


    String url4 = "http://kmuproject.kro.kr:5568/sql/${KOSDAQ_new_low}";
    String Changed_String4 = url4.replaceAll(' ', '!');
    var response4 = await https.get(Uri.parse(Changed_String4));

    var statusCode4 = response4.statusCode;
    var responseHeaders4 = response4.headers;
    var responseBody4 = response4.body;

    List list4 = jsonDecode(responseBody4);

/*    print("statusCode: ${statusCode1}");
    print("responseHeaders: ${responseHeaders1}");*/
    //print("responseBody: ${responseBody4}");

    KOSDAQ_low6 = list4[0]["\ub4f1\ub77d\uc728"].toString(); //퍼센트
    KOSDAQ_low1 = list4[0]['\uc885\ubaa9\uba85'].toString(); //이름

    KOSDAQ_low7 = list4[1]["\ub4f1\ub77d\uc728"].toString();
    KOSDAQ_low2 = list4[1]['\uc885\ubaa9\uba85'].toString();

    KOSDAQ_low8 = list4[2]["\ub4f1\ub77d\uc728"].toString();
    KOSDAQ_low3 =list4[2]['\uc885\ubaa9\uba85'].toString();

    KOSDAQ_low9 = list4[3]["\ub4f1\ub77d\uc728"].toString();
    KOSDAQ_low4 =list4[3]['\uc885\ubaa9\uba85'].toString();

    KOSDAQ_low10 = list4[4]["\ub4f1\ub77d\uc728"].toString();
    KOSDAQ_low5 = list4[4]['\uc885\ubaa9\uba85'].toString();
  }
}