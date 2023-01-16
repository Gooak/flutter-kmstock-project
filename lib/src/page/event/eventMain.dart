import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:http/http.dart' as https;
import 'dart:convert';
import '../homeMain/homeMain.dart';

class EnvelData {
  EnvelData({
    this.empty,
    this.date,
  });
  int? empty;
  DateTime? date;

  factory EnvelData.fromRawJson(String str) => EnvelData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EnvelData.fromJson(Map<String, dynamic> json) => EnvelData(
    empty: json["종가"].toInt(),
    date: DateTime.parse(json["날짜"]),
  );

  Map<String, dynamic> toJson() => {
    "종가": empty!,
    "날짜": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
  };
}
class event extends StatefulWidget {
  @override
  event_main createState() => event_main();
}

class event_main extends State<event> {
/*  Widget _AIname1(){
    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
      width: double.infinity,
      height: 50,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Row(children: [
              SizedBox(width: 10,),
              Text(
                "인공지능 차트 예측 1일",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ]),
          ),
        ],
      ),
    );
  }
  Widget _AiChart1(){
    return Container(
      width: double.infinity,
      height: 280,
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 3, color: Colors.black))),
      child: Column(
        children: [
          Container(
              width: 300,
              height: 200,
          child: SfCartesianChart(
            // Initialize category axis
              primaryXAxis: CategoryAxis(
                plotBands: [
                  PlotBand(
                    color: Colors.lightBlue,
                    text:('AI'),
                    textStyle: TextStyle(
                      color: Colors.white,
                    ),
                    textAngle: 0,
                    isVisible: true,
                    start:4,
                    end:5,
                    //start:DateTime(오늘날짜),
                    //end:DateTime(예측날짜),
                  )
                ]
              ),
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
          ),
          Container(
              width: 200,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("종목이름"),
                    Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
              Text("주가",style: TextStyle(fontSize: 20),),
              Text("예상수익 or 상승 확률"),
                  ]
              ),]),
          ),
        ],
      ),
    );
  }
  Widget _AIname7(){
    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
      width: double.infinity,
      height: 50,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Row(children: [
              SizedBox(width: 10,),
              Text(
                "인공지능 차트 예측 7일",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ]),
          ),
        ],
      ),
    );
  }
  Widget _AiChart7(){
    return Container(
      width: double.infinity,
      height: 280,
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 3, color: Colors.black))),
      child: Column(
        children: [
          Container(
              width: 300,
              height: 200,
              child: SfCartesianChart(
                // Initialize category axis
                  primaryXAxis: CategoryAxis(
                      plotBands: [
                        PlotBand(
                          color: Colors.lightBlue,
                          text:('AI'),
                          textStyle: TextStyle(
                            color: Colors.white,
                          ),
                          textAngle: 0,
                          isVisible: true,
                          start:3.5,
                          end:5,
                          //start:DateTime(오늘날짜),
                          //end:DateTime(예측날짜),
                        )
                      ]
                  ),
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
          ),
          Container(
            width: 200,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("종목이름"),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("주가",style: TextStyle(fontSize: 20),),
                        Text("예상수익 or 상승 확률"),
                      ]
                  ),]),
          ),
        ],
      ),
    );
  }
  Widget _AIname15(){
    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
      width: double.infinity,
      height: 50,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Row(children: [
              SizedBox(width: 10,),
              Text(
                "인공지능 차트 예측 15일",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ]),
          ),
        ],
      ),
    );
  }
  Widget _AiChart15(){
    return Container(
      width: double.infinity,
      height: 280,
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 3, color: Colors.black))),
      child: Column(
        children: [
          Container(
              width: 300,
              height: 200,
              child: SfCartesianChart(
                // Initialize category axis
                  primaryXAxis: CategoryAxis(
                      plotBands: [
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
                      ]
                  ),
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
          ),
          Container(
            width: 200,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("종목이름"),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("주가",style: TextStyle(fontSize: 20),),
                        Text("예상수익 or 상승 확률"),
                      ]
                  ),]),
          ),
        ],
      ),
    );
  }*/

  int last = 0;
  int last_ = 0;
  List<EnvelData> _Enveldata = [];
  bool isLoading = false;
  late TooltipBehavior _tooltipBehavior;
  @override
  void initState() {
    setState(() {
      isLoading = true;
    });
/*    DateTime now = DateTime.now();
    DateTime today = now.subtract(Duration(days:1));
    DateFormat formatter = DateFormat('yyyyMMdd');
    strToday = formatter.format(today);*/
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    String strToday = formatter.format(now);
    _tooltipBehavior = TooltipBehavior(enable: true,);
    Future.microtask(() async {
      String find_date = "SELECT 날짜, 종가 FROM finance_timedata.history_005930 WHERE 날짜 BETWEEN DATE_SUB(NOW(), INTERVAL 7 DAY) AND DATE_SUB(NOW(), INTERVAL 1 DAY) limit 5;";
      await find_history(find_date);
      await find_ai(strToday);
    });
    Future.delayed(Duration(seconds:3), () {
      setState(() {
        super.setState(() {
          isLoading = false;
        });
      });
    });
    super.initState();
  }

