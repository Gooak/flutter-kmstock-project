/*
import 'dart:async';
import 'dart:convert';
//import 'dart:html';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:project2/src/page/Financial/query.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'financial.dart';
import 'financial_chart.dart';
import 'package:http/http.dart' as https;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

import 'opendart/opendart.dart';


class ChartData {
  ChartData({
    this.empty,
    this.data,
     this.purple,
     this.fluffy,
     this.tentacled,
     this.sticky,
  });

   int? empty;
   int? data;
   DateTime? purple;
   int? fluffy;
   int? tentacled;
   int? sticky;

  factory ChartData.fromRawJson(String str) => ChartData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ChartData.fromJson(Map<String, dynamic> json) => ChartData(
    empty: json["거래량"],
    data: json["고가"].toInt(),
    purple: DateTime.parse(json["날짜"]),
    fluffy: json["시가"].toInt(),
    tentacled: json["저가"].toInt(),
    sticky: json["종가"].toInt(),
  );

  Map<String, dynamic> toJson() => {
    "거래량": empty!,
    "고가": data!,
    "날짜": "${purple!.year.toString().padLeft(4, '0')}-${purple!.month.toString().padLeft(2, '0')}-${purple!.day.toString().padLeft(2, '0')}",
    "시가": fluffy!,
    "저가": tentacled!,
    "종가": sticky!,
  };
}

*/
/*class ChartData1 {
  ChartData1({
    this.empty,
    this.data,
    this.purple,
    this.fluffy,
    this.tentacled,
    this.sticky,
  });

  int? empty;
  int? data;
  DateTime? purple;
  int? fluffy;
  int? tentacled;
  int? sticky;

  factory ChartData1.fromRawJson(String str) => ChartData1.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ChartData1.fromJson(Map<String, dynamic> json) => ChartData1(
    empty: json["거래량"],
    data: json["고가"].toInt(),
    purple: DateTime.parse(json["날짜"]),
    fluffy: json["시가"].toInt(),
    tentacled: json["저가"].toInt(),
    sticky: json["종가"].toInt(),
  );

  Map<String, dynamic> toJson() => {
    "거래량": empty!,
    "고가": data!,
    "날짜": "${purple!.year.toString().padLeft(4, '0')}-${purple!.month.toString().padLeft(2, '0')}-${purple!.day.toString().padLeft(2, '0')}",
    "시가": fluffy!,
    "저가": tentacled!,
    "종가": sticky!,
  };
}*//*



String stockCode = '';

class Fin extends StatefulWidget {
  @override
  Fin_Main createState() => Fin_Main();
}

class Fin_Main extends State<Fin> {
  Query query = Query();
  Timer? _timer;
   List<ChartData> _Chartdata=[];
  //List<ChartData1> _Chartdata1=[];
  late TrackballBehavior _trackballBehavior;

  Future<void> Find_dataTime(String data) async
  {
    String url1 = "http://kmuproject.kro.kr:5568/sql/${data}";
    String Changed_String1 = url1.replaceAll(' ', '!');
    var response1 = await https.get(Changed_String1);

    var statusCode1 = response1.statusCode;
    var responseHeaders1 = response1.headers;
    //var responseBody1 = response1.body;
    var responseBody1 = jsonDecode(response1.body);
    print("statusCode: ${statusCode1}");
    print("responseHeaders: ${responseHeaders1}");
    //print("responseBody: ${responseBody1}");
    _Chartdata= List<ChartData>.from(responseBody1.map((x)=>ChartData.fromJson(x)));
    //_Chartdata.removeRange(400, 5300);
    print(_Chartdata.length);
  }
*/
/*  Future<void> Find_dataTime1(String data) async
  {
    String url1 = "http://kmuproject.kro.kr:5568/sql/${data}";
    String Changed_String1 = url1.replaceAll(' ', '!');
    var response1 = await https.get(Changed_String1);

    var statusCode1 = response1.statusCode;
    var responseHeaders1 = response1.headers;
    //var responseBody1 = response1.body;
    var responseBody1 = jsonDecode(response1.body);
    print("statusCode: ${statusCode1}");
    print("responseHeaders: ${responseHeaders1}");
    //print("responseBody: ${responseBody1}");
    _Chartdata1= List<ChartData1>.from(responseBody1.map((x)=>ChartData1.fromJson(x)));
    //_Chartdata.removeRange(400, 5300);
    print(_Chartdata1.length);
  }*//*


  @override
    void initState()   {
    super.initState();
    EasyLoading.show(
      status: 'loading...',
      maskType: EasyLoadingMaskType.black,
    );
    _trackballBehavior = TrackballBehavior(enable: true, activationMode:  ActivationMode.singleTap);
    Financial fb = Financial();
    searchText = fb.name;
    Future<String> Stock_Code;
    Stock_Code = query.Find_Stock_Code(searchText);
*/
/*    _tooltipBehaviorip = TooltipBehavior(enable: true);
    _zoomPanBehavior = ZoomPanBehavior(enablePinching: true);*//*

    if(fb.name == ""){
      searchText = Get.arguments;
    }
     Stock_Code.then((val) async {
      // 종목코드가 나오면 해당 값을 출력
      print('val: $val');
      stockCode = val;
      //String find ="SELECT COUNT(*) AS count FROM information_schema.tables WHERE TABLE_SCHEMA = 'c_finance' AND TABLE_NAME = 'fs${val}'";
      String find_date="SELECT * FROM finance_timedata.history_${val} WHERE 날짜 BETWEEN '2017-11-01' AND 'NOW()';";
      String find_date1="SELECT * FROM finance_timedata.history_000020 WHERE 날짜 BETWEEN '2017-11-01' AND 'NOW()';";
      await(Find_dataTime(find_date));
      //await(Find_dataTime1(find_date1));
      print(_Chartdata.length);
//      query.Find_finace(find);
*/
/*      if(query.find == 1)
      {*//*

      String sales = "SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM c__financialstatements.fs${val} Where account_id = 'ifrs-full_Revenue' And (sj_div = 'IS' or sj_div = 'CIS');";
      String selling = "SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM c__financialstatements.fs${val} Where account_id = 'dart_TotalSellingGeneralAdministrativeExpenses' And (sj_div = 'IS' or sj_div = 'CIS');";
      String EBIT = "SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM c__financialstatements.fs${val} Where account_id = 'dart_OperatingIncomeLoss' And (sj_div = 'IS' or sj_div = 'CIS');";
      String net_income = "SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM c__financialstatements.fs${val} Where account_id = 'ifrs-full_ProfitLoss' And (sj_div = 'IS' or sj_div = 'CIS');";
        query.Find_state_of_comprehensive_income(sales,selling,EBIT,net_income);

      String Total_assets="SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM c__financialstatements.fs${val} Where account_id = 'ifrs-full_Assets' And sj_div = 'BS';";
      String tangible_assets="SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM c__financialstatements.fs${val} Where account_id = 'ifrs-full_PropertyPlantAndEquipment' And sj_div = 'BS';";
        String intangible_assets="SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM c__financialstatements.fs${val} Where account_id = 'ifrs-full_IntangibleAssetsOtherThanGoodwill' And sj_div = 'BS';";
        String cash_equivalents="SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM c__financialstatements.fs${val} Where account_id = 'ifrs-full_CashAndCashEquivalents' And sj_div = 'BS';";
        String total_capital="SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM c__financialstatements.fs${val} Where account_id = 'ifrs-full_Equity' And sj_div = 'BS';";
        String Total_Debt="SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM c__financialstatements.fs${val} Where account_id = 'ifrs-full_Liabilities' And sj_div = 'BS';";
        query.Find_statement_of_financial_position(Total_assets,tangible_assets,intangible_assets,cash_equivalents,total_capital,Total_Debt);

        String CFO="SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM c__financialstatements.fs${val} Where account_id = 'ifrs-full_CashFlowsFromUsedInOperatingActivities' And sj_div = 'CF';";
        String IACF="SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM c__financialstatements.fs${val} Where account_id = 'ifrs-full_CashFlowsFromUsedInInvestingActivities' And sj_div = 'CF';";
        String FACF="SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM c__financialstatements.fs${val} Where account_id = 'ifrs-full_CashFlowsFromUsedInFinancingActivities' And sj_div = 'CF';";
        query.Find_cash_flow_statemente(CFO,IACF,FACF);
*/
/*      }
      else if(query.find == 0)
        {
          String sales = "SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM o_finance.fs${val} Where account_id = 'ifrs-full_Revenue' And sj_div = 'CIS';";
          String selling = "SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM o_finance.fs${val} Where account_id = 'dart_TotalSellingGeneralAdministrativeExpenses' And sj_div = 'CIS';";
          String EBIT = "SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM o_finance.fs${val} Where account_id = 'dart_OperatingIncomeLoss' And sj_div = 'CIS';";
          String net_income = "SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM o_finance.fs${val} Where account_id = 'ifrs-full_ProfitLoss' And sj_div = 'CIS' ;";
          query.Find_state_of_comprehensive_income(sales,selling,EBIT,net_income);

          String Total_assets="SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM o_finance.fs${val} Where account_id = 'ifrs-full_PropertyPlantAndEquipment' And sj_div = 'BS';";
          String tangible_assets="SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM o_finance.fs${val} Where account_id = 'ifrs-full_Assets' And sj_div = 'BS';";
          String intangible_assets="SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM o_finance.fs${val} Where account_id = 'ifrs-full_IntangibleAssetsOtherThanGoodwill' And sj_div = 'BS';";
          String cash_equivalents="SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM o_finance.fs${val} Where account_id = 'ifrs-full_CashAndCashEquivalents' And sj_div = 'BS';";
          String total_capital="SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM o_finance.fs${val} Where account_id = 'ifrs-full_Equity' And sj_div = 'BS';";
          String Total_Debt="SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM o_finance.fs${val} Where account_id = 'ifrs-full_Liabilities' And sj_div = 'BS';";
          query.Find_statement_of_financial_position(Total_assets,tangible_assets,intangible_assets,cash_equivalents,total_capital,Total_Debt);

          String CFO="SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM o_finance.fs${val} Where account_id = 'ifrs-full_CashFlowsFromUsedInOperatingActivities' And sj_div = 'CF';";
          String IACF="SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM o_finance.fs${val} Where account_id = 'ifrs-full_CashFlowsFromUsedInInvestingActivities' And sj_div = 'CF';";
          String FACF="SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM o_finance.fs${val} Where account_id = 'ifrs-full_CashFlowsFromUsedInFinancingActivities' And sj_div = 'CF';";
          query.Find_cash_flow_statemente(CFO,IACF,FACF);
        }*//*

    }).catchError((error) {
      // error가 해당 에러를 출력
      print('error: $error');
    });
    Future.delayed(Duration(seconds:2), () {
      print(_Chartdata.length);
      setState(() {
        super.setState(() {
          EasyLoading.showSuccess('Success');
        });
      });
    });
  }
*/
/*  void _showDialog1() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("자세히보기"),
          content: SingleChildScrollView(child: new Text("잘못 입력하셨습니다."),),
          actions: <Widget>[
            new FlatButton(
              child: new Text("닫기"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }*//*


  final TextEditingController _controller = TextEditingController();
  FocusNode focusNode = FocusNode();

  String searchText = Get.arguments;
  String Search_Stock_Code = '';

  Widget _Search(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), //모서리를 둥글게
          border: Border.all(color: Colors.black12, width: 3)), //테두리
      margin: EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 36,
            child: Text("단위 : 억원"),
          ),
          SizedBox(width: 10,),
          ElevatedButton(
            onPressed: () {
              setState(() {
                EasyLoading.show(
                  status: 'loading...',
                  maskType: EasyLoadingMaskType.black,
                );
                Future<String> Stock_Code;
                Stock_Code = query.Find_Stock_Code(searchText);
                Stock_Code.then((val) {
                  // 종목코드가 나오면 해당 값을 출력
                  print('val: $val');
                  String sales = "SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM c__financialstatements.fs${val} Where account_id = 'ifrs-full_Revenue' And (sj_div = 'IS' or sj_div = 'CIS');";
                  String selling = "SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM c__financialstatements.fs${val} Where account_id = 'dart_TotalSellingGeneralAdministrativeExpenses' And (sj_div = 'IS' or sj_div = 'CIS');";
                  String EBIT = "SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM c__financialstatements.fs${val} Where account_id = 'dart_OperatingIncomeLoss' And (sj_div = 'IS' or sj_div = 'CIS');";
                  String net_income = "SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM c__financialstatements.fs${val} Where account_id = 'ifrs-full_ProfitLoss' And (sj_div = 'IS' or sj_div = 'CIS');";
                  query.Find_state_of_comprehensive_income(sales,selling,EBIT,net_income);

                  String Total_assets="SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM c__financialstatements.fs${val} Where account_id = 'ifrs-full_Assets' And sj_div = 'BS';";
                  String tangible_assets="SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM c__financialstatements.fs${val} Where account_id = 'ifrs-full_PropertyPlantAndEquipment' And sj_div = 'BS';";
                  String intangible_assets="SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM c__financialstatements.fs${val} Where account_id = 'ifrs-full_IntangibleAssetsOtherThanGoodwill' And sj_div = 'BS';";
                  String cash_equivalents="SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM c__financialstatements.fs${val} Where account_id = 'ifrs-full_CashAndCashEquivalents' And sj_div = 'BS';";
                  String total_capital="SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM c__financialstatements.fs${val} Where account_id = 'ifrs-full_Equity' And sj_div = 'BS';";
                  String Total_Debt="SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM c__financialstatements.fs${val} Where account_id = 'ifrs-full_Liabilities' And sj_div = 'BS';";
                  query.Find_statement_of_financial_position(Total_assets,tangible_assets,intangible_assets,cash_equivalents,total_capital,Total_Debt);

                  String CFO="SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM c__financialstatements.fs${val} Where account_id = 'ifrs-full_CashFlowsFromUsedInOperatingActivities' And sj_div = 'CF';";
                  String IACF="SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM c__financialstatements.fs${val} Where account_id = 'ifrs-full_CashFlowsFromUsedInInvestingActivities' And sj_div = 'CF';";
                  String FACF="SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM c__financialstatements.fs${val} Where account_id = 'ifrs-full_CashFlowsFromUsedInFinancingActivities' And sj_div = 'CF';";
                  query.Find_cash_flow_statemente(CFO,IACF,FACF);
                }).catchError((error) {
                  // error가 해당 에러를 출력
                  print('error: $error');
                });
              });
              Future.delayed(Duration(seconds: 3), () {
                setState(() {
                  super.setState(() {
                    EasyLoading.showSuccess('Success');
                  });
                });
              });
            },
            child: Text("연결 재무제표 검색", style: TextStyle(color: Colors.white),),
          ),
          SizedBox(width: 10,),
          ElevatedButton(
            onPressed: () {
              setState(() {
                EasyLoading.show(
                  status: 'loading...',
                  maskType: EasyLoadingMaskType.black,
                );
                Future<String> Stock_Code;
                Stock_Code = query.Find_Stock_Code(searchText);
                Stock_Code.then((val) {
                  // 종목코드가 나오면 해당 값을 출력
                  print('val: $val');
                  String sales = "SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM o__financialstatements.fs${val} Where account_id = 'ifrs-full_Revenue' And sj_div = 'CIS';";
                  String selling = "SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM o__financialstatements.fs${val} Where account_id = 'dart_TotalSellingGeneralAdministrativeExpenses' And sj_div = 'CIS';";
                  String EBIT = "SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM o__financialstatements.fs${val} Where account_id = 'dart_OperatingIncomeLoss' And sj_div = 'CIS';";
                  String net_income = "SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM o__financialstatements.fs${val} Where account_id = 'ifrs-full_ProfitLoss' And sj_div = 'CIS' ;";
                  query.Find_state_of_comprehensive_income(sales,selling,EBIT,net_income);

                  String Total_assets="SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM o__financialstatements.fs${val} Where account_id = 'ifrs-full_Assets' And sj_div = 'BS';";
                  String tangible_assets="SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM o__financialstatements.fs${val} Where account_id = 'ifrs-full_PropertyPlantAndEquipment' And sj_div = 'BS';";
                  String intangible_assets="SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM o__financialstatements.fs${val} Where (account_id = 'ifrs-full_IntangibleAssetsOtherThanGoodwill' or account_nm LIKE "+'"%'+"무형자산"+'%"'+") And sj_div = 'BS';";
                  String cash_equivalents="SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM o__financialstatements.fs${val} Where account_id = 'ifrs-full_CashAndCashEquivalents' And sj_div = 'BS';";
                  String total_capital="SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM o__financialstatements.fs${val} Where account_id = 'ifrs-full_Equity' And sj_div = 'BS';";
                  String Total_Debt="SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM o__financialstatements.fs${val} Where account_id = 'ifrs-full_Liabilities' And sj_div = 'BS';";
                  query.Find_statement_of_financial_position(Total_assets,tangible_assets,intangible_assets,cash_equivalents,total_capital,Total_Debt);

                  String CFO="SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM o__financialstatements.fs${val} Where account_id = 'ifrs-full_CashFlowsFromUsedInOperatingActivities' And sj_div = 'CF';";
                  String IACF="SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM o__financialstatements.fs${val} Where account_id = 'ifrs-full_CashFlowsFromUsedInInvestingActivities' And sj_div = 'CF';";
                  String FACF="SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM o__financialstatements.fs${val} Where account_id = 'ifrs-full_CashFlowsFromUsedInFinancingActivities' And sj_div = 'CF';";
                  query.Find_cash_flow_statemente(CFO,IACF,FACF);
                }).catchError((error) {
                  // error가 해당 에러를 출력
                  print('error: $error');
                });
              });
              Future.delayed(Duration(seconds: 3), () {
                setState(() {
                  super.setState(() {
                    EasyLoading.showSuccess('Success');
                  });
                });
              });
            },
            child: Text("별도 재무제표 검색", style: TextStyle(color: Colors.white),),
          ),
          SizedBox(width: 3,),
        ],
      ),
    );
  }

  Widget _Search_Stock() {
    print(_Chartdata.length);
    setState(() {
    });
    return Stack(
      children: [Container(
        margin: EdgeInsets.all(5),
          width: double.infinity,
          height: 300,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), //모서리를 둥글게
            border: Border.all(color: Colors.black12, width: 3)), //테두리
          child: SfCartesianChart(
              enableAxisAnimation: true,
              trackballBehavior : _trackballBehavior,
              //title: ChartTitle(text: searchText),
              //legend: Legend(isVisible: true),
              series: <CartesianSeries>[
                CandleSeries<ChartData, DateTime>(
                    dataSource: _Chartdata,
                    xValueMapper: (ChartData data, _) => data.purple!,
                    highValueMapper: (ChartData data, _) => data.data!,
                    lowValueMapper: (ChartData data, _) => data.tentacled!,
                    openValueMapper: (ChartData data, _) => (data.fluffy!),
                    closeValueMapper: (ChartData data, _) => data.sticky!),
*/
/*                LineSeries<ChartData, DateTime>(
                    dataSource: _Chartdata,
                    xValueMapper: (ChartData data, _) => data.purple!,
                    highValueMapper: (ChartData data, _) => (data.data!*0.9),
                    lowValueMapper: (ChartData data, _) => (data.tentacled!*0.9),
                    openValueMapper: (ChartData data, _) => (data.fluffy!*0.9),
                    yValueMapper: (ChartData data, _) => (data.sticky!*0.9)),*//*

              ],
            primaryXAxis: DateTimeAxis(
                */
