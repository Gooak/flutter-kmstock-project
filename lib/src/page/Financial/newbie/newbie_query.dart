import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as https;


class NewBieQuery{
  String chart_up ="images/chart_up.jpg"; //매출액
  String chart_down ="images/chart_down.jpg";

  String sales1_chart = "images/refresh.jpg";
  String sales2_chart="images/refresh.jpg";
  String sales3_chart="images/refresh.jpg";

  String selling1_chart ="images/refresh.jpg"; //판매비와 관리비
  String selling2_chart ="images/refresh.jpg";
  String selling3_chart ="images/refresh.jpg";

  String EBIT1_chart ="images/refresh.jpg"; //영업이익
  String EBIT2_chart ="images/refresh.jpg";
  String EBIT3_chart ="images/refresh.jpg";

  String net_income1_chart="images/refresh.jpg"; //당기순이익
  String net_income2_chart="images/refresh.jpg";
  String net_income3_chart="images/refresh.jpg";

  ////////////////////////////////////////
  String Search_Stock_Code=''; //검색 코드

  String sales1=''; //매출액
  String sales2='';
  String sales3='';

  String selling1 =''; //판매비와 관리비
  String selling2 ='';
  String selling3 ='';

  String EBIT1 =''; //영업이익
  String EBIT2 ='';
  String EBIT3 ='';

  String net_income1=''; //당기순이익
  String net_income2='';
  String net_income3='';

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
    Search_Stock_Code = "SELECT 종목코드 FROM stock.db_20220327 WHERE 종목명 = '${Stock_Name}';";
    String url = "http://kmuproject.kro.kr:5568/sql/${Search_Stock_Code}";
    String Changed_String = url.replaceAll(' ', '!');
    var response = await https.get(Uri.parse(Changed_String));

    var statusCode = response.statusCode;
    var responseHeaders = response.headers;
    var responseBody = response.body;
    List<dynamic> list = jsonDecode(responseBody);

 print("statusCode: ${statusCode}");
    print("responseHeaders: ${responseHeaders}");
    print("responseBody: ${responseBody}");

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
    print("responseBody: ${responseBody1}");

    print(list1[0]['bfefrmtrm_amount']);
    print(list1[0]['frmtrm_amount']);
    print(list1[0]['thstrm_amount']);


    sales3 = list1[0]['bfefrmtrm_amount']; //18
    sales2 = list1[0]['frmtrm_amount']; //19
    sales1 = list1[0]['thstrm_amount']; //20
    if(int.parse(sales3) < int.parse(sales2))
    {
      sales1_chart = chart_up;
    }

    else
    {
      sales1_chart = chart_down;
    }

    if(int.parse(sales2) < int.parse(sales1))
    {
      sales2_chart = chart_up;
      sales3_chart = chart_up;
    }

    else
    {
      sales2_chart = chart_down;
      sales3_chart = chart_down;
    }
    String url2 = "http://kmuproject.kro.kr:5568/sql/${selling}";
    String Changed_String2 = url2.replaceAll(' ', '!');
    var response2 = await https.get(Uri.parse(Changed_String2));

    var statusCode2 = response2.statusCode;
    var responseHeaders2 = response2.headers;
    var responseBody2 = response2.body;

    List list2= jsonDecode(responseBody2);

    print("statusCode: ${statusCode2}");
    print("responseHeaders: ${responseHeaders2}");
    print("responseBody: ${responseBody2}");

    print(list2[0]['bfefrmtrm_amount']);
    print(list2[0]['frmtrm_amount']);
    print(list2[0]['thstrm_amount']);


    selling3 = list2[0]['bfefrmtrm_amount'];
    selling2 = list2[0]['frmtrm_amount'];
    selling1 = list2[0]['thstrm_amount'];

    if(int.parse(selling3) < int.parse(selling2))
    {
      selling1_chart = chart_up;
    }

    else
    {
      selling1_chart = chart_down;
    }

    if(int.parse(selling2) < int.parse(selling1))
    {
      selling2_chart = chart_up;
      selling3_chart = chart_up;
    }

    else
    {
      selling2_chart = chart_down;
      selling3_chart = chart_down;
    }

    String url3 = "http://kmuproject.kro.kr:5568/sql/${EBIT}";
    String Changed_String3 = url3.replaceAll(' ', '!');
    var response3 = await https.get(Uri.parse(Changed_String3));

    var statusCode3 = response3.statusCode;
    var responseHeaders3 = response3.headers;
    var responseBody3 = response3.body;