  Future<void> find_ai(String date) async {
    print(date);

    String url = "http://sql2/SELECT * FROM stock.value where 날짜 = '${date}';";
    String Changed_String1 = url.replaceAll(' ', '!');
    var response1= await https.get(Uri.parse(Changed_String1));
    var statusCode1 = response1.statusCode;
    var responseHeaders1 = response1.headers;
    //var responseBody1 = response1.body;
    var responseBody1 = jsonDecode(response1.body);
    //print("statusCode: ${statusCode1}");
    //print("responseHeaders: ${responseHeaders1}");
    print("responseBody: ${responseBody1}");
    _Enveldata +=
    List<EnvelData>.from(responseBody1.map((x) => EnvelData.fromJson(x)));
    print(_Enveldata.length);

    last = _Enveldata.length;
    print(last);
    last_ = last-1;
    print(last_);
  }

  Future<void> find_history(String stock) async {
    print("진입");

    String url = "http://sql/${stock}";
    String Changed_String1 = url.replaceAll(' ', '!');
    var response1= await https.get(Uri.parse(Changed_String1));
    var statusCode1 = response1.statusCode;
    var responseHeaders1 = response1.headers;
    //var responseBody1 = response1.body;
    var responseBody1 = jsonDecode(response1.body);
    //print("statusCode: ${statusCode1}");
    //print("responseHeaders: ${responseHeaders1}");
    //print("responseBody: ${responseBody1}");
    _Enveldata =
    List<EnvelData>.from(responseBody1.map((x) => EnvelData.fromJson(x)));
  }
  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: Container(child: CircularProgressIndicator(),),)
        : Card(
      shape: RoundedRectangleBorder(  //모서리를 둥글게 하기 위해 사용
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 4,
      child: Container(
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Scaffold(
              body: SfCartesianChart(
                  title: ChartTitle(
                      text: '인공지능 차트예측 (삼성전자)',
                      textStyle: TextStyle(
                        fontSize: 15,
                      )
                  ),
                // Initialize category axis
                  primaryXAxis:DateTimeAxis(
                      dateFormat: DateFormat.Md(),
                      plotBands: [
/*                        PlotBand(
                          color: Colors.lightBlue,
                          text:('AI'),
                          textStyle: TextStyle(
                            color: Colors.white,
                          ),
                          textAngle: 0,
                          isVisible: true,
                          start:_Enveldata[4].date,
                          end:_Enveldata[5].date,
                        )*/
                      ]
                  ),
                  tooltipBehavior: _tooltipBehavior,
                  series: <CartesianSeries>[
                    LineSeries<EnvelData, DateTime>(
                      // Bind data source
                      dataSource: _Enveldata,
                      xValueMapper: (EnvelData sales, _) => sales.date!,
                      yValueMapper: (EnvelData sales, _) => sales.empty!,
                        dataLabelSettings: DataLabelSettings(
                          isVisible: true,
                          // Positioning the data label
                          useSeriesColor: true,
                        )
                    ),
                  ]
              ),
            ),
      )
        );
  }

  /*late SelectionBehavior _selectionBehavior;

  String test = '';
  void initState(){
    _selectionBehavior = SelectionBehavior(enable: true,);
    test = '매도';
    print(test);
    super.initState();
    setState(() {
    });
  }
  Widget column_chart() {
    return Container(
      margin: EdgeInsets.all(5),
      width: double.infinity,
      height: 400,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), //모서리를 둥글게
          border: Border.all(color: Colors.black12, width: 3)), //테두리
      child: Container(
        height: 400.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            Container(
                width: 400.0,
                height: 400,
                child: Column(
                  children: [
                    Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
                        child: Row(children: [SizedBox(width: 30,height: 30,),Text("시가총액",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),)],)
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          child: Text("삼성전자"),
                        ),
                        Center(
                          child: Container(
                            width: 150.0,
                            height: 330,
                            child: SfCartesianChart(
                              plotAreaBorderWidth: 0,
                                enableAxisAnimation: true,
                                primaryXAxis: CategoryAxis(
                                  majorGridLines: MajorGridLines(width: 0),
                                    isVisible: false,
                                    //axisLine: AxisLine(width: 0),
                                    title: AxisTitle(
                                      text: '',
                                      textStyle: TextStyle(
                                        color: Colors.deepOrange,
                                        fontFamily: 'Roboto',
                                        fontSize: 16,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    )
                                ),
                                primaryYAxis: NumericAxis(
                                  isVisible: false,
                                ),
                                series: <CartesianSeries>[
                                  ColumnSeries<SalesData, String>(
                                      dataSource: [
                                        SalesData('삼성전자', 100,Color.fromRGBO(051,153,255,1)),
                                        SalesData('업종 평균', 50,Color.fromRGBO(100,100,100,1)),
                                      ],
                                      xValueMapper: (SalesData data, _) => data.year,
                                      yValueMapper: (SalesData data, _) => data.sales,
                                    pointColorMapper:(SalesData data,  _) => data.color,
                                  ),
                                ]
                            ),
                          ),
                        ),
                        Container(
                          child: Text("업종평균"),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                  ],
                )
            ),
            Container(
                width: 400.0,
                height: 400,
                child: Column(
                  children: [
                    Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
                        child: Row(children: [SizedBox(width: 30,height: 30,),Text("배당 수익률",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),)],)
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          child: Text("삼성전자"),
                        ),
                        Center(
                          child: Container(
                            width: 150.0,
                            height: 330,
                            child: SfCartesianChart(
                                plotAreaBorderWidth: 0,
                                enableAxisAnimation: true,
                                primaryXAxis: CategoryAxis(
                                    majorGridLines: MajorGridLines(width: 0),
                                    isVisible: false,
                                    //axisLine: AxisLine(width: 0),
                                    title: AxisTitle(
                                      text: '',
                                      textStyle: TextStyle(
                                        color: Colors.deepOrange,
                                        fontFamily: 'Roboto',
                                        fontSize: 16,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    )
                                ),
                                primaryYAxis: NumericAxis(
                                  isVisible: false,
                                ),
                                series: <CartesianSeries>[
                                  ColumnSeries<SalesData, String>(
                                    dataSource: [
                                      SalesData('삼성전자', 100,Color.fromRGBO(051,153,255,1)),
                                      SalesData('업종 평균', 50,Color.fromRGBO(100,100,100,1)),
                                    ],
                                    xValueMapper: (SalesData data, _) => data.year,
                                    yValueMapper: (SalesData data, _) => data.sales,
                                    pointColorMapper:(SalesData data,  _) => data.color,
                                  ),
                                ]
                            ),
                          ),
                        ),
                        Container(
                          child: Text("업종평균"),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                  ],
                )
            ),
            Container(
                width: 400.0,
                height: 400,
                child: Column(
                  children: [
                    Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
                        child: Row(children: [SizedBox(width: 30,height: 30,),Text("매출액 성장률",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),)],)
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          child: Text("삼성전자"),
                        ),
                        Center(
                          child: Container(
                            width: 150.0,
                            height: 330,
                            child: SfCartesianChart(
                                plotAreaBorderWidth: 0,
                                enableAxisAnimation: true,
                                primaryXAxis: CategoryAxis(
                                    majorGridLines: MajorGridLines(width: 0),
                                    isVisible: false,
                                    //axisLine: AxisLine(width: 0),
                                    title: AxisTitle(
                                      text: '',
                                      textStyle: TextStyle(
                                        color: Colors.deepOrange,
                                        fontFamily: 'Roboto',
                                        fontSize: 16,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    )
                                ),
                                primaryYAxis: NumericAxis(
                                  isVisible: false,
                                ),
                                series: <CartesianSeries>[
                                  ColumnSeries<SalesData, String>(
                                    dataSource: [
                                      SalesData('삼성전자', 100,Color.fromRGBO(051,153,255,1)),
                                      SalesData('업종 평균', 50,Color.fromRGBO(100,100,100,1)),
                                    ],
                                    xValueMapper: (SalesData data, _) => data.year,
                                    yValueMapper: (SalesData data, _) => data.sales,
                                    pointColorMapper:(SalesData data,  _) => data.color,
                                  ),
                                ]
                            ),
                          ),
                        ),
                        Container(
                          child: Text("업종평균"),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                  ],
                )
            ),
            Container(
                width: 400.0,
                height: 400,
                child: Column(
                  children: [
                    Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
                        child: Row(children: [SizedBox(width: 30,height: 30,),Text("영업 이익률",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),)],)
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          child: Text("삼성전자"),
                        ),
                        Center(
                          child: Container(
                            width: 150.0,
                            height: 330,
                            child: SfCartesianChart(
                                plotAreaBorderWidth: 0,
                                enableAxisAnimation: true,
                                primaryXAxis: CategoryAxis(
                                    majorGridLines: MajorGridLines(width: 0),
                                    isVisible: false,
                                    //axisLine: AxisLine(width: 0),
                                    title: AxisTitle(
                                      text: '',
                                      textStyle: TextStyle(
                                        color: Colors.deepOrange,
                                        fontFamily: 'Roboto',
                                        fontSize: 16,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    )
                                ),
                                primaryYAxis: NumericAxis(
                                  isVisible: false,
                                ),
                                series: <CartesianSeries>[
                                  ColumnSeries<SalesData, String>(
                                    dataSource: [
                                      SalesData('삼성전자', 100,Color.fromRGBO(051,153,255,1)),
                                      SalesData('업종 평균', 50,Color.fromRGBO(100,100,100,1)),
                                    ],
                                    xValueMapper: (SalesData data, _) => data.year,
                                    yValueMapper: (SalesData data, _) => data.sales,
                                    pointColorMapper:(SalesData data,  _) => data.color,
                                  ),
                                ]
                            ),
                          ),
                        ),
                        Container(
                          child: Text("업종평균"),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                  ],
                )
            ),
            Container(
                width: 400.0,
                height: 400,
                child: Column(
                  children: [
                    Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
                        child: Row(children: [SizedBox(width: 30,height: 30,),Text("PER",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),)],)
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          child: Text("삼성전자"),
                        ),
                        Center(
                          child: Container(
                            width: 150.0,
                            height: 330,
                            child: SfCartesianChart(
                                plotAreaBorderWidth: 0,
                                enableAxisAnimation: true,
                                primaryXAxis: CategoryAxis(
                                    majorGridLines: MajorGridLines(width: 0),
                                    isVisible: false,
                                    //axisLine: AxisLine(width: 0),
                                    title: AxisTitle(
                                      text: '',
                                      textStyle: TextStyle(
                                        color: Colors.deepOrange,
                                        fontFamily: 'Roboto',
                                        fontSize: 16,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    )
                                ),
                                primaryYAxis: NumericAxis(
                                  isVisible: false,
                                ),
                                series: <CartesianSeries>[
                                  ColumnSeries<SalesData, String>(
                                    dataSource: [
                                      SalesData('삼성전자', 100,Color.fromRGBO(051,153,255,1)),
                                      SalesData('업종 평균', 50,Color.fromRGBO(100,100,100,1)),
                                    ],
                                    xValueMapper: (SalesData data, _) => data.year,
                                    yValueMapper: (SalesData data, _) => data.sales,
                                    pointColorMapper:(SalesData data,  _) => data.color,
                                  ),
                                ]
                            ),
                          ),
                        ),
                        Container(
                          child: Text("업종평균"),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                  ],
                )
            ),
          ],
        ),
      ),
    );
  }
  Widget _report() {
    return Container(
        margin: EdgeInsets.all(5),
        width: double.infinity,
        height: 220,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), //모서리를 둥글게
            border: Border.all(color: Colors.black12, width: 3)), //테두리
        child: Column(
          children: [
            Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
                child: Row(children: [SizedBox(width: 30,height: 30,),Text("증권사 컨센서스",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),)],)
            ),
            Container(
                height: 100,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  SizedBox(width: 5,height: 30,),
                  Column(
                    children: [
                      SizedBox(width: 30,height: 10,),
                      Text("목표주가",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),),
                      Text("89,500",style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold,),),
                    ],
                  ),
                  Text("매수 3.95",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,),),
                    SizedBox(width: 5,height: 30,),
                ],
                )
            ),
            Container(
                padding: EdgeInsets.all(10),
                height: 60,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Container(
                    decoration: test == '강력매도'
                        ? BoxDecoration(color: Colors.amber,)
                        : BoxDecoration(color: Colors.grey,),
                    width: 80,
                    child: Center(
                      child: Text(
                        "강력매도",
                        style: TextStyle(
                          color: Colors.white
                        ),
                      ),
                    ),
                  ),
                    Container(
                      decoration: test == '매도'
                          ? BoxDecoration(color: Colors.amber,)
                          : BoxDecoration(color: Colors.grey,),
                      width: 50,
                      child: Center(
                        child: Text(
                          "매도",
                          style: TextStyle(
                              color: Colors.white
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: test == '보합'
                          ? BoxDecoration(color: Colors.amber,)
                          : BoxDecoration(color: Colors.grey,),
                      width: 50,
                      child: Center(
                        child: Text(
                          "보합",
                          style: TextStyle(
                              color: Colors.white
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: test == '매수'
                          ? BoxDecoration(color: Colors.amber,)
                          : BoxDecoration(color: Colors.grey,),
                      width: 50,
                      child: Center(
                        child: Text(
                          "매수",
                          style: TextStyle(
                              color: Colors.white
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: test == '강력매수'
                          ? BoxDecoration(color: Colors.amber,)
                          : BoxDecoration(color: Colors.grey,),
                      width: 80,
                      child: Center(
                        child: Text(
                          "강력매수",
                          style: TextStyle(
                              color: Colors.white
                          ),
                        ),
                      ),
                    ),
                ],)
            ),
          ],
        ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        column_chart(),
        _report(),
      ]),
    );
  }*/
  Future<void> refresh() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
    });
  }
}