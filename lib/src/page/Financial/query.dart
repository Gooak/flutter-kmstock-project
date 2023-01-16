import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'financial.dart';
import 'financial_chart.dart';
import 'package:http/http.dart' as https;
import 'package:http/http.dart' as http;

String dartCode ="";
String rcept_no ="";

class fin_Query{
  String chart_up ="images/chart_up.jpg";
  String chart_down ="images/chart_down.jpg";


  String s1='';
  String s2='';
  ////////////////////////////////////////
  String Search_Stock_Code=''; //검색 코드

  String sales1=''; //매출액
  String sales2='';
  String sales3='';
  double d_sales1 = 0;
  double d_sales2 = 0;
  double d_sales3 = 0;
  double s_sales3 = 0;

  String selling1 =''; //판매비와 관리비
  String selling2 ='';
  String selling3 ='';
  double d_selling1 = 0;
  double d_selling2 = 0;
  double d_selling3 = 0;

  String EBIT1 =''; //영업이익
  String EBIT2 ='';
  String EBIT3 ='';
  double d_EBIT1 = 0;
  double d_EBIT2 = 0;
  double d_EBIT3 = 0;

  String net_income1=''; //당기순이익
  String net_income2='';
  String net_income3='';
  double d_net_income1 = 0;
  double d_net_income2 = 0;
  double d_net_income3 = 0;

  int find =2;
  //---------------------------손익계산서
  void Find_finace(String find) async
  {
    String url1 = "http://kmuproject.kro.kr:5568/sql/${find}";
    String Changed_String1 = url1.replaceAll(' ', '!');
    var response1 = await https.get(Uri.parse(Changed_String1));

    var statusCode1 = response1.statusCode;
    var responseHeaders1 = response1.headers;
    var responseBody1 = response1.body;

    List list1 = jsonDecode(responseBody1);

    print("statusCode: ${statusCode1}");
    print("responseHeaders: ${responseHeaders1}");
    print("responseBody: ${responseBody1}");

    print(list1[0]['count']);

    find = list1[0]['count'];
  }

  Future<String> Find_Stock_Code(String Stock_Name) async
  {
    Search_Stock_Code = "SELECT 종목코드 FROM stock.db_20220524 WHERE 종목명 = '${Stock_Name}';";
    String url = "http://kmuproject.kro.kr:5568/sql/${Search_Stock_Code}";
    String Changed_String = url.replaceAll(' ', '!');
    var response = await https.get(Uri.parse(Changed_String));

    var statusCode = response.statusCode;
    var responseHeaders = response.headers;
    var responseBody = response.body;
    List<dynamic> list = jsonDecode(responseBody);

    /* print("statusCode: ${statusCode}");
    print("responseHeaders: ${responseHeaders}");
    print("responseBody: ${responseBody}");*/
    return list[0]['종목코드'];
  }