    List list3 = jsonDecode(responseBody3);

    print("statusCode: ${statusCode3}");
    print("responseHeaders: ${responseHeaders3}");
    print("responseBody: ${responseBody3}");

    print(list3[0]['bfefrmtrm_amount']);
    print(list3[0]['frmtrm_amount']);
    print(list3[0]['thstrm_amount']);


    EBIT3 = list3[0]['bfefrmtrm_amount'];
    EBIT2 = list3[0]['frmtrm_amount'];
    EBIT1 = list3[0]['thstrm_amount'];

    if(int.parse(EBIT3) < int.parse(EBIT2))
    {
      EBIT1_chart = chart_up;
    }

    else
    {
      EBIT1_chart = chart_down;
    }

    if(int.parse(EBIT2) < int.parse(EBIT1))
    {
      EBIT2_chart = chart_up;
      EBIT3_chart = chart_up;
    }

    else
    {
      EBIT2_chart = chart_down;
      EBIT3_chart = chart_down;
    }

    String url4 = "http://kmuproject.kro.kr:5568/sql/${net_income}";
    String Changed_String4 = url4.replaceAll(' ', '!');
    var response4 = await https.get(Uri.parse(Changed_String4));

    var statusCode4 = response4.statusCode;
    var responseHeaders4 = response4.headers;
    var responseBody4 = response4.body;

    List list4 = jsonDecode(responseBody4);

    print("statusCode: ${statusCode4}");
    print("responseHeaders: ${responseHeaders4}");
    print("responseBody: ${responseBody4}");

    print(list4[0]['bfefrmtrm_amount']);
    print(list4[0]['frmtrm_amount']);
    print(list4[0]['thstrm_amount']);


    net_income3 = list4[0]['bfefrmtrm_amount'];
    net_income2 = list4[0]['frmtrm_amount'];
    net_income1 = list4[0]['thstrm_amount'];

    if(int.parse(net_income3) < int.parse(net_income2))
    {
      net_income1_chart = chart_up;
    }

    else
    {
      net_income1_chart = chart_down;
    }

    if(int.parse(net_income2) < int.parse(net_income1))
    {
      net_income2_chart = chart_up;
      net_income3_chart = chart_up;
    }

