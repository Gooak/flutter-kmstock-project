import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../financial.dart';
import '../financial_chart.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';


import 'dart:convert';
//import 'dart:html';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:untitled/src/page/Financial/query.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:http/http.dart' as https;
import 'package:meta/meta.dart';
import 'dart:convert';

import 'newbie_financial.dart';
import 'newbie_query.dart';
class PieData_2021 {
  PieData_2021(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}

class PieData_2020 {
  PieData_2020(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}

class PieData_2019 {
  PieData_2019(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}

class PieData_net_income {
  PieData_net_income(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}

class PieData_CFO {
  PieData_CFO(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}
class Newbie_Fin extends StatefulWidget {
  @override
  newbie_Fin_Main createState() => newbie_Fin_Main();
}

class newbie_Fin_Main extends State<Newbie_Fin> with AutomaticKeepAliveClientMixin{
  String searchText = '';
  String StockCode ='';
  String dartCode = '';
  fin_Query query = fin_Query();
  bool isLoading = false;

  void initState() {
    setState(() {
      isLoading = true;
    });
    // TODO: implement initState
    Future.microtask(() async{
      FinancialState fb = FinancialState();
      searchText = fb.name;
      Future<String> Stock_Code;
      //_result = await _connect();
      //dividend = await Dividend();
      //setState(() {});
      Stock_Code = query.Find_Stock_Code(searchText);
      await Stock_Code.then((val) async {
        String Total_Debt="SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM c__financialstatements.fs${val} Where account_id = 'ifrs-full_Liabilities' And sj_div = 'BS';";
        String total_capital="select thstrm_amount,frmtrm_amount,bfefrmtrm_amount from c__financialstatements.fs005930 where account_id = 'ifrs-full_Equity' and (sj_div ='BS' or account_detail =  '연결재무제표 [member]');";
        String net_income = "SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM c__financialstatements.fs${val} Where account_id = 'ifrs-full_ProfitLoss' And (sj_div = 'IS' or sj_div = 'CIS');";
        String CFO="SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM c__financialstatements.fs${val} Where account_id = 'ifrs-full_CashFlowsFromUsedInOperatingActivities' And sj_div = 'CF';";
        await Find_Pie_data(Total_Debt, total_capital,net_income, CFO);
        setState(() {});
      });
    }).catchError((error) {
      print('error: $error');
    });
    Future.delayed(Duration(seconds:2), () {
      setState(() {
        super.setState(() {
          isLoading = false;
        });
      });
    });
    super.initState();
  }
  double Total_Debt_thstrm_amount = 0;
  double Total_Debt_frmtrm_amount = 0;
  double Total_Debt_bfefrmtrm_amount = 0;

  double total_capital_thstrm_amount = 0;
  double total_capital_frmtrm_amount = 0;
  double total_capital_bfefrmtrm_amount = 0;