  void Find_state_of_comprehensive_income(String sales, String selling, String EBIT, String net_income) async
  {
    String url1 = "http://kmuproject.kro.kr:5568/sql/${sales}";
    String Changed_String1 = url1.replaceAll(' ', '!');
    var response1 = await https.get(Uri.parse(Changed_String1));

    var statusCode1 = response1.statusCode;
    var responseHeaders1 = response1.headers;
    var responseBody1 = response1.body;

    //final json = "["+response1.body+"]";

    List list1 = jsonDecode(responseBody1);

    //List list1 = (jsonDecode(json) as List<dynamic>);

    //print("statusCode: ${statusCode1}");
    //print("responseHeaders: ${responseHeaders1}");
    //print("responseBody: ${responseBody1}");

/*    print(list1[0]['bfefrmtrm_amount']);
    print(list1[0]['frmtrm_amount']);
    print(list1[0]['thstrm_amount']);*/

    sales3 = list1[0]['bfefrmtrm_amount'];
    d_sales3 = double.parse(sales3)/100000000;
    sales2 = list1[0]['frmtrm_amount'];
    d_sales2 = double.parse(sales2)/100000000;
    sales1 = list1[0]['thstrm_amount'];
    d_sales1 = double.parse(sales1)/100000000;

    String url2 = "http://kmuproject.kro.kr:5568/sql/${selling}";
    String Changed_String2 = url2.replaceAll(' ', '!');
    var response2 = await https.get(Uri.parse(Changed_String2));

    var statusCode2 = response2.statusCode;
    var responseHeaders2 = response2.headers;
    var responseBody2 = response2.body;

    List list2= jsonDecode(responseBody2);

/*    print("statusCode: ${statusCode2}");
    print("responseHeaders: ${responseHeaders2}");
    print("responseBody: ${responseBody2}");*/

/*    print(list2[0]['bfefrmtrm_amount']);
    print(list2[0]['frmtrm_amount']);
    print(list2[0]['thstrm_amount']);*/

    selling3 = list2[0]['bfefrmtrm_amount'];
    d_selling3 = double.parse(selling3)/100000000;
    selling2 = list2[0]['frmtrm_amount'];
    d_selling2 = double.parse(selling2)/100000000;
    selling1 = list2[0]['thstrm_amount'];
    d_selling1 = double.parse(selling1)/100000000;

    String url3 = "http://kmuproject.kro.kr:5568/sql/${EBIT}";
    String Changed_String3 = url3.replaceAll(' ', '!');
    var response3 = await https.get(Uri.parse(Changed_String3));

    var statusCode3 = response3.statusCode;
    var responseHeaders3 = response3.headers;
    var responseBody3 = response3.body;

    List list3 = jsonDecode(responseBody3);

/*    print("statusCode: ${statusCode3}");
    print("responseHeaders: ${responseHeaders3}");
    print("responseBody: ${responseBody3}");*/

/*    print(list3[0]['bfefrmtrm_amount']);
    print(list3[0]['frmtrm_amount']);
    print(list3[0]['thstrm_amount']);*/

    EBIT3 = list3[0]['bfefrmtrm_amount'];
    d_EBIT3 = double.parse(EBIT3)/100000000;
    EBIT2 = list3[0]['frmtrm_amount'];
    d_EBIT2 = double.parse(EBIT2)/100000000;
    EBIT1 = list3[0]['thstrm_amount'];
    d_EBIT1 = double.parse(EBIT1)/100000000;

    String url4 = "http://kmuproject.kro.kr:5568/sql/${net_income}";
    String Changed_String4 = url4.replaceAll(' ', '!');
    var response4 = await https.get(Uri.parse(Changed_String4));

    var statusCode4 = response4.statusCode;
    var responseHeaders4 = response4.headers;
    var responseBody4 = response4.body;

    List list4 = jsonDecode(responseBody4);

/*    print("statusCode: ${statusCode4}");
    print("responseHeaders: ${responseHeaders4}");
    print("responseBody: ${responseBody4}");*/

/*    print(list4[0]['bfefrmtrm_amount']);
    print(list4[0]['frmtrm_amount']);
    print(list4[0]['thstrm_amount']);*/

    net_income3 = list4[0]['bfefrmtrm_amount'];
    d_net_income3 = double.parse(net_income3)/100000000;
    net_income2 = list4[0]['frmtrm_amount'];
    d_net_income2 = double.parse(net_income2)/100000000;
    net_income1 = list4[0]['thstrm_amount'];
    d_net_income1 = double.parse(net_income1)/100000000;
  }
  //---------------------------손익계산서

  //-------------------------재무상태표
  String Total_assets1=''; //자산총계
  String Total_assets2='';
  String Total_assets3='';
  double d_Total_assets1=0; //자산총계
  double d_Total_assets2=0;
  double d_Total_assets3=0;

  String tangible_assets1=''; //유형자산
  String tangible_assets2='';
  String tangible_assets3='';
  double d_tangible_assets1=0; //유형자산
  double d_tangible_assets2=0;
  double d_tangible_assets3=0;

  String intangible_assets1=''; //무형자산
  String intangible_assets2='';
  String intangible_assets3='';
  double d_intangible_assets1=0; //무형자산
  double d_intangible_assets2=0;
  double d_intangible_assets3=0;

  String cash_equivalents1=''; //현금 및 현금성자산
  String cash_equivalents2='';
  String cash_equivalents3='';
  double d_cash_equivalents1=0; //현금 및 현금성자산
  double d_cash_equivalents2=0;
  double d_cash_equivalents3=0;

  String total_capital1=''; //자본총계
  String total_capital2='';
  String total_capital3='';
  double d_total_capital1=0; //자본총계
  double d_total_capital2=0;
  double d_total_capital3=0;