/*plotBands: [
                  PlotBand(
                    color: Colors.lightBlue,
                    text:('AI'),
                    textStyle: TextStyle(
                      color: Colors.white,
                    ),
                    textAngle: 0,
                    isVisible: true,
                    start:3,
                    end:5,
                    //start:DateTime(오늘날짜),
                    //end:DateTime(예측날짜),
                  )
                ]*//*

            ),
          ),
      ),*/
/*Container(
        margin: EdgeInsets.all(5),
        width: double.infinity,
        height: 300,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), //모서리를 둥글게
            border: Border.all(color: Colors.black12, width: 3)), //테두리
        child: SfCartesianChart(
          // Initialize category axis
            primaryXAxis: CategoryAxis(),

            series: <LineSeries<SalesData, String>>[
              LineSeries<SalesData, String>(
                // Bind data source
                  dataSource: <SalesData>[
                    SalesData('60분', 35),
                    SalesData('45분', 28),
                    SalesData('15분', 32),
                    SalesData('30분', 34),
                    SalesData('1분', 40)
                  ],
                  xValueMapper: (SalesData sales, _) => sales.year,
                  yValueMapper: (SalesData sales, _) => sales.sales
              )
            ]
        )
      ),*//*

      ]
    );
  }

  Widget _SOCI() {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), //모서리를 둥글게
          border: Border.all(color: Colors.black12, width: 3)), //테두리
      child: DataTable(
        horizontalMargin: 12.0,
        columnSpacing: 45.0,
        columns: <DataColumn>[
          DataColumn(
            label: Text(
              '손익계산서',style: TextStyle(fontSize: 12),
            ),
          ),
          DataColumn(
            label: Text(
              '2021/12',style: TextStyle(fontSize: 12),
            ),
          ),
          DataColumn(
            label: Text(
              '2020/12',style: TextStyle(fontSize: 12),
            ),
          ),
          DataColumn(
            label: Text(
              '2019/12',style: TextStyle(fontSize: 12),
            ),
          ),
        ],
        rows: <DataRow>[

          DataRow(
            cells: <DataCell>[
              DataCell(TextButton(onPressed: () {
                Get.to(() => Fin_Chart(), arguments: ['매출액', query.sales1, query.sales2, query.sales3]);
              },
                child:
                Text("매출액",style: TextStyle(fontSize: 12)),)),
              DataCell(Text(query.d_sales1.toStringAsFixed(0).toString(),style: TextStyle(fontSize: 12))),
              DataCell(Text(query.d_sales2.toStringAsFixed(0).toString(),style: TextStyle(fontSize: 12))),
              DataCell(Text(query.d_sales3.toStringAsFixed(0).toString(),style: TextStyle(fontSize: 12))),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(TextButton(onPressed: () {
                Get.to(() => Fin_Chart(), arguments: ['판매비와 관리비', query.selling1, query.selling2, query.selling3]);
              },
                child: Text("판매비와 관리비",style: TextStyle(fontSize: 12)),)),
              DataCell(Text(query.d_selling1.toStringAsFixed(0).toString(),style: TextStyle(fontSize: 12))),
              DataCell(Text(query.d_selling2.toStringAsFixed(0).toString(),style: TextStyle(fontSize: 12))),
              DataCell(Text(query.d_selling3.toStringAsFixed(0).toString(),style: TextStyle(fontSize: 12))),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(TextButton(onPressed: () {
                Get.to(() => Fin_Chart(), arguments: ['영업이익', query.EBIT1, query.EBIT2, query.EBIT3]);
              },
                child: Text("영업이익",style: TextStyle(fontSize: 12)),)),
              DataCell(Text(query.d_EBIT1.toStringAsFixed(0).toString(),style: TextStyle(fontSize: 12))),
              DataCell(Text(query.d_EBIT2.toStringAsFixed(0).toString(),style: TextStyle(fontSize: 12))),
              DataCell(Text(query.d_EBIT3.toStringAsFixed(0).toString(),style: TextStyle(fontSize: 12))),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(TextButton(onPressed: () {
                Get.to(() => Fin_Chart(), arguments: ['당기순이익', query.net_income1, query.net_income2, query.net_income3]);
              },
                child: Text("당기순이익",style: TextStyle(fontSize: 12)),)),
              DataCell(Text(query.d_net_income1.toStringAsFixed(0).toString(),style: TextStyle(fontSize: 12))),
              DataCell(Text(query.d_net_income2.toStringAsFixed(0).toString(),style: TextStyle(fontSize: 12))),
              DataCell(Text(query.d_net_income3.toStringAsFixed(0).toString(),style: TextStyle(fontSize: 12))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _B_Sheet() {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), //모서리를 둥글게
          border: Border.all(color: Colors.black12, width: 3)), //테두리
      child:
      DataTable(
        horizontalMargin: 12.0,
        columnSpacing: 45.0,
        columns: <DataColumn>[
          DataColumn(
            label: Text(
              '재무상태표',style: TextStyle(fontSize: 12),
            ),
          ),
          DataColumn(
            label: Text(
              '2021/12',style: TextStyle(fontSize: 12),
            ),
          ),
          DataColumn(
            label: Text(
              '2020/12',style: TextStyle(fontSize: 12),
            ),
          ),
          DataColumn(
            label: Text(
              '2019/12',style: TextStyle(fontSize: 12),
            ),
          ),
        ],
        rows: <DataRow>[
          DataRow(
            cells: <DataCell>[
              DataCell(TextButton(onPressed: () {
                Get.to(() => Fin_Chart(), arguments: ['자산총계', query.Total_assets1, query.Total_assets2, query.Total_assets3]);
              },
                child: Text("자산총계",style: TextStyle(fontSize: 12)),)),
              DataCell(Text(query.d_Total_assets1.toStringAsFixed(0).toString(),style: TextStyle(fontSize: 12))),
              DataCell(Text(query.d_Total_assets2.toStringAsFixed(0).toString(),style: TextStyle(fontSize: 12))),
              DataCell(Text(query.d_Total_assets3.toStringAsFixed(0).toString(),style: TextStyle(fontSize: 12))),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(TextButton(onPressed: () {
                Get.to(() => Fin_Chart(), arguments: ['유형자산', query.tangible_assets1, query.tangible_assets2, query.tangible_assets3]);
              },
                child: Text("유형자산",style: TextStyle(fontSize: 12)),)),
              DataCell(Text(query.d_tangible_assets1.toStringAsFixed(0).toString(),style: TextStyle(fontSize: 12))),
              DataCell(Text(query.d_tangible_assets2.toStringAsFixed(0).toString(),style: TextStyle(fontSize: 12))),
              DataCell(Text(query.d_tangible_assets3.toStringAsFixed(0).toString(),style: TextStyle(fontSize: 12))),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(TextButton(onPressed: () {
                Get.to(() => Fin_Chart(), arguments: ['무형자산', query.intangible_assets1, query.intangible_assets2, query.intangible_assets3]);
              },
                child: Text("무형자산",style: TextStyle(fontSize: 12)),)),
              DataCell(Text(query.d_intangible_assets1.toStringAsFixed(0).toString(),style: TextStyle(fontSize: 12))),
              DataCell(Text(query.d_intangible_assets2.toStringAsFixed(0).toString(),style: TextStyle(fontSize: 12))),
              DataCell(Text(query.d_intangible_assets3.toStringAsFixed(0).toString(),style: TextStyle(fontSize: 12))),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(TextButton(onPressed: () {
                Get.to(() => Fin_Chart(), arguments: ['현금및현금성자산', query.cash_equivalents1, query.cash_equivalents2, query.cash_equivalents3]);
              },
                child: Text("현금및현금성자산",style: TextStyle(fontSize: 12)),)),
              DataCell(Text(query.d_cash_equivalents1.toStringAsFixed(0).toString(),style: TextStyle(fontSize: 12))),
              DataCell(Text(query.d_cash_equivalents2.toStringAsFixed(0).toString(),style: TextStyle(fontSize: 12))),
              DataCell(Text(query.d_cash_equivalents3.toStringAsFixed(0).toString(),style: TextStyle(fontSize: 12))),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(TextButton(onPressed: () {
                Get.to(() => Fin_Chart(), arguments: ['자본총계', query.total_capital1, query.total_capital2, query.total_capital3]);
              },
                child: Text("자본총계",style: TextStyle(fontSize: 12)),)),
              DataCell(Text(query.d_total_capital1.toStringAsFixed(0).toString(),style: TextStyle(fontSize: 12))),
              DataCell(Text(query.d_total_capital2.toStringAsFixed(0).toString(),style: TextStyle(fontSize: 12))),
              DataCell(Text(query.d_total_capital3.toStringAsFixed(0).toString(),style: TextStyle(fontSize: 12))),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(TextButton(onPressed: () {
                Get.to(() => Fin_Chart(), arguments: ['부채총계', query.Total_Debt1, query.Total_Debt2, query.Total_Debt3]);
              },
                child: Text("부채총계"),)),
              DataCell(Text(query.d_Total_Debt1.toStringAsFixed(0).toString(),style: TextStyle(fontSize: 12))),
              DataCell(Text(query.d_Total_Debt2.toStringAsFixed(0).toString(),style: TextStyle(fontSize: 12))),
              DataCell(Text(query.d_Total_Debt3.toStringAsFixed(0).toString(),style: TextStyle(fontSize: 12))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _SCF() {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), //모서리를 둥글게
          border: Border.all(color: Colors.black12, width: 3)), //테두리
      child: DataTable(
        horizontalMargin: 12.0,
        columnSpacing: 43.0,
        columns: <DataColumn>[
          DataColumn(
            label: Text(
              '현금흐름표',style: TextStyle(fontSize: 12),
            ),
          ),
          DataColumn(
            label: Text(
              '2021/12',style: TextStyle(fontSize: 12),
            ),
          ),
          DataColumn(
            label: Text(
              '2020/12',style: TextStyle(fontSize: 12),
            ),
          ),
          DataColumn(
            label: Text(
              '2019/12',style: TextStyle(fontSize: 12),
            ),
          ),
        ],
        rows: <DataRow>[
          DataRow(
            cells: <DataCell>[
              DataCell(TextButton(onPressed: () {
                Get.to(() => Fin_Chart(), arguments: ['영업활동현금흐름', query.CFO1, query.CFO2, query.CFO3]);
              },
                child: Text("영업활동현금흐름",style: TextStyle(fontSize: 12)),)),
              DataCell(Text(query.d_CFO1.toStringAsFixed(0).toString(),style: TextStyle(fontSize: 12))),
              DataCell(Text(query.d_CFO2.toStringAsFixed(0).toString(),style: TextStyle(fontSize: 12))),
              DataCell(Text(query.d_CFO3.toStringAsFixed(0).toString(),style: TextStyle(fontSize: 12))),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(TextButton(onPressed: () {
                Get.to(() => Fin_Chart(), arguments: ['투자활동현금흐름', query.IACF1, query.IACF2, query.IACF3]);
              },
                child: Text("투자활동현금흐름",style: TextStyle(fontSize: 12)),)),
              DataCell(Text(query.d_IACF1.toStringAsFixed(0).toString(),style: TextStyle(fontSize: 12))),
              DataCell(Text(query.d_IACF2.toStringAsFixed(0).toString(),style: TextStyle(fontSize: 12))),
              DataCell(Text(query.d_IACF3.toStringAsFixed(0).toString(),style: TextStyle(fontSize: 12))),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(TextButton(onPressed: () {
                Get.to(() => Fin_Chart(), arguments: ['재무활동현금흐름', query.FACF1, query.FACF2, query.FACF3]);
              },
                child: Text("재무활동현금흐름",style: TextStyle(fontSize: 12)),)),
              DataCell(Text(query.d_FACF1.toStringAsFixed(0).toString(),style: TextStyle(fontSize: 12))),
              DataCell(Text(query.d_FACF2.toStringAsFixed(0).toString(),style: TextStyle(fontSize: 12))),
              DataCell(Text(query.d_FACF3.toStringAsFixed(0).toString(),style: TextStyle(fontSize: 12))),
            ],
          ),
        ],
      ),
    );
  }

*/
/*  @override
  Widget build(BuildContext context) {
    Future<String> Stock_Code;
    Stock_Code = Find_Stock_Code(searchText);
    Stock_Code.then((val) {
      // 종목코드가 나오면 해당 값을 출력
      print('val: $val');
      String query1 = "SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM c_finance.fs${val} Where account_nm = '수익(매출액)';";
      String query2 = "SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM c_finance.fs${val} Where account_nm = '판매비와관리비';";
      String query3 = "SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM c_finance.fs${val} Where account_nm = '영업이익(손실)';";
      String query4 = "SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM c_finance.fs${val} Where account_nm = '당기순이익(손실)' AND sj_div = 'CIS';";
      Find_Stock_Financial_Statement(query1, query2, query3, query4);
    }).catchError((error) {
      // error가 해당 에러를 출력
      print('error: $error');
    });
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Center(
              child: Text("재무제표"
              ),
            ),
*//*
*/
/*actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchMain()),
                  );
                },
              ),
            ],*//*
*/
/*
            floating: true,
            snap: true,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    child: Column(children: [
                      _Search(context),
                      _Search_Stock(),
                      _SOCI(context),
                      _B_Sheet(),
                      _SCF(),
                    ],),
                  ),
                );
              },
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }*//*

  Widget build(BuildContext context) {
*/
/*    Future<String> Stock_Code;
    Stock_Code = Find_Stock_Code(searchText);
    Stock_Code.then((val) {
      // 종목코드가 나오면 해당 값을 출력
      print('val: $val');
      String query1 = "SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM c_finance.fs${val} Where account_nm = '수익(매출액)';";
      String query2 = "SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM c_finance.fs${val} Where account_nm = '판매비와관리비';";
      String query3 = "SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM c_finance.fs${val} Where account_nm = '영업이익(손실)';";
      String query4 = "SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM c_finance.fs${val} Where account_nm = '당기순이익(손실)' AND sj_div = 'CIS';";
      Find_Stock_Financial_Statement(query1, query2, query3, query4);
    }).catchError((error) {
      // error가 해당 에러를 출력
      print('error: $error');
    });*//*

    return Container(
      child: Column(children: [
        _Search_Stock(),
        _Search(context),
        _SOCI(),
        _B_Sheet(),
        _SCF(),
      ],),
    );
  }
}*/