  Widget piechart_total_assets() {
    final List<PieData_2021> pieData_2021 = [
      PieData_2021('21/자본총계', double.parse(Total_Debt_thstrm_amount.toStringAsFixed(2)), Color.fromRGBO(051,153,255,1)),
      PieData_2021('21/부채총계', double.parse(total_capital_thstrm_amount.toStringAsFixed(2)), Color.fromRGBO(051,204,255,1)),
      //ChartData('Others', 52, Color.fromRGBO(255,189,57,1))
    ];
    final List<PieData_2020> pieData_2020 = [
      PieData_2020('20/자본총계', double.parse(Total_Debt_frmtrm_amount.toStringAsFixed(2)), Color.fromRGBO(051,153,255,1)),
      PieData_2020('20/부채총계', double.parse(total_capital_frmtrm_amount.toStringAsFixed(2)), Color.fromRGBO(051,204,255,1)),
      //ChartData('Others', 52, Color.fromRGBO(255,189,57,1))
    ];
    final List<PieData_2019> pieData_2019 = [
      PieData_2019('19/자본총계', double.parse(Total_Debt_bfefrmtrm_amount.toStringAsFixed(2)), Color.fromRGBO(051,153,255,1)),
      PieData_2019('19/부채총계', double.parse(total_capital_bfefrmtrm_amount.toStringAsFixed(2)), Color.fromRGBO(051,204,255,1)),
    ];
    return GestureDetector(
      onTap: (){
        _showDialog(Total_assets,Total_assets1_Detail);
      },
      child: Card(
        shape: RoundedRectangleBorder(  //모서리를 둥글게 하기 위해 사용
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Container(
          margin: EdgeInsets.all(5),
          width: double.infinity,
          height: 300,
          child: Container(
            height: 400.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Container(
                      width: 400.0,
                      height: 150,
                      child: SfCircularChart(
                          title: ChartTitle(
                              text: '2021년 자산총게( 단위 : 억원 )',
                              textStyle: TextStyle(
                                fontSize: 15,
                              )
                          ),
                          annotations: <CircularChartAnnotation>[
                            CircularChartAnnotation(
                                widget: Container(
                                    child: PhysicalModel(
                                        child: Container(),
                                        shape: BoxShape.circle,
                                        elevation: 10,
                                        shadowColor: Colors.black,
                                        color: const Color.fromRGBO(230, 230, 230, 1)))),
                          ],
                          legend: Legend(isVisible: true, position: LegendPosition.bottom),
                          series: <CircularSeries>[
                            DoughnutSeries<PieData_2021, String>(
                                sortingOrder: SortingOrder.ascending,
                                dataLabelSettings: DataLabelSettings(
                                    isVisible: true,
                                    // Positioning the data label
                                    labelPosition: ChartDataLabelPosition.outside,
                                    useSeriesColor: true
                                ),
                                dataSource: pieData_2021,
                                xValueMapper: (PieData_2021 data, _) => data.x,
                                yValueMapper: (PieData_2021 data, _) => data.y,
                                pointColorMapper:(PieData_2021 data,  _) => data.color,
                                radius: '65%'
                              // Radius of doughnut
                            )
                          ]
                      )
                  ),
                Container(
                    width: 400.0,
                    height: 150,
                    child: SfCircularChart(
                        title: ChartTitle(
                            text: '2020년 자산총계( 단위 : 억원 )',
                            textStyle: TextStyle(
                              fontSize: 15,
                            )
                        ),
                        annotations: <CircularChartAnnotation>[
                          CircularChartAnnotation(
                              widget: Container(
                                  child: PhysicalModel(
                                      child: Container(),
                                      shape: BoxShape.circle,
                                      elevation: 10,
                                      shadowColor: Colors.black,
                                      color: const Color.fromRGBO(230, 230, 230, 1)))),
                        ],
                        legend: Legend(isVisible: true, position: LegendPosition.bottom),
                        series: <CircularSeries>[
                          DoughnutSeries<PieData_2020, String>(
                              sortingOrder: SortingOrder.ascending,
                              dataLabelSettings: DataLabelSettings(
                                  isVisible: true,
                                  // Positioning the data label
                                  labelPosition: ChartDataLabelPosition.outside,
                                  useSeriesColor: true
                              ),
                              dataSource: pieData_2020,
                              xValueMapper: (PieData_2020 data, _) => data.x,
                              yValueMapper: (PieData_2020 data, _) => data.y,
                              pointColorMapper:(PieData_2020 data,  _) => data.color,
                              radius: '65%'
                            // Radius of doughnut
                          )
                        ]
                    )
                ),
                Container(
                    width: 400.0,
                    height: 150,
                    child: SfCircularChart(
                        title: ChartTitle(
                            text: '2019년 자산총계( 단위 : 억원 )',
                            textStyle: TextStyle(
                              fontSize: 15,
                            )
                        ),
                        annotations: <CircularChartAnnotation>[
                          CircularChartAnnotation(
                              widget: Container(
                                  child: PhysicalModel(
                                      child: Container(),
                                      shape: BoxShape.circle,
                                      elevation: 10,
                                      shadowColor: Colors.black,
                                      color: const Color.fromRGBO(230, 230, 230, 1)))),
                        ],
                        legend: Legend(isVisible: true, position: LegendPosition.bottom),
                        series: <CircularSeries>[
                          DoughnutSeries<PieData_2019, String>(
                              sortingOrder: SortingOrder.ascending,
                              dataLabelSettings: DataLabelSettings(
                                  isVisible: true,
                                  // Positioning the data label
                                  labelPosition: ChartDataLabelPosition.outside,
                                  useSeriesColor: true
                              ),
                              dataSource: pieData_2019,
                              xValueMapper: (PieData_2019 data, _) => data.x,
                              yValueMapper: (PieData_2019 data, _) => data.y,
                              pointColorMapper:(PieData_2019 data,  _) => data.color,
                              radius: '65%'
                            // Radius of doughnut
                          )
                        ]
                    )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  double net_income_thstrm_amount = 0;
  double net_income_frmtrm_amount = 0;
  double net_income_bfefrmtrm_amount = 0;

  @override
  Widget piechart_net_income() {
    final List<PieData_net_income> chartData = [
      PieData_net_income('2019/12', double.parse(net_income_bfefrmtrm_amount.toStringAsFixed(2)), Color.fromRGBO(051,204,153,1)),
      PieData_net_income('2020/12', double.parse(net_income_frmtrm_amount.toStringAsFixed(2)), Color.fromRGBO(051,204,255,1)),
      PieData_net_income('2021/12', double.parse(net_income_thstrm_amount.toStringAsFixed(2)), Color.fromRGBO(051,153,255,1)),
      //ChartData('Others', 52, Color.fromRGBO(255,189,57,1))
    ];
    return GestureDetector(
      onTap: (){_showDialog(net_income,net_income_Detail);},
      child: Card(
        shape: RoundedRectangleBorder(  //모서리를 둥글게 하기 위해 사용
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: SafeArea(
            child: Center(
                child: net_income_thstrm_amount == 0 && net_income_frmtrm_amount == 0 && net_income_bfefrmtrm_amount == 0
                    ? Center(child: Text("load..."),)
                    :Container(
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.all(30),
                    width: double.infinity,
                    height: 300,/*
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20), //모서리를 둥글게
                        border: Border.all(color: Colors.black12, width: 3)), //테두리*/
                    child: SfCircularChart(
                        title: ChartTitle(
                            text: '당기순이익',
                            textStyle: TextStyle(
                              fontSize: 15,
                            )
                        ),
                        legend: Legend(isVisible: true, position: LegendPosition.bottom),
                        series: <CircularSeries>[
                          // Renders doughnut chart
                          DoughnutSeries<PieData_net_income, String>(
                              sortingOrder: SortingOrder.ascending,
                              dataLabelSettings: DataLabelSettings(
                                  isVisible: true,
                                  // Positioning the data label
                                  labelPosition: ChartDataLabelPosition.outside,
                                  useSeriesColor: true
                              ),
                              dataSource: chartData,
                              pointColorMapper:(PieData_net_income data,  _) => data.color,
                              xValueMapper: (PieData_net_income data, _) => data.x,
                              yValueMapper: (PieData_net_income data, _) => data.y
                          )
                        ]
                    )
                )
            )
        ),
      ),
    );
  }
  double CFO_thstrm_amount = 0;
  double CFO_frmtrm_amount = 0;
  double CFO_bfefrmtrm_amount = 0;
  Widget piechart_CFO() {
    final List<PieData_CFO> chartData = [
      PieData_CFO('2019/12', double.parse(CFO_bfefrmtrm_amount.toStringAsFixed(2)), Color.fromRGBO(051,204,153,1)),
      PieData_CFO('2020/12', double.parse(CFO_frmtrm_amount.toStringAsFixed(2)), Color.fromRGBO(051,204,255,1)),
      PieData_CFO('2021/12', double.parse(CFO_thstrm_amount.toStringAsFixed(2)), Color.fromRGBO(051,153,255,1)),
      //ChartData('Others', 52, Color.fromRGBO(255,189,57,1))
    ];
    return GestureDetector(
      onTap:(){_showDialog(CFO,CFO_Detail);},
      child: Card(
        shape: RoundedRectangleBorder(  //모서리를 둥글게 하기 위해 사용
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: SafeArea(
            child: Center(
                child: CFO_thstrm_amount == 0 && CFO_frmtrm_amount == 0 && CFO_bfefrmtrm_amount == 0
                    ? Center(child: Text("load..."),)
                    :Container(
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.all(30),
                    width: double.infinity,
                    height: 300,/*
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20), //모서리를 둥글게
                        border: Border.all(color: Colors.black12, width: 3)), //테두리*/
                    child: SfCircularChart(
                        title: ChartTitle(
                            text: '영업활동 현금흐름',
                            textStyle: TextStyle(
                              fontSize: 15,
                            )
                        ),
                        legend: Legend(isVisible: true, position: LegendPosition.bottom),
                        series: <CircularSeries>[
                          // Renders doughnut chart
                          DoughnutSeries<PieData_CFO, String>(
                              sortingOrder: SortingOrder.ascending,
                              dataLabelSettings: DataLabelSettings(
                                  isVisible: true,
                                  // Positioning the data label
                                  labelPosition: ChartDataLabelPosition.outside,
                                  useSeriesColor: true
                              ),
                              dataSource: chartData,
                              pointColorMapper:(PieData_CFO data,  _) => data.color,
                              xValueMapper: (PieData_CFO data, _) => data.x,
                              yValueMapper: (PieData_CFO data, _) => data.y
                          )
                        ]
                    )
                )
            )
        ),
      ),
    );
  }
  void _showDialog(String n1,String n2) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("가이드"),
          content: SingleChildScrollView(child: new Text(n1),),
          actions: <Widget>[
            new FlatButton(
                child: new Text("자세히보기"),
                onPressed: () {
                  _showDialog1(n2);
                }
            ),
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
  }
  void _showDialog1(String n2) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("자세히보기"),
          content: SingleChildScrollView(child: new Text(n2),),
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
  }
  String Total_assets ='자산총계는 기업이 영업활동을 위하여 보유하고 있는 재산을 말합니다.\n※ 자산총계 = 자본총계₁ + 부채총계₂\n※ 이 수치가 높으면 회사가 운용할 수 있는 자산이 많다는 의미입니다.';
  String Total_assets1_Detail='자본총계: 회사가 보유하고 있는 현금, 제품, 채권 등의 총합\n부채총계: 채권자로 부터 빌린 자금의 총합';


  String total_capital='자본총계: 회사가 보유하고 있는 현금, 제품, 채권 등의 총합';
  String total_capital_Detail='';

  String Total_Debt='부채총계는 주주 이외의 제 3자에게서 빌린 자본을 말합니다.\n※ 부채비율 = 부채총계 / 자본총계 X 100\n※ 부채비율이 높으면 재무 건전성 혹은 안정성이 좋지 않다는 의미입니다.\n※ 특히 부채비율이 400%가 넘는 회사는 투자에 유의하여야 합니다.';
  String Total_Debt1_Detail='자본총계: 회사가 보유하고 있는 현금, 제품, 채권 등의 총합\n부채총계: 채권자로 부터 빌린 자금의 총합';

  String net_income = '당기순이익(순이익)은 기업이 1년 간 얻은 수익에서 모든 지출비용을 공제하고 순수하게 이익으로 남은 금액입니다.\n※ 당기순이익= 법인세비용차감전순이익₁ - 법인세비용₂\n※ 이 수치가 높으면 1년간 회사가 많은 이익을 얻었다는 의미입니다.';
  String net_income_Detail='법인세비용차감전순이익 = 영업이익 + 영업외수익(투자 수익 등) - 영업외비용(기부금, 지출 이자 등)\n법인세비용: 소득에 대해 납부하여야 할 세금';

  String CFO='영업활동현금흐름(CFO)은 기업의 영업활동을 통해 발생되는 현금흐름을 말합니다.\n※ CFO = 영업이익 + 감가상각비 - 법인세\n※ 이 수치는 사업활동으로부터 현금 유입의 발생 정도를 의미합니다.(대체로 높으면 긍정)\n※ 수치가 높아도 과거 발생한 영업활동으로 매출채권을 회수하는 등의 변동이 있을 수도 있습니다.';
  String CFO_Detail='법인세비용차감전순이익 = 영업이익 + 영업외수익(투자 수익 등) - 영업외비용(기부금, 지출 이자 등)\n법인세비용: 소득에 대해 납부하여야 할 세금';
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: Container(child: CircularProgressIndicator(),),)
        : ListView(
      children: [
        piechart_total_assets(),
        piechart_net_income(),
        piechart_CFO(),
      ],
    );
  }

  Future<void> Find_Pie_data(String total_capital, Total_Debt, net_income ,CFO) async
  {
    String url1 = "http:///sql/${Total_Debt}";
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

    Total_Debt_thstrm_amount = (double.parse(list1[0]['thstrm_amount'])/100000000);
    //d_Total_assets3 = double.parse(Total_Debt) / 100000000;
    Total_Debt_frmtrm_amount = double.parse(list1[0]['frmtrm_amount'])/100000000;
    //d_Total_assets2 = double.parse(Total_Debt) / 100000000;
    Total_Debt_bfefrmtrm_amount = double.parse(list1[0]['bfefrmtrm_amount'])/100000000;
    //d_Total_assets1 = double.parse(Total_Debt) / 100000000;

    String url2 = "http:///sql/${total_capital}";
    String Changed_String2 = url2.replaceAll(' ', '!');
    var response2 = await https.get(Uri.parse(Changed_String2));

    var statusCode2 = response2.statusCode;
    var responseHeaders2 = response2.headers;
    var responseBody2 = response2.body;

    List list2 = jsonDecode(responseBody2);

/*    print("statusCode: ${statusCode1}");
    print("responseHeaders: ${responseHeaders1}");
    print("responseBody: ${responseBody1}");*/

/*    print(list1[0]['bfefrmtrm_amount']);
    print(list1[0]['frmtrm_amount']);
    print(list1[0]['thstrm_amount']);*/

    total_capital_thstrm_amount = (double.parse(list2[0]['thstrm_amount'])/100000000);
    //d_Total_assets3 = double.parse(Total_Debt) / 100000000;
    total_capital_frmtrm_amount = double.parse(list2[0]['frmtrm_amount'])/100000000;
    //d_Total_assets2 = double.parse(Total_Debt) / 100000000;
    total_capital_bfefrmtrm_amount = double.parse(list2[0]['bfefrmtrm_amount'])/100000000;
    //d_Total_assets1 = double.parse(Total_Debt) / 100000000;

    String url3 = "http:///sql/${net_income}";
    String Changed_String3 = url3.replaceAll(' ', '!');
    var response3 = await https.get(Uri.parse(Changed_String3));

    var statusCode3 = response3.statusCode;
    var responseHeaders3 = response3.headers;
    var responseBody3 = response3.body;

    List list3 = jsonDecode(responseBody3);

/*    print("statusCode: ${statusCode1}");
    print("responseHeaders: ${responseHeaders1}");
    print("responseBody: ${responseBody1}");*/

/*    print(list1[0]['bfefrmtrm_amount']);
    print(list1[0]['frmtrm_amount']);
    print(list1[0]['thstrm_amount']);*/

    net_income_thstrm_amount = (double.parse(list3[0]['thstrm_amount'])/100000000);
    //d_Total_assets3 = double.parse(Total_Debt) / 100000000;
    net_income_frmtrm_amount = double.parse(list3[0]['frmtrm_amount'])/100000000;
    //d_Total_assets2 = double.parse(Total_Debt) / 100000000;
    net_income_bfefrmtrm_amount = double.parse(list3[0]['bfefrmtrm_amount'])/100000000;
    //d_Total_assets1 = double.parse(Total_Debt) / 100000000;

    String url4 = "http:///sql/${CFO}";
    String Changed_String4 = url4.replaceAll(' ', '!');
    var response4 = await https.get(Uri.parse(Changed_String4));

    var statusCode4 = response4.statusCode;
    var responseHeaders4 = response4.headers;
    var responseBody4 = response4.body;

    List list4 = jsonDecode(responseBody4);

/*    print("statusCode: ${statusCode1}");
    print("responseHeaders: ${responseHeaders1}");
    print("responseBody: ${responseBody1}");*/

/*    print(list1[0]['bfefrmtrm_amount']);
    print(list1[0]['frmtrm_amount']);
    print(list1[0]['thstrm_amount']);*/

    CFO_thstrm_amount = (double.parse(list4[0]['thstrm_amount'])/100000000);
    //d_Total_assets3 = double.parse(Total_Debt) / 100000000;
    CFO_frmtrm_amount = double.parse(list4[0]['frmtrm_amount'])/100000000;
    //d_Total_assets2 = double.parse(Total_Debt) / 100000000;
    CFO_bfefrmtrm_amount = double.parse(list4[0]['bfefrmtrm_amount'])/100000000;
    //d_Total_assets1 = double.parse(Total_Debt) / 100000000;
  }

  /*NewBieQuery query = NewBieQuery();

  late TrackballBehavior _trackballBehavior;

  String chart_up ="images/chart_up.jpg";
  String chart_down ="images/chart_down.jpg";

  void initState()   {
    // TODO: implement initState
    super.initState();
    _trackballBehavior = TrackballBehavior(enable: true, activationMode:  ActivationMode.singleTap);
    FinancialState fb = FinancialState();
    searchText = fb.name;
    if(fb.name == ""){
      searchText = Get.arguments;
    }
    Future<String> Stock_Code;
    Stock_Code = query.Find_Stock_Code(searchText);
    Stock_Code.then((val) async {
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
    Future.delayed(Duration(seconds:2), () {
      setState(() {
        super.setState(() {
        });
      });
    });
  }

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
              Future.delayed(Duration(seconds: 2), () {
                setState(() {
                  super.setState(() {
                    EasyLoading.showSuccess('Success');
                  });
                });
              });
            },
            child: Text("별도 재무제표 검색", style: TextStyle(color: Colors.white),),
          ),
          SizedBox(width: 5,),
        ],
      ),
    );
  }
//////////////////손익계산서
  String wa= '이건 오르면 안좋아요!';
  String wa1 = '이건 오르면 좋아요!';
  String sales ='매출액은 영업활동(제품판매, 서비스제공 등)을 통해 얻은 수익을 말합니다.\n(순)매출액 = 총매출액 - (매출 할인₁ + 매출 에누리₂ + 매입환출/매출환입₃)\n※ 이 수치가 높으면 1년간 회사가 많은 활동을 했다는 의미입니다.';
  String sales_Detail='매출 할인: 외상매출금을 조기 회수하는 경우 대금에 대한 할인액\n매출 에누리: 매출한 상품 중 불량품, 파손, 견본과 상이 등의 이유로 상품 대금에 대해 깎은 금액\n매입환출/매출환입(반품): 거래한 상품 중 불량품, 파손 등의 이유로 상품을 반품 하거나 받는 것';

  String salling = '판매비와 관리비(판관비)는 상품, 서비스 등의 판매 활동과 기업의 관리ㆍ유지 활동에서 발생하는 비용을 말합니다.\n판관비에 영향을 주는 요소는 급여, 보험료, 임차료 등이 있습니다.\n※ 이 수치가 높으면 1년간 회사가 많은 지출을 했다는 의미입니다.';
  String salling_Detail='급여: 종업원과 임원의 보수 및 수당으로 지급한 금액\n보험료: 건물 등의 화재 보험료 또는 그 밖의 손해 보험료\n임차료: 토지, 건물등을 빌려 쓰고 지급한 집세 또는 월세\n세금과공과: 재산세, 자동차세 등\n통신비: 업무 활동에 이용되는 전신, 전화, 인터넷사용료, 우편요금 등\n수도광열비: 수도료, 가스료, 전기료, 냉난방 연료비 등\n여비교통비: 영업활동에서 발생한 직원의 출장비, 숙박비, 교통비 등\n퇴직급여: 종업원의 퇴직 시 회사의 규정에 의해 지급하여야 할 퇴직금 중 당해 연도 부담분에 속하는 금액\n복리후생비: 종업원의 복지에 지출된 비용(식대보조금, 경조금, 축의금 등)\n접대비: 영업활동과 관련된 거래처와의 업무상 접대를 위한 비용\n수선비: 유형자산의 사용 중에 발생한 수리비 중 수익적 지출에 해당하는 금액 등의\n운반비: 매출한 상품을 운반할 때 발생하는 비용\n소모품비: 사무용 필기구, 용지 등 사무용품 구입비(비용처리)\n광고선전비: 판매 촉진을 위한 신문, 방송 등을 통한 광고 활동에 사용된 금액\n상각: 가치가 감소한 만큼을 장부에서 떨어낸다는 뜻\n대손상각비: 매출채권의 회수가 불가능해진 손실(파산 등의 이유)로 대손추산액(손실)에서 대손충당금(회사가 손실을 대비한 충당금) 잔액을 차감한 금액\n감가상각비: 결산 시에 유형자산의 가치 감소분을 처리하는 비용\n유형자산: 판매가 아닌 영업활동을 지원하기 위한 실존하는 자산\n무형자산상각비: 산업재산권, 컴퓨터소프트웨어 등의 무형자산 상각액\n연구비: 신제품 또는 신기술의 연구 활동에 관련된 비용\n경상개발비: 신제품 또는 신기술 등의 개발과 관련하여 발생한 비용 중 개별적으로 식별이 불가능하고 미래 경제적 효익이 불확실한 경우 처리하는 비용\n잡비: 영업활동에서 발생하였으나 금액 또는 발생 횟수가 적어 다른 계정과목에 포함시키는 것이 적절치 않은 비용\n토지: 영업활동을 위하여 취득한 대지, 임야 등\n건물: 건물, 냉난방, 전기, 통신 및 기타의 건물부속설비\n구축물: 교량, 궤도, 울타리, 배수로 등\n기계장치: 기계장치, 운송설비와 기타의 부속설비\n기타자산: 차량운반구, 항공기, 선박, 비품 등\n건설중인 자산: 유형자산의 건설을 위해 투입한 원가';

  String EBIT = '영업이익은 매출총이익에서 판매비와 관리비를 차감하여 계산한 금액입니다.\n※ 매출총이익 = 매출액 - 매출원가₁\n※ 이 수치가 높으면 1년간 회사가 많은 이익을 얻었다는 의미입니다.';
  String EBIT_Detail='매출원가: 기업이 상품을 제조하는 데 들인 원가\n매출액: 영업활동(제품판매, 서비스제공 등)을 통해 얻은 수익';

  String net_income = '당기순이익(순이익)은 기업이 1년 간 얻은 수익에서 모든 지출비용을 공제하고 순수하게 이익으로 남은 금액입니다.\n※ 당기순이익= 법인세비용차감전순이익₁ - 법인세비용₂\n※ 이 수치가 높으면 1년간 회사가 많은 이익을 얻었다는 의미입니다.';
  String net_income_Detail='법인세비용차감전순이익 = 영업이익 + 영업외수익(투자 수익 등) - 영업외비용(기부금, 지출 이자 등)\n법인세비용: 소득에 대해 납부하여야 할 세금';

  //////////////////재무상태표
  String Total_assets ='자산총계는 기업이 영업활동을 위하여 보유하고 있는 재산을 말합니다.\n※ 자산총계 = 자본총계₁ + 부채총계₂\n※ 이 수치가 높으면 회사가 운용할 수 있는 자산이 많다는 의미입니다.';
  String Total_assets1_Detail='자본총계: 회사가 보유하고 있는 현금, 제품, 채권 등의 총합\n부채총계: 채권자로 부터 빌린 자금의 총합';

  String tangible_assets = '유형자산은 판매가 아닌 영업활동을 지원하기 위해 실존하는 자산을 말합니다.\n유형자산의 종류에는 토지, 건물, 구축물 등이 있습니다.\n※ 이 수치가 높으면 1년간 회사가 영업활동을 위해 보유한 유형자산이 많아졌다는 의미입니다.';
  String tangible_assets_Detail='토지: 영업활동을 위하여 취득한 대지, 임야 등\n건물: 건물, 냉난방, 전기, 통신 및 기타의 건물부속설비\n구축물: 교량, 궤도, 울타리, 배수로 등\n기계장치: 기계장치, 운송설비와 기타의 부속설비\n기타자산: 차량운반구, 항공기, 선박, 비품 등\n건설중인 자산: 유형자산의 건설을 위해 투입한 원가';

  String intangible_assets ='무형자산은 판매가 아닌 영업활동을 지원하기 위해 실체가 없는 자산을 말합니다.\n무형자산의 종류에는 영업권, 산업재산권, 개발비 등이 있습니다.\n※ 이 수치가 높으면 1년간 회사가 영업활동을 위해 보유한 무형자산이 많아졌다는 의미입니다.';
  String intangible_assets1_Detail='\n영업권: 동종의 다른 기업보다 더 많은 수익을 얻을 경우 그 초과수익을 자본의 가치로 환원한 것\n산업재산권: 법률에 의하여 등록하고 일정기간 독점적, 배타적으로 이용할 수 있는 산업적 이용가치가 있는 권리\n개발비: 제품이나 기술 개발 또는 개량을 위하여 지출한 금액\n라이선스: 특정한 일을 할 수 있는 독점적인 자격을 행정 기관이 허가하는 일\n프랜차이즈: 자신의 상호ㆍ상표 등을 제공하는 것\n저작권: 창작물을 만든이가 자기 저작물에 대해 가지는 베타적인 법적 권리';

  String cash_equivalents ='현금 및 현금성자산은 회사가 현금과 같은 목적으로 보유하고 있는 자산을 말합니다.\n현금 및 현금성자산에는 현금, 현금성자산, 당좌예금, 보통예금이 있습니다.\n※ 이 수차기 높으면 회사가 보유하고 있는 자산이 많다는 의미입니다.';
  String cash_equivalents_Detail='현금: 지폐나 주화 등의 통화수단. 혹은 통화대용증권\n현금성자산: 취득 당시 만기가 3개월 이내인 단기예금(단기금융상품)\n당좌예금: 당좌수표를 발행할 목적으로한 예금';

  String total_capital='자본총계: 회사가 보유하고 있는 현금, 제품, 채권 등의 총합';
  String total_capital_Detail='';

  String Total_Debt='부채총계는 주주 이외의 제 3자에게서 빌린 자본을 말합니다.\n※ 부채비율 = 부채총계 / 자본총계 X 100\n※ 부채비율이 높으면 재무 건전성 혹은 안정성이 좋지 않다는 의미입니다.\n※ 특히 부채비율이 400%가 넘는 회사는 투자에 유의하여야 합니다.';
  String Total_Debt1_Detail='자본총계: 회사가 보유하고 있는 현금, 제품, 채권 등의 총합\n부채총계: 채권자로 부터 빌린 자금의 총합';

  /////////////////////현금 흐름표

  String CFO='영업활동현금흐름(CFO)은 기업의 영업활동을 통해 발생되는 현금흐름을 말합니다.\n※ CFO = 영업이익 + 감가상각비 - 법인세\n※ 이 수치는 사업활동으로부터 현금 유입의 발생 정도를 의미합니다.(대체로 높으면 긍정)\n※ 수치가 높아도 과거 발생한 영업활동으로 매출채권을 회수하는 등의 변동이 있을 수도 있습니다.';
  String CFO_Detail='법인세비용차감전순이익 = 영업이익 + 영업외수익(투자 수익 등) - 영업외비용(기부금, 지출 이자 등)\n법인세비용: 소득에 대해 납부하여야 할 세금';

  String IACF='투자활동현금흐름(CFI)은 기업이 투자활동을 하면서 발생하는 현금흐름을 말합니다.\n※ 이 수치가 높으면 회사가 과거에 투자한 현금을 회수했다는 의미입니다.\n※ 이 수치가 낮으면 회사가 공격적인 투자를 하고있다는 의미입니다.';
  String IACF_Detail='';

  String FACF='재무활동현금흐름(CFF)은 투자자와 채권자들의 기업 사이에서 발생한 현금흐름을 말합니다.\n※ 이 수치가 높으면 자본 또는 주식을 발행하거나 채권자나 은행으로부터 차입을 의미합니다.\n※ 이 수치가 낮으면 자사주 매입, 배당금, 부채 상환 등을 의미합니다.';
  String FACF_Detail='';
  void _showDialog(String n1,String n2) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("가이드"),
          content: SingleChildScrollView(child: new Text(n1),),
          actions: <Widget>[
            new FlatButton(
                child: new Text("자세히보기"),
                onPressed: () {
                  _showDialog1(n2);
                }
            ),
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
  }
  void _showDialog1(String n2) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("자세히보기"),
          content: SingleChildScrollView(child: new Text(n2),),
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
  }
  Widget _SOCI(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), //모서리를 둥글게
          border: Border.all(color: Colors.black12, width: 3)), //테두리
      margin: EdgeInsets.all(5),
      child:DataTable(
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
              '2020/12',style: TextStyle(fontSize: 12),
            ),
          ),
          DataColumn(
            label: Text(
              '2021/12',style: TextStyle(fontSize: 12),
            ),
          ),
          DataColumn(
            label: Text(
              '전년대비',style: TextStyle(fontSize: 12),
            ),
          ),
        ],
        rows: <DataRow>[
          DataRow(
            cells: <DataCell>[
              DataCell(TextButton(onPressed: () {Get.to(()=>Fin_Chart(),arguments: ['매출액',query.sales1, query.sales2, query.sales3]);},
                child:Text("매출액",style: TextStyle(fontSize: 12)),)),
              DataCell(GestureDetector(onTap: () {_showDialog(sales,sales_Detail);}, child: Image.asset(query.sales1_chart, height: 45,))),
              DataCell(GestureDetector(onTap: () {_showDialog(sales,sales_Detail);}, child: Image.asset(query.sales2_chart, height: 45,))),
              DataCell(GestureDetector(onTap: () {_showDialog(sales,sales_Detail);}, child: Image.asset(query.sales3_chart, height: 45,))),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(TextButton(onPressed: () {Get.to(()=>Fin_Chart(),arguments: ['판매비와 관리비',query.selling1, query.selling2, query.selling3]);},
                child: Text("판매비와 관리비",style: TextStyle(fontSize: 12)),)),
              DataCell(GestureDetector(onTap: () {_showDialog(salling,salling_Detail);}, child: Image.asset(query.selling1_chart, height: 45,))),
              DataCell(GestureDetector(onTap: () {_showDialog(salling,salling_Detail);}, child: Image.asset(query.selling2_chart, height: 45,))),
              DataCell(GestureDetector(onTap: () {_showDialog(salling,salling_Detail);}, child: Image.asset(query.selling3_chart, height: 45,))),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(TextButton(onPressed: () {Get.to(()=>Fin_Chart(),arguments: ['영업이익',query.EBIT1, query.EBIT2, query.EBIT3]);},
                child: Text("영업이익",style: TextStyle(fontSize: 12)),)),
              DataCell(GestureDetector(onTap: () {_showDialog(EBIT,EBIT_Detail);}, child: Image.asset(query.EBIT1_chart, height: 45,))),
              DataCell(GestureDetector(onTap: () {_showDialog(EBIT,EBIT_Detail);}, child: Image.asset(query.EBIT2_chart, height: 45,))),
              DataCell(GestureDetector(onTap: () {_showDialog(EBIT,EBIT_Detail);}, child: Image.asset(query.EBIT3_chart, height: 45,))),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(TextButton(onPressed: () {Get.to(()=>Fin_Chart(),arguments: ['당기순이익',query.net_income1, query.net_income2, query.net_income3]);},
                child: Text("당기순이익",style: TextStyle(fontSize: 12)),)),
              DataCell(GestureDetector(onTap: () {_showDialog(net_income,net_income_Detail);}, child: Image.asset(query.net_income1_chart, height: 45,))),
              DataCell(GestureDetector(onTap: () {_showDialog(net_income,net_income_Detail);}, child: Image.asset(query.net_income2_chart, height: 45,))),
              DataCell(GestureDetector(onTap: () {_showDialog(net_income,net_income_Detail);}, child: Image.asset(query.net_income3_chart, height: 45,))),
            ],
          ),
        ],
      ),
    );
  }
  Widget _B_Sheet() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), //모서리를 둥글게
          border: Border.all(color: Colors.black12, width: 3)), //테두리
      margin: EdgeInsets.all(5),
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
              '2020/12',style: TextStyle(fontSize: 12),
            ),
          ),
          DataColumn(
            label: Text(
              '2021/12',style: TextStyle(fontSize: 12),
            ),
          ),
          DataColumn(
            label: Text(
              '전년대비',style: TextStyle(fontSize: 12),
            ),
          ),
        ],
        rows: <DataRow>[
          DataRow(
            cells: <DataCell>[
              DataCell(TextButton(onPressed: () {Get.to(()=>Fin_Chart(),arguments: ['자산총계',query.Total_assets1, query.Total_assets2, query.Total_assets3]);},
                child: Text("자산총계",style: TextStyle(fontSize: 12)),)),
              DataCell(GestureDetector(onTap: () {_showDialog(Total_assets,Total_assets1_Detail);}, child: Image.asset(query.Total_assets1_chart, height: 45,))),
              DataCell(GestureDetector(onTap: () {_showDialog(Total_assets,Total_assets1_Detail);}, child: Image.asset(query.Total_assets2_chart, height: 45,))),
              DataCell(GestureDetector(onTap: () {_showDialog(Total_assets,Total_assets1_Detail);}, child: Image.asset(query.Total_assets3_chart, height: 45,))),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(TextButton(onPressed: () {Get.to(()=>Fin_Chart(),arguments: ['유형자산',query.tangible_assets1, query.tangible_assets2, query.tangible_assets3]);},
                child: Text("유형자산",style: TextStyle(fontSize: 12)),)),
              DataCell(GestureDetector(onTap: () {_showDialog(tangible_assets,tangible_assets_Detail);}, child: Image.asset(query.tangible_assets1_chart, height: 45,))),
              DataCell(GestureDetector(onTap: () {_showDialog(tangible_assets,tangible_assets_Detail);}, child: Image.asset(query.tangible_assets2_chart, height: 45,))),
              DataCell(GestureDetector(onTap: () {_showDialog(tangible_assets,tangible_assets_Detail);}, child: Image.asset(query.tangible_assets3_chart, height: 45,))),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(TextButton(onPressed: () {Get.to(()=>Fin_Chart(),arguments: ['무형자산',query.intangible_assets1, query.intangible_assets2, query.intangible_assets3]);},
                child: Text("무형자산",style: TextStyle(fontSize: 12)),)),
              DataCell(GestureDetector(onTap: () {_showDialog(intangible_assets,intangible_assets1_Detail);}, child: Image.asset(query.intangible_assets1_chart, height: 45,))),
              DataCell(GestureDetector(onTap: () {_showDialog(intangible_assets,intangible_assets1_Detail);}, child: Image.asset(query.intangible_assets2_chart, height: 45,))),
              DataCell(GestureDetector(onTap: () {_showDialog(intangible_assets,intangible_assets1_Detail);}, child: Image.asset(query.intangible_assets3_chart, height: 45,))),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(TextButton(onPressed: () {Get.to(()=>Fin_Chart(),arguments: ['현금및현금성자산',query.cash_equivalents1, query.cash_equivalents2, query.cash_equivalents3]);},
                child: Text("현금및현금성자산",style: TextStyle(fontSize: 12)),)),
              DataCell(GestureDetector(onTap: () {_showDialog(cash_equivalents,cash_equivalents_Detail);}, child: Image.asset(query.cash_equivalents1_chart, height: 45,))),
              DataCell(GestureDetector(onTap: () {_showDialog(cash_equivalents,cash_equivalents_Detail);}, child: Image.asset(query.cash_equivalents2_chart, height: 45,))),
              DataCell(GestureDetector(onTap: () {_showDialog(cash_equivalents,cash_equivalents_Detail);}, child: Image.asset(query.cash_equivalents3_chart, height: 45,))),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(TextButton(onPressed: () {Get.to(()=>Fin_Chart(),arguments: ['자본총계',query.total_capital1, query.total_capital2, query.total_capital3]);},
                child: Text("자본총계",style: TextStyle(fontSize: 12)),)),
              DataCell(GestureDetector(onTap: () {_showDialog1(total_capital);}, child: Image.asset(query.total_capital1_chart, height: 45,))),
              DataCell(GestureDetector(onTap: () {_showDialog1(total_capital);}, child: Image.asset(query.total_capital2_chart, height: 45,))),
              DataCell(GestureDetector(onTap: () {_showDialog1(total_capital);}, child: Image.asset(query.total_capital3_chart, height: 45,))),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(TextButton(onPressed: () {Get.to(()=>Fin_Chart(),arguments: ['부채총계',query.Total_Debt1, query.Total_Debt2, query.Total_Debt3]);},
                child: Text("부채총계",style: TextStyle(fontSize: 12)),)),
              DataCell(GestureDetector(onTap: () {_showDialog(Total_Debt,Total_Debt1_Detail);}, child: Image.asset(query.Total_Debt1_chart, height: 45,))),
              DataCell(GestureDetector(onTap: () {_showDialog(Total_Debt,Total_Debt1_Detail);}, child: Image.asset(query.Total_Debt2_chart, height: 45,))),
              DataCell(GestureDetector(onTap: () {_showDialog(Total_Debt,Total_Debt1_Detail);}, child: Image.asset(query.Total_Debt3_chart, height: 45,))),
            ],
          ),
        ],
      ),
    );
  }
  Widget _SCF() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), //모서리를 둥글게
          border: Border.all(color: Colors.black12, width: 3)), //테두리
      margin: EdgeInsets.all(5),
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
              '2020/12',style: TextStyle(fontSize: 12),
            ),
          ),
          DataColumn(
            label: Text(
              '2021/12',style: TextStyle(fontSize: 12),
            ),
          ),
          DataColumn(
            label: Text(
              '전년대비',style: TextStyle(fontSize: 12),
            ),
          ),
        ],
        rows: <DataRow>[
          DataRow(
            cells: <DataCell>[
              DataCell(TextButton(onPressed: () {Get.to(()=>Fin_Chart(),arguments: ['영업활동현금흐름',query.CFO1, query.CFO2, query.CFO3]);},
                child: Text("영업활동현금흐름",style: TextStyle(fontSize: 12)),)),
              DataCell(GestureDetector(onTap: () {_showDialog(CFO,CFO_Detail);}, child: Image.asset(query.CFO1_chart, height: 45,))),
              DataCell(GestureDetector(onTap: () {_showDialog(CFO,CFO_Detail);}, child: Image.asset(query.CFO2_chart, height: 45,))),
              DataCell(GestureDetector(onTap: () {_showDialog(CFO,CFO_Detail);}, child: Image.asset(query.CFO3_chart, height: 45,))),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(TextButton(onPressed: () {Get.to(()=>Fin_Chart(),arguments: ['투자활동현금흐름',query.IACF1, query.IACF2, query.IACF3]);},
                child: Text("투자활동현금흐름",style: TextStyle(fontSize: 12)),)),
              DataCell(GestureDetector(onTap: () {_showDialog1(IACF);}, child: Image.asset(query.IACF1_chart, height: 45,))),
              DataCell(GestureDetector(onTap: () {_showDialog1(IACF);}, child: Image.asset(query.IACF2_chart, height: 45,))),
              DataCell(GestureDetector(onTap: () {_showDialog1(IACF);}, child: Image.asset(query.IACF3_chart, height: 45,))),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(TextButton(onPressed: () {Get.to(()=>Fin_Chart(),arguments: ['재무활동현금흐름',query.FACF1, query.FACF2, query.FACF3]);},
                child: Text("재무활동현금흐름",style: TextStyle(fontSize: 12)),)),
              DataCell(GestureDetector(onTap: () {_showDialog1(FACF);}, child: Image.asset(query.FACF1_chart, height: 45,))),
              DataCell(GestureDetector(onTap: () {_showDialog1(FACF);}, child: Image.asset(query.FACF2_chart, height: 45,))),
              DataCell(GestureDetector(onTap: () {_showDialog1(FACF);}, child: Image.asset(query.FACF3_chart, height: 45,))),
            ],
          ),
        ],
      ),
    );
  }*/

/*  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _Search(context),
        _SOCI(context),
        _B_Sheet(),
        _SCF(),
      ],
    );
  }*/
  @override
// TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