  String Total_Debt1=''; //부채총계
  String Total_Debt2='';
  String Total_Debt3='';
  double d_Total_Debt1=0; //부채총계
  double d_Total_Debt2=0;
  double d_Total_Debt3=0;

  void Find_statement_of_financial_position(String Total_assets, String tangible_assets, String intangible_assets, String cash_equivalents, String total_capital, String Total_Debt) async
  {
    String url1 = "http://kmuproject.kro.kr:5568/sql/${Total_assets}";
    String Changed_String1 = url1.replaceAll(' ', '!');
    var response1 = await https.get(Uri.parse(Changed_String1));

    var statusCode1 = response1.statusCode;
    var responseHeaders1 = response1.headers;
    var responseBody1 = response1.body;

    List list1 = jsonDecode(responseBody1);

/*    print("statusCode: ${statusCode1}");
    print("responseHeaders: ${responseHeaders1}");
    print("responseBody: ${responseBody1}");*/

/*    print(list1[0]['bfefrmtrm_amount']);
    print(list1[0]['frmtrm_amount']);
    print(list1[0]['thstrm_amount']);*/

    Total_assets3 = list1[0]['bfefrmtrm_amount'];
    d_Total_assets3 = double.parse(Total_assets3)/100000000;
    Total_assets2 = list1[0]['frmtrm_amount'];
    d_Total_assets2 = double.parse(Total_assets2)/100000000;
    Total_assets1 = list1[0]['thstrm_amount'];
    d_Total_assets1 = double.parse(Total_assets1)/100000000;

    String url2 = "http://kmuproject.kro.kr:5568/sql/${tangible_assets}";
    String Changed_String2 = url2.replaceAll(' ', '!');
    var response2 = await https.get(Uri.parse(Changed_String2));

    var statusCode2 = response2.statusCode;
    var responseHeaders2 = response2.headers;
    var responseBody2 = response2.body;

    List list2= jsonDecode(responseBody2);

/*    print("statusCode: ${statusCode2}");
    print("responseHeaders: ${responseHeaders2}");
    print("responseBody: ${responseBody2}");*/

/*    print(list2[0]['bfefrmtrm_amount']);
    print(list2[0]['frmtrm_amount']);
    print(list2[0]['thstrm_amount']);*/

    tangible_assets3 = list2[0]['bfefrmtrm_amount'];
    d_tangible_assets3 = double.parse(tangible_assets3)/100000000;
    tangible_assets2 = list2[0]['frmtrm_amount'];
    d_tangible_assets2 = double.parse(tangible_assets2)/100000000;
    tangible_assets1 = list2[0]['thstrm_amount'];
    d_tangible_assets1 = double.parse(tangible_assets1)/100000000;

    String url3 = "http://kmuproject.kro.kr:5568/sql/${intangible_assets}";
    String Changed_String3 = url3.replaceAll(' ', '!');
    var response3 = await https.get(Uri.parse(Changed_String3));

    var statusCode3 = response3.statusCode;
    var responseHeaders3 = response3.headers;
    var responseBody3 = response3.body;

    List list3 = jsonDecode(responseBody3);

/*    print("statusCode: ${statusCode3}");
    print("responseHeaders: ${responseHeaders3}");
    print("responseBody: ${responseBody3}");*/

/*    print(list3[0]['bfefrmtrm_amount']);
    print(list3[0]['frmtrm_amount']);
    print(list3[0]['thstrm_amount']);*/

    intangible_assets3 = list3[0]['bfefrmtrm_amount'];
    d_intangible_assets3 = double.parse(intangible_assets3)/100000000;
    intangible_assets2 = list3[0]['frmtrm_amount'];
    d_intangible_assets2 = double.parse(intangible_assets2)/100000000;
    intangible_assets1 = list3[0]['thstrm_amount'];
    d_intangible_assets1 = double.parse(intangible_assets1)/100000000;

    String url4 = "http://kmuproject.kro.kr:5568/sql/${cash_equivalents}";
    String Changed_String4 = url4.replaceAll(' ', '!');
    var response4 = await https.get(Uri.parse(Changed_String4));

    var statusCode4 = response4.statusCode;
    var responseHeaders4 = response4.headers;
    var responseBody4 = response4.body;

    List list4 = jsonDecode(responseBody4);

/*
    print("statusCode: ${statusCode4}");
    print("responseHeaders: ${responseHeaders4}");
    print("responseBody: ${responseBody4}");
*/

/*    print(list4[0]['bfefrmtrm_amount']);
    print(list4[0]['frmtrm_amount']);
    print(list4[0]['thstrm_amount']);*/

    cash_equivalents3 = list4[0]['bfefrmtrm_amount'];
    d_cash_equivalents3 = double.parse(cash_equivalents3)/100000000;
    cash_equivalents2 = list4[0]['frmtrm_amount'];
    d_cash_equivalents2 = double.parse(cash_equivalents2)/100000000;
    cash_equivalents1 = list4[0]['thstrm_amount'];
    d_cash_equivalents1 = double.parse(cash_equivalents1)/100000000;

    String url5 = "http://kmuproject.kro.kr:5568/sql/${total_capital}";
    String Changed_String5 = url5.replaceAll(' ', '!');
    var response5 = await https.get(Uri.parse(Changed_String5));

    var statusCode5 = response5.statusCode;
    var responseHeaders5 = response5.headers;
    var responseBody5 = response5.body;

    List list5 = jsonDecode(responseBody5);

/*    print("statusCode: ${statusCode5}");
    print("responseHeaders: ${responseHeaders5}");
    print("responseBody: ${responseBody5}");*/

/*    print(list5[0]['bfefrmtrm_amount']);
    print(list5[0]['frmtrm_amount']);
    print(list5[0]['thstrm_amount']);*/

    total_capital3 = list5[0]['bfefrmtrm_amount'];
    d_total_capital3 = double.parse(total_capital3)/100000000;
    total_capital2 = list5[0]['frmtrm_amount'];
    d_total_capital2 = double.parse(total_capital2)/100000000;
    total_capital1 = list5[0]['thstrm_amount'];
    d_total_capital1 = double.parse(total_capital1)/100000000;

    String url6 = "http://kmuproject.kro.kr:5568/sql/${Total_Debt}";
    String Changed_String6 = url6.replaceAll(' ', '!');
    var response6 = await https.get(Uri.parse(Changed_String6));

    var statusCode6 = response6.statusCode;
    var responseHeaders6 = response6.headers;
    var responseBody6 = response6.body;

    List list6 = jsonDecode(responseBody6);

 /*   print("statusCode: ${statusCode6}");
    print("responseHeaders: ${responseHeaders6}");
    print("responseBody: ${responseBody6}");*/

/*    print(list6[0]['bfefrmtrm_amount']);
    print(list6[0]['frmtrm_amount']);
    print(list6[0]['thstrm_amount']);*/

    Total_Debt3 = list6[0]['bfefrmtrm_amount'];
    d_Total_Debt3 = double.parse(Total_Debt3)/100000000;
    Total_Debt2 = list6[0]['frmtrm_amount'];
    d_Total_Debt2 = double.parse(Total_Debt2)/100000000;
    Total_Debt1 = list6[0]['thstrm_amount'];
    d_Total_Debt1 = double.parse(Total_Debt1)/100000000;
  }
  //-------------------------재무상태표