    else
    {
      net_income2_chart = chart_down;
      net_income3_chart = chart_down;
    }
  }
  //---------------------------손익계산서

  //-------------------------재무상태표

  String Total_assets1_chart="images/refresh.jpg"; //자산총계
  String Total_assets2_chart="images/refresh.jpg";
  String Total_assets3_chart="images/refresh.jpg";

  String tangible_assets1_chart="images/refresh.jpg"; //유형자산
  String tangible_assets2_chart="images/refresh.jpg";
  String tangible_assets3_chart="images/refresh.jpg";

  String intangible_assets1_chart="images/refresh.jpg"; //무형자산
  String intangible_assets2_chart="images/refresh.jpg";
  String intangible_assets3_chart="images/refresh.jpg";

  String cash_equivalents1_chart="images/refresh.jpg"; //현금 및 현금성자산
  String cash_equivalents2_chart="images/refresh.jpg";
  String cash_equivalents3_chart="images/refresh.jpg";

  String total_capital1_chart="images/refresh.jpg"; //자본총계
  String total_capital2_chart="images/refresh.jpg";
  String total_capital3_chart="images/refresh.jpg";

  String Total_Debt1_chart="images/refresh.jpg"; //부채총계
  String Total_Debt2_chart="images/refresh.jpg";
  String Total_Debt3_chart="images/refresh.jpg";

  //////////////////////////////////

  String Total_assets1=''; //자산총계
  String Total_assets2='';
  String Total_assets3='';

  String tangible_assets1=''; //유형자산
  String tangible_assets2='';
  String tangible_assets3='';

  String intangible_assets1=''; //무형자산
  String intangible_assets2='';
  String intangible_assets3='';

  String cash_equivalents1=''; //현금 및 현금성자산
  String cash_equivalents2='';
  String cash_equivalents3='';

  String total_capital1=''; //자본총계
  String total_capital2='';
  String total_capital3='';

  String Total_Debt1=''; //부채총계
  String Total_Debt2='';
  String Total_Debt3='';

  void Find_statement_of_financial_position(String Total_assets, String tangible_assets, String intangible_assets, String cash_equivalents, String total_capital, String Total_Debt) async
  {
    String url1 = "http://kmuproject.kro.kr:5568/sql/${Total_assets}";
    String Changed_String1 = url1.replaceAll(' ', '!');
    var response1 = await https.get(Uri.parse(Changed_String1));

    var statusCode1 = response1.statusCode;
    var responseHeaders1 = response1.headers;
    var responseBody1 = response1.body;

    List list1 = jsonDecode(responseBody1);

    print("statusCode: ${statusCode1}");
    print("responseHeaders: ${responseHeaders1}");
    print("responseBody: ${responseBody1}");

    print(list1[0]['bfefrmtrm_amount']);
    print(list1[0]['frmtrm_amount']);
    print(list1[0]['thstrm_amount']);


    Total_assets3 = list1[0]['bfefrmtrm_amount'];
    Total_assets2 = list1[0]['frmtrm_amount'];
    Total_assets1 = list1[0]['thstrm_amount'];

    if(int.parse(Total_assets3) < int.parse(Total_assets2))
    {
      Total_assets1_chart = chart_up;
    }

    else
    {
      Total_assets1_chart = chart_down;
    }

    if(int.parse(Total_assets2) < int.parse(Total_assets1))
    {
      Total_assets2_chart = chart_up;
      Total_assets3_chart = chart_up;
    }

    else
    {
      Total_assets2_chart = chart_down;
      Total_assets3_chart = chart_down;
    }

    String url2 = "http://kmuproject.kro.kr:5568/sql/${tangible_assets}";
    String Changed_String2 = url2.replaceAll(' ', '!');
    var response2 = await https.get(Uri.parse(Changed_String2));

    var statusCode2 = response2.statusCode;
    var responseHeaders2 = response2.headers;
    var responseBody2 = response2.body;

    List list2= jsonDecode(responseBody2);

    print("statusCode: ${statusCode2}");
    print("responseHeaders: ${responseHeaders2}");
    print("responseBody: ${responseBody2}");

    print(list2[0]['bfefrmtrm_amount']);
    print(list2[0]['frmtrm_amount']);
    print(list2[0]['thstrm_amount']);


    tangible_assets3 = list2[0]['bfefrmtrm_amount'];
    tangible_assets2 = list2[0]['frmtrm_amount'];
    tangible_assets1 = list2[0]['thstrm_amount'];

    if(int.parse(tangible_assets3) < int.parse(tangible_assets2))
    {
      tangible_assets1_chart = chart_up;
    }

    else
    {
      tangible_assets1_chart = chart_down;
    }

    if(int.parse(tangible_assets2) < int.parse(tangible_assets1))
    {
      tangible_assets2_chart = chart_up;
      tangible_assets3_chart = chart_up;
    }

    else
    {
      tangible_assets2_chart = chart_down;
      tangible_assets3_chart = chart_down;
    }

    String url3 = "http://kmuproject.kro.kr:5568/sql/${intangible_assets}";
    String Changed_String3 = url3.replaceAll(' ', '!');
    var response3 = await https.get(Uri.parse(Changed_String3));

    var statusCode3 = response3.statusCode;
    var responseHeaders3 = response3.headers;
    var responseBody3 = response3.body;

    List list3 = jsonDecode(responseBody3);

    print("statusCode: ${statusCode3}");
    print("responseHeaders: ${responseHeaders3}");
    print("responseBody: ${responseBody3}");

    print(list3[0]['bfefrmtrm_amount']);
    print(list3[0]['frmtrm_amount']);
    print(list3[0]['thstrm_amount']);


    intangible_assets3 = list3[0]['bfefrmtrm_amount'];
    intangible_assets2 = list3[0]['frmtrm_amount'];
    intangible_assets1 = list3[0]['thstrm_amount'];

    if(int.parse(intangible_assets3) < int.parse(intangible_assets2))
    {
      intangible_assets1_chart = chart_up;
    }

    else
    {
      intangible_assets1_chart = chart_down;
    }

    if(int.parse(intangible_assets2) < int.parse(intangible_assets1))
    {
      intangible_assets2_chart = chart_up;
      intangible_assets3_chart = chart_up;
    }

    else
    {
      intangible_assets2_chart = chart_down;
      intangible_assets3_chart = chart_down;
    }

    String url4 = "http://kmuproject.kro.kr:5568/sql/${cash_equivalents}";
    String Changed_String4 = url4.replaceAll(' ', '!');
    var response4 = await https.get(Uri.parse(Changed_String4));

    var statusCode4 = response4.statusCode;
    var responseHeaders4 = response4.headers;
    var responseBody4 = response4.body;

    List list4 = jsonDecode(responseBody4);

    print("statusCode: ${statusCode4}");
    print("responseHeaders: ${responseHeaders4}");
    print("responseBody: ${responseBody4}");

    print(list4[0]['bfefrmtrm_amount']);
    print(list4[0]['frmtrm_amount']);
    print(list4[0]['thstrm_amount']);


    cash_equivalents3 = list4[0]['bfefrmtrm_amount'];
    cash_equivalents2 = list4[0]['frmtrm_amount'];
    cash_equivalents1 = list4[0]['thstrm_amount'];

    if(int.parse(cash_equivalents3) < int.parse(cash_equivalents2))
    {
      cash_equivalents1_chart = chart_up;
    }

    else
    {
      cash_equivalents1_chart = chart_down;
    }

    if(int.parse(cash_equivalents2) < int.parse(cash_equivalents1))
    {
      cash_equivalents2_chart = chart_up;
      cash_equivalents3_chart = chart_up;
    }

    else
    {
      cash_equivalents2_chart = chart_down;
      cash_equivalents3_chart = chart_down;
    }

    String url5 = "http://kmuproject.kro.kr:5568/sql/${total_capital}";
    String Changed_String5 = url5.replaceAll(' ', '!');
    var response5 = await https.get(Uri.parse(Changed_String5));

    var statusCode5 = response5.statusCode;
    var responseHeaders5 = response5.headers;
    var responseBody5 = response5.body;

    List list5 = jsonDecode(responseBody5);

    print("statusCode: ${statusCode5}");
    print("responseHeaders: ${responseHeaders5}");
    print("responseBody: ${responseBody5}");

    print(list5[0]['bfefrmtrm_amount']);
    print(list5[0]['frmtrm_amount']);
    print(list5[0]['thstrm_amount']);


    total_capital3 = list5[0]['bfefrmtrm_amount'];
    total_capital2 = list5[0]['frmtrm_amount'];
    total_capital1 = list5[0]['thstrm_amount'];

    if(int.parse(total_capital3) < int.parse(total_capital2))
    {
      total_capital1_chart = chart_up;
    }

    else
    {
      total_capital1_chart = chart_down;
    }

    if(int.parse(total_capital2) < int.parse(total_capital1))
    {
      total_capital2_chart = chart_up;
      total_capital3_chart = chart_up;
    }

    else
    {
      total_capital2_chart = chart_down;
      total_capital3_chart = chart_down;
    }

    String url6 = "http://kmuproject.kro.kr:5568/sql/${Total_Debt}";
    String Changed_String6 = url6.replaceAll(' ', '!');
    var response6 = await https.get(Uri.parse(Changed_String6));

    var statusCode6 = response6.statusCode;
    var responseHeaders6 = response6.headers;
    var responseBody6 = response6.body;

    List list6 = jsonDecode(responseBody6);

    print("statusCode: ${statusCode6}");
    print("responseHeaders: ${responseHeaders6}");
    print("responseBody: ${responseBody6}");

    print(list6[0]['bfefrmtrm_amount']);
    print(list6[0]['frmtrm_amount']);
    print(list6[0]['thstrm_amount']);


    Total_Debt3 = list6[0]['bfefrmtrm_amount'];
    Total_Debt2 = list6[0]['frmtrm_amount'];
    Total_Debt1 = list6[0]['thstrm_amount'];

    if(int.parse(Total_Debt3) < int.parse(Total_Debt2))
    {
      Total_Debt1_chart = chart_up;
    }

    else
    {
      Total_Debt1_chart = chart_down;
    }

    if(int.parse(Total_Debt2) < int.parse(Total_Debt1))
    {
      Total_Debt2_chart = chart_up;
      Total_Debt3_chart = chart_up;
    }

    else
    {
      Total_Debt2_chart = chart_down;
      Total_Debt3_chart = chart_down;
    }
  }
  //-------------------------재무상태표

  //-------------------------현금흐름표

  String CFO1_chart="images/refresh.jpg"; //영업활동흐름표
  String CFO2_chart="images/refresh.jpg";
  String CFO3_chart="images/refresh.jpg";

  String IACF1_chart="images/refresh.jpg"; //투자활동흐름표
  String IACF2_chart="images/refresh.jpg";
  String IACF3_chart="images/refresh.jpg";

  String FACF1_chart="images/refresh.jpg"; //재무활동흐름표
  String FACF2_chart="images/refresh.jpg";
  String FACF3_chart="images/refresh.jpg";

  //////////////////////////////////////

  String CFO1=''; //영업활동흐름표
  String CFO2='';
  String CFO3='';

  String IACF1=''; //투자활동흐름표
  String IACF2='';
  String IACF3='';

  String FACF1=''; //재무활동흐름표
  String FACF2='';
  String FACF3='';

  void Find_cash_flow_statemente(String CFO, String IACF, String FACF) async
  {
    String url1 = "http://kmuproject.kro.kr:5568/sql/${CFO}";
    String Changed_String1 = url1.replaceAll(' ', '!');
    var response1 = await https.get(Uri.parse(Changed_String1));

    var statusCode1 = response1.statusCode;
    var responseHeaders1 = response1.headers;
    var responseBody1 = response1.body;

    List list1 = jsonDecode(responseBody1);

    print("statusCode: ${statusCode1}");
    print("responseHeaders: ${responseHeaders1}");
    print("responseBody: ${responseBody1}");

    print(list1[0]['bfefrmtrm_amount']);
    print(list1[0]['frmtrm_amount']);
    print(list1[0]['thstrm_amount']);


    CFO3 = list1[0]['bfefrmtrm_amount'];
    CFO2 = list1[0]['frmtrm_amount'];
    CFO1 = list1[0]['thstrm_amount'];

    if(int.parse(CFO3) < int.parse(CFO2))
    {
      CFO1_chart = chart_up;
    }

    else
    {
      CFO1_chart = chart_down;
    }

    if(int.parse(CFO2) < int.parse(CFO1))
    {
      CFO2_chart = chart_up;
      CFO3_chart = chart_up;
    }

    else
    {
      CFO2_chart = chart_down;
      CFO3_chart = chart_down;
    }

    String url2 = "http://kmuproject.kro.kr:5568/sql/${IACF}";
    String Changed_String2 = url2.replaceAll(' ', '!');
    var response2 = await https.get(Uri.parse(Changed_String2));

    var statusCode2 = response2.statusCode;
    var responseHeaders2 = response2.headers;
    var responseBody2 = response2.body;

    List list2= jsonDecode(responseBody2);

    print("statusCode: ${statusCode2}");
    print("responseHeaders: ${responseHeaders2}");
    print("responseBody: ${responseBody2}");

    print(list2[0]['bfefrmtrm_amount']);
    print(list2[0]['frmtrm_amount']);
    print(list2[0]['thstrm_amount']);


    IACF3 = list2[0]['bfefrmtrm_amount'];
    IACF2 = list2[0]['frmtrm_amount'];
    IACF1 = list2[0]['thstrm_amount'];

    if(int.parse(IACF3) < int.parse(IACF2))
    {
      IACF1_chart = chart_up;
    }

    else
    {
      IACF1_chart = chart_down;
    }

    if(int.parse(IACF2) < int.parse(IACF1))
    {
      IACF2_chart = chart_up;
      IACF3_chart = chart_up;
    }

    else
    {
      IACF2_chart = chart_down;
      IACF3_chart = chart_down;
    }

    String url3 = "http://kmuproject.kro.kr:5568/sql/${FACF}";
    String Changed_String3 = url3.replaceAll(' ', '!');
    var response3 = await https.get(Uri.parse(Changed_String3));

    var statusCode3 = response3.statusCode;
    var responseHeaders3 = response3.headers;
    var responseBody3 = response3.body;

    List list3 = jsonDecode(responseBody3);

    print("statusCode: ${statusCode3}");
    print("responseHeaders: ${responseHeaders3}");
    print("responseBody: ${responseBody3}");

    print(list3[0]['bfefrmtrm_amount']);
    print(list3[0]['frmtrm_amount']);
    print(list3[0]['thstrm_amount']);


    FACF3 = list3[0]['bfefrmtrm_amount'];
    FACF2 = list3[0]['frmtrm_amount'];
    FACF1 = list3[0]['thstrm_amount'];

    if(int.parse(FACF3) < int.parse(FACF2))
    {
      FACF1_chart = chart_up;
    }

    else
    {
      FACF1_chart = chart_down;
    }

    if(int.parse(FACF2) < int.parse(FACF1))
    {
      FACF2_chart = chart_up;
      FACF3_chart = chart_up;
    }

    else
    {
      FACF2_chart = chart_down;
      FACF3_chart = chart_down;
    }
  }
//-------------------------현금흐름표
}