  //-------------------------현금흐름표
  String CFO1=''; //영업활동흐름표
  String CFO2='';
  String CFO3='';
  double d_CFO1=0; //영업활동흐름표
  double d_CFO2=0;
  double d_CFO3=0;

  String IACF1=''; //투자활동흐름표
  String IACF2='';
  String IACF3='';
  double d_IACF1=0; //투자활동흐름표
  double d_IACF2=0;
  double d_IACF3=0;

  String FACF1=''; //재무활동흐름표
  String FACF2='';
  String FACF3='';
  double d_FACF1=0; //재무활동흐름표
  double d_FACF2=0;
  double d_FACF3=0;

  void Find_cash_flow_statemente(String CFO, String IACF, String FACF) async
  {
    String url1 = "http://kmuproject.kro.kr:5568/sql/${CFO}";
    String Changed_String1 = url1.replaceAll(' ', '!');
    var response1 = await https.get(Uri.parse(Changed_String1));

    var statusCode1 = response1.statusCode;
    var responseHeaders1 = response1.headers;
    var responseBody1 = response1.body;

    List list1 = jsonDecode(responseBody1);

/*    print("statusCode: ${statusCode1}");
    print("responseHeaders: ${responseHeaders1}");
    print("responseBody: ${responseBody1}");*/

/*    print(list1[0]['bfefrmtrm_amount']);
    print(list1[0]['frmtrm_amount']);
    print(list1[0]['thstrm_amount']);*/

    CFO3 = list1[0]['bfefrmtrm_amount'];
    d_CFO3 = double.parse(CFO3)/1000000;
    CFO2 = list1[0]['frmtrm_amount'];
    d_CFO2 = double.parse(CFO2)/1000000;
    CFO1 = list1[0]['thstrm_amount'];
    d_CFO1 = double.parse(CFO1)/1000000;

    String url2 = "http://kmuproject.kro.kr:5568/sql/${IACF}";
    String Changed_String2 = url2.replaceAll(' ', '!');
    var response2 = await https.get(Uri.parse(Changed_String2));

    var statusCode2 = response2.statusCode;
    var responseHeaders2 = response2.headers;
    var responseBody2 = response2.body;

    List list2= jsonDecode(responseBody2);

/*    print("statusCode: ${statusCode2}");
    print("responseHeaders: ${responseHeaders2}");
    print("responseBody: ${responseBody2}");*/

/*    print(list2[0]['bfefrmtrm_amount']);
    print(list2[0]['frmtrm_amount']);
    print(list2[0]['thstrm_amount']);*/

    IACF3 = list2[0]['bfefrmtrm_amount'];
    d_IACF3 = double.parse(IACF3)/100000000;
    IACF2 = list2[0]['frmtrm_amount'];
    d_IACF2 = double.parse(IACF2)/100000000;
    IACF1 = list2[0]['thstrm_amount'];
    d_IACF1 = double.parse(IACF1)/100000000;

    String url3 = "http://kmuproject.kro.kr:5568/sql/${FACF}";
    String Changed_String3 = url3.replaceAll(' ', '!');
    var response3 = await https.get(Uri.parse(Changed_String3));

    var statusCode3 = response3.statusCode;
    var responseHeaders3 = response3.headers;
    var responseBody3 = response3.body;

    List list3 = jsonDecode(responseBody3);

/*    print("statusCode: ${statusCode3}");
    print("responseHeaders: ${responseHeaders3}");
    print("responseBody: ${responseBody3}");*/

/*    print(list3[0]['bfefrmtrm_amount']);
    print(list3[0]['frmtrm_amount']);
    print(list3[0]['thstrm_amount']);*/

    FACF3 = list3[0]['bfefrmtrm_amount'];
    d_FACF3 = double.parse(FACF3)/100000000;
    FACF2 = list3[0]['frmtrm_amount'];
    d_FACF2 = double.parse(FACF2)/100000000;
    FACF1 = list3[0]['thstrm_amount'];
    d_FACF1 = double.parse(FACF1)/100000000;

  }
  //-------------------------현금흐름표


/*  void connect(String StockCode) async
  {
    print(StockCode);
    String url1 = "http://kmuproject.kro.kr:5568/sql/${"SELECT * FROM stock.dartcode where stockcode = "+StockCode+";"}";
    String Changed_String1 = url1.replaceAll(' ', '!');
    var response1 = await http.get(Changed_String1);

    var statusCode1 = response1.statusCode;
    var responseHeaders1 = response1.headers;
    var responseBody1 = response1.body;

    List list1 = jsonDecode(responseBody1);

    //print("statusCode: ${statusCode1}");
    //print("responseHeaders: ${responseHeaders1}");
    print("responseBody: ${responseBody1}");

    dartCode = list1[0]['dartcode'].toString();

    const String _url = "https://opendart.fss.or.kr/api/list.json";
    const String _apiKey = "e50aac2aaa0bc5e55d91105ac6b5219b4992f32d";
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('yyyyMMdd');
    String strToday = formatter.format(now);
    //String strYesterday = formatter.format(Yester);
    final String _endPoint = "$_url?crtfc_key=$_apiKey&corp_code="+dartCode+"&bgn_de=20220101&end_de="+strToday+"";
    final http.Response _res = await http.get(_endPoint);
    var responseBody12 = _res.body;

    //print("responseBody: ${responseBody12}");

    final Map<String, dynamic> _result = json.decode(_res.body);

    rcept_no = _result['list'][0]["rcept_no"].toString();
    print(_result['list'][0]);
    print(dartCode);
    print(rcept_no);
  }*/
}