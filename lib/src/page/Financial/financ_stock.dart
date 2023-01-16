import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:untitled/src/page/Financial/query.dart';

import 'financial.dart';

class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final int? y;
  final Color color;
}

class SalesData {
  SalesData(this.year, this.sales,this.color);

  final String year;
  final double?sales;
  final Color color;
}

class fin_stock extends StatefulWidget {
  const fin_stock({Key? key}) : super(key: key);

  @override
  _fin_stockState createState() => _fin_stockState();
}

class _fin_stockState extends State<fin_stock> with AutomaticKeepAliveClientMixin{
  late SelectionBehavior _selectionBehavior;

  Map? _industry_average = {};
  Map? _consensus = {};
  late List<dynamic> _tech=[];
  List<dynamic> _moving=[];

  FinancialState fb = FinancialState();
  String searchText = '';
  String test = '';
  fin_Query query = fin_Query();
  bool isLoading = false;

  Future<Map> industry_average(String stock) async{
    String url = "http://kmuproject.kro.kr:5568/industry/${stock}";
    String Changed_String1 = url.replaceAll(' ', '!');
    var response1= await http.get(Uri.parse(Changed_String1));

    var responseBody1 = response1.body;

    Map result = json.decode(response1.body);

    print("result: ${result}");
    return result;
  }

  Future <Map> consensus(String stock) async{
    String url = "http://kmuproject.kro.kr:5568/consensus/${stock}";
    String Changed_String1 = url.replaceAll(' ', '!');
    var response1= await http.get(Uri.parse(Changed_String1));

    var responseBody1 = response1.body;

    Map result = json.decode(response1.body);

    print("responseBody: ${responseBody1}");
    return result;
  }

  Future<List<dynamic>> tech(String stock) async{
    String url = "http://kmuproject.kro.kr:5568/tech/${stock}";
    String Changed_String1 = url.replaceAll(' ', '!');
    var response1= await http.get(Uri.parse(Changed_String1)).timeout(const Duration(seconds: 50));

    var responseBody1 = response1.body;
    print("responseBody: ${responseBody1}");

    List<dynamic> result = json.decode(response1.body);
    return result;
  }

  Future<List<dynamic>> moving(String stock) async{
    String url = "http://kmuproject.kro.kr:5568/moving/${stock}";
    String Changed_String1 = url.replaceAll(' ', '!');
    var response1= await http.get(Uri.parse(Changed_String1));

    var responseBody1 = response1.body;

    List<dynamic> result = json.decode(response1.body);

    print("responseBody: ${responseBody1}");
    return result;
  }

  void initState(){
   // _selectionBehavior = SelectionBehavior(enable: true,);
    setState(() {
      isLoading = true;
    });

    Future.microtask(() async{
      searchText = fb.name;
      Future<String> Stock_Code;
      Stock_Code = query.Find_Stock_Code(searchText);
      await Stock_Code.then((val) async {
        //industry_average(val);
        _industry_average = await industry_average(val);
        _consensus = await consensus(val);
        _tech = await tech(val);
        _moving = await moving(val);

        setState(() {});
      });
      if(!_moving.isEmpty){
        setState(() {
          super.setState(() {
            isLoading = false;
          });
        });
      }
      });

/*    Future.delayed(Duration(seconds:25), () {
      setState(() {
        super.setState(() {
          isLoading = false;
        });
      });
    });*/
    super.initState();
    setState(() {
    });
  }
  Widget column_chart() {
    return Card(
      shape: RoundedRectangleBorder(  //모서리를 둥글게 하기 위해 사용
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Container(
        margin: EdgeInsets.all(5),
        width: double.infinity,
        height: 400,
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
                            child: Column(
                              children: [
                                Text(fb.name),
                                Text("${_industry_average!["capital"]}억",style: TextStyle(fontSize: 15,color: (double.parse(_industry_average!["capital"]) > double.parse(_industry_average!["capital_average"])) ? Color.fromRGBO(204,80,80,1) : Color.fromRGBO(000,180,204,1)),),
                              ],
                            ),
                          ),
                          Center(
                            child: Container(
                              width: 150.0,
                              height: 270,
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
                                        SalesData(fb.name, _industry_average!.isNotEmpty ? double.parse(_industry_average!["capital"]) : 0, (double.parse(_industry_average!["capital"]) > double.parse(_industry_average!["capital_average"])) ? Color.fromRGBO(204,80,80,1) : Color.fromRGBO(000,180,204,1)),
                                        SalesData('업종 평균', _industry_average!.isNotEmpty ? double.parse(_industry_average!["capital_average"]) : 0,Color.fromRGBO(204,204,204,1)),
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
                            child: Column(
                              children: [
                                Text("업종평균"),
                                Text("${_industry_average!["capital_average"]}억",style: TextStyle(fontSize: 15, color: Color.fromRGBO(204,204,204,1)),),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                        ],
                      ),
                      Text(_industry_average!.isNotEmpty ? _industry_average!["capital_comment"] : ''),
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
                            child: Column(
                              children: [
                                Text(fb.name),
                                Text("${_industry_average!["dividend"]}%",style: TextStyle(fontSize: 30,color: (double.parse(_industry_average!["dividend"]) > double.parse(_industry_average!["dividend_average"])) ? Color.fromRGBO(204,80,80,1) : Color.fromRGBO(000,180,204,1)),),
                              ],
                            ),
                          ),
                          Center(
                            child: Container(
                              width: 150.0,
                              height: 270,
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
                                        SalesData(fb.name, _industry_average!.isNotEmpty ? double.parse(_industry_average!["dividend"]) : 0, (double.parse(_industry_average!["dividend"]) > double.parse(_industry_average!["dividend_average"])) ? Color.fromRGBO(204,80,80,1) : Color.fromRGBO(000,180,204,1)),
                                        SalesData('업종 평균', _industry_average!.isNotEmpty ? double.parse(_industry_average!["dividend_average"]) : 0,Color.fromRGBO(204,204,204,1)),
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
                            child: Column(
                              children: [
                                Text("업종평균"),
                                Text("${_industry_average!["dividend_average"]}%",style: TextStyle(fontSize: 30, color: Color.fromRGBO(204,204,204,1)),),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                        ],
                      ),
                      Text(_industry_average!.isNotEmpty ? _industry_average!["dividend_comment"] : ''),
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
                            child: Column(
                              children: [
                                Text(fb.name),
                                Text("${_industry_average!["growth"]}%",style: TextStyle(fontSize: 30,color: (double.parse(_industry_average!["growth"]) > double.parse(_industry_average!["growth_average"])) ? Color.fromRGBO(204,80,80,1) : Color.fromRGBO(000,180,204,1)),),
                              ],
                            ),
                          ),
                          Center(
                            child: Container(
                              width: 150.0,
                              height: 270,
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
                                        SalesData(fb.name, _industry_average!.isNotEmpty ?double.parse(_industry_average!["growth"]) : 0, (double.parse(_industry_average!["growth"]) > double.parse(_industry_average!["growth_average"])) ? Color.fromRGBO(204,80,80,1) : Color.fromRGBO(000,180,204,1)),
                                        SalesData('업종 평균', _industry_average!.isNotEmpty ?double.parse(_industry_average!["growth_average"]) : 0,Color.fromRGBO(204,204,204,1)),
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
                            child: Column(
                              children: [
                                Text("업종평균"),
                                Text("${_industry_average!["growth_average"]}%",style: TextStyle(fontSize: 30, color: Color.fromRGBO(204,204,204,1)),),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                        ],
                      ),
                      Text(_industry_average!.isNotEmpty ? _industry_average!["growth_comment"] : ''),
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
                            child: Column(
                              children: [
                                Text(fb.name),
                                Text("${_industry_average!["profit"]}%",style: TextStyle(fontSize: 30,color: (double.parse(_industry_average!["profit"]) > double.parse(_industry_average!["profit_average"])) ? Color.fromRGBO(204,80,80,1) : Color.fromRGBO(000,180,204,1)),),
                              ],
                            ),
                          ),
                          Center(
                            child: Container(
                              width: 150.0,
                              height: 270,
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
                                        SalesData(fb.name, _industry_average!.isNotEmpty ? double.parse(_industry_average!["profit"]) : 0,(double.parse(_industry_average!["profit"]) > double.parse(_industry_average!["profit_average"])) ? Color.fromRGBO(204,80,80,1) : Color.fromRGBO(000,180,204,1)),
                                        SalesData('업종 평균', _industry_average!.isNotEmpty ?double.parse(_industry_average!["profit_average"]) : 0,Color.fromRGBO(204,204,204,1)),
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
                            child: Column(
                              children: [
                                Text("업종평균"),
                                Text("${_industry_average!["profit_average"]}%",style: TextStyle(fontSize: 30, color: Color.fromRGBO(204,204,204,1)),),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                        ],
                      ),
                      Text(_industry_average!.isNotEmpty ? _industry_average!["profit_comment"] : ''),
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
                            child: Column(
                              children: [
                                Text(fb.name),
                                Text("${_industry_average!["per"]}배",style: TextStyle(fontSize: 30,color: (double.parse(_industry_average!["per"]) > double.parse(_industry_average!["per_average"])) ? Color.fromRGBO(204,80,80,1) : Color.fromRGBO(000,180,204,1)),),
                              ],
                            ),
                          ),
                          Center(
                            child: Container(
                              width: 150.0,
                              height: 270,
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
                                        SalesData(fb.name,_industry_average!.isNotEmpty ?double.parse(_industry_average!["per"]) : 0,(double.parse(_industry_average!["per"]) > double.parse(_industry_average!["per_average"])) ? Color.fromRGBO(204,80,80,1) : Color.fromRGBO(000,180,204,1)),
                                        SalesData('업종 평균', _industry_average!.isNotEmpty ? double.parse(_industry_average!["per_average"]): 0,Color.fromRGBO(204,204,204,1)),
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
                            child: Column(
                              children: [
                                Text("업종평균"),
                                Text("${_industry_average!["per_average"]}배",style: TextStyle(fontSize: 30, color: Color.fromRGBO(204,204,204,1)),),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                        ],
                      ),
                      Text(_industry_average!.isNotEmpty ? _industry_average!["per_comment"] :''),
                    ],
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _report() {
    return Card(
      shape: RoundedRectangleBorder(  //모서리를 둥글게 하기 위해 사용
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Container(
        margin: EdgeInsets.all(5),
        width: double.infinity,
        height: 220,
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
                        Text(_consensus!.isNotEmpty ? _consensus!["targetPrice"].toString() : '',style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold,),),
                      ],
                    ),
                    Text(_consensus!.isNotEmpty ? _consensus!["action"] : '',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,),),
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
                      decoration: _consensus!["action"] == '강력매도'
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
                      decoration: _consensus!["action"] == '매도'
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
                      decoration: _consensus!["action"] == '보합'
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
                      decoration: _consensus!["action"] == '매수'
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
                      decoration: _consensus!["action"] == '강력매수'
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
      ),
    );
  }

  Widget technical_indicators() {
    return Card(
      shape: RoundedRectangleBorder(
        //모서리를 둥글게 하기 위해 사용
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 4,
      child: Container(
        margin: EdgeInsets.all(5),
        width: double.infinity,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 50,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Row(children: [
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "기술적 지표",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ]),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              child: DataTable(
                horizontalMargin: 20.0,
                columnSpacing: 80.0,
                columns: <DataColumn>[
                  DataColumn(
                    label: Text(
                      '종목',
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      '수치',
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      '거래',
                    ),
                  ),
                ],
                rows: <DataRow>[
                  DataRow(
                    cells: <DataCell>[
                      DataCell(
                        Text(_tech.isNotEmpty ? _tech[0]['name'] : ''),
                      ),
                      DataCell(Text(_tech.isNotEmpty ? _tech[0]['value'] : '',)),
                      DataCell(Column(mainAxisSize: MainAxisSize.min,
                        children: [
                          if(_tech[0]['action']=="매수") ...[
                            Text(
                              _tech.isNotEmpty ? _tech[0]['action'] : '',
                              style: TextStyle(color: Colors.red),
                            ),
                          ]
                          else if (_tech[0]['action']=="매도") ...[
                            Text(
                              _tech.isNotEmpty ? _tech[0]['action'] : '',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ]
                          else...[
                              Text(
                                _tech.isNotEmpty ? _tech[0]['action'] : '',
                              ),
                            ],
                        ],
                      )),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(
                        Text(_tech.isNotEmpty ? _tech[1]['name'] : ''),
                      ),
                      DataCell(Text(_tech.isNotEmpty ? _tech[1]['value'] : '',)),
                      DataCell(Column(mainAxisSize: MainAxisSize.min,
                        children: [
                          if(_tech[1]['action']=="매수") ...[
                            Text(
                              _tech.isNotEmpty ? _tech[1]['action'] : '',
                              style: TextStyle(color: Colors.red),
                            ),
                          ]
                          else if (_tech[1]['action']=="매도") ...[
                            Text(
                              _tech.isNotEmpty ? _tech[1]['action'] : '',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ]
                          else...[
                              Text(
                                _tech.isNotEmpty ? _tech[1]['action'] : '',
                              ),
                            ],
                        ],
                      )),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(
                        Text(_tech.isNotEmpty ? _tech[2]['name'] : ''),
                      ),
                      DataCell(Text(_tech.isNotEmpty ? _tech[2]['value'] : '',)),
                      DataCell(Column(mainAxisSize: MainAxisSize.min,
                        children: [
                          if(_tech[2]['action']=="매수") ...[
                            Text(
                              _tech.isNotEmpty ? _tech[2]['action'] : '',
                              style: TextStyle(color: Colors.red),
                            ),
                          ]
                          else if (_tech[2]['action']=="매도") ...[
                            Text(
                              _tech.isNotEmpty ? _tech[2]['action'] : '',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ]
                          else...[
                              Text(
                                _tech.isNotEmpty ? _tech[2]['action'] : '',
                              ),
                            ],
                        ],
                      )),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(
                        Text(_tech.isNotEmpty ? _tech[3]['name'] : ''),
                      ),
                      DataCell(Text(_tech.isNotEmpty ? _tech[3]['value'] : '',)),
                      DataCell(Column(mainAxisSize: MainAxisSize.min,
                        children: [
                          if(_tech[3]['action']=="매수") ...[
                            Text(
                              _tech.isNotEmpty ? _tech[3]['action'] : '',
                              style: TextStyle(color: Colors.red),
                            ),
                          ]
                          else if (_tech[3]['action']=="매도") ...[
                            Text(
                              _tech.isNotEmpty ? _tech[3]['action'] : '',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ]
                          else...[
                              Text(
                                _tech.isNotEmpty ? _tech[3]['action'] : '',
                              ),
                            ],
                        ],
                      )),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(
                        Text(_tech.isNotEmpty ? _tech[4]['name'] : ''),
                      ),
                      DataCell(Text(_tech.isNotEmpty ? _tech[4]['value'] : '',)),
                      DataCell(Column(mainAxisSize: MainAxisSize.min,
                        children: [
                          if(_tech[4]['action']=="매수") ...[
                            Text(
                              _tech.isNotEmpty ? _tech[4]['action'] : '',
                              style: TextStyle(color: Colors.red),
                            ),
                          ]
                          else if (_tech[4]['action']=="매도") ...[
                            Text(
                              _tech.isNotEmpty ? _tech[4]['action'] : '',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ]
                          else...[
                              Text(
                                _tech.isNotEmpty ? _tech[4]['action'] : '',
                              ),
                            ],
                        ],
                      )),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(
                        Text(_tech.isNotEmpty ? _tech[5]['name'] : ''),
                      ),
                      DataCell(Text(_tech.isNotEmpty ? _tech[5]['value'] : '',)),
                      DataCell(Column(mainAxisSize: MainAxisSize.min,
                        children: [
                          if(_tech[5]['action']=="매수") ...[
                            Text(
                              _tech.isNotEmpty ? _tech[5]['action'] : '',
                              style: TextStyle(color: Colors.red),
                            ),
                          ]
                          else if (_tech[5]['action']=="매도") ...[
                            Text(
                              _tech.isNotEmpty ? _tech[5]['action'] : '',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ]
                          else...[
                              Text(
                                _tech.isNotEmpty ? _tech[5]['action'] : '',
                              ),
                            ],
                        ],
                      )),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(
                        Text(_tech.isNotEmpty ? _tech[6]['name'] : ''),
                      ),
                      DataCell(Text(_tech.isNotEmpty ? _tech[6]['value'] : '',)),
                      DataCell(Column(mainAxisSize: MainAxisSize.min,
                        children: [
                          if(_tech[6]['action']=="매수") ...[
                            Text(
                              _tech.isNotEmpty ? _tech[6]['action'] : '',
                              style: TextStyle(color: Colors.red),
                            ),
                          ]
                          else if (_tech[6]['action']=="매도") ...[
                            Text(
                              _tech.isNotEmpty ? _tech[6]['action'] : '',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ]
                          else...[
                              Text(
                                _tech.isNotEmpty ? _tech[6]['action'] : '',
                              ),
                            ],
                        ],
                      )),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(
                        Text(_tech.isNotEmpty ? _tech[7]['name'] : ''),
                      ),
                      DataCell(Text(_tech.isNotEmpty ? _tech[7]['value'] : '',)),
                      DataCell(Column(mainAxisSize: MainAxisSize.min,
                        children: [
                          if(_tech[7]['action']=="매수") ...[
                            Text(
                              _tech.isNotEmpty ? _tech[7]['action'] : '',
                              style: TextStyle(color: Colors.red),
                            ),
                          ]
                          else if (_tech[7]['action']=="매도") ...[
                            Text(
                              _tech.isNotEmpty ? _tech[7]['action'] : '',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ]
                          else...[
                              Text(
                                _tech.isNotEmpty ? _tech[7]['action'] : '',
                              ),
                            ],
                        ],
                      )),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(
                        Text(_tech.isNotEmpty ? _tech[8]['name'] : ''),
                      ),
                      DataCell(Text(_tech.isNotEmpty ? _tech[8]['value'] : '',)),
                      DataCell(Column(mainAxisSize: MainAxisSize.min,
                        children: [
                          if(_tech[8]['action']=="매수") ...[
                            Text(
                              _tech.isNotEmpty ? _tech[8]['action'] : '',
                              style: TextStyle(color: Colors.red),
                            ),
                          ]
                          else if (_tech[8]['action']=="매도") ...[
                            Text(
                              _tech.isNotEmpty ? _tech[8]['action'] : '',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ]
                          else...[
                              Text(
                                _tech.isNotEmpty ? _tech[8]['action'] : '',
                              ),
                            ],
                        ],
                      )),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(
                        Text(_tech.isNotEmpty ? _tech[9]['name'] : ''),
                      ),
                      DataCell(Text(_tech.isNotEmpty ? _tech[9]['value'] : '',)),
                      DataCell(Column(mainAxisSize: MainAxisSize.min,
                        children: [
                          if(_tech[9]['action']=="매수") ...[
                            Text(
                              _tech.isNotEmpty ? _tech[9]['action'] : '',
                              style: TextStyle(color: Colors.red),
                            ),
                          ]
                          else if (_tech[9]['action']=="매도") ...[
                            Text(
                              _tech.isNotEmpty ? _tech[9]['action'] : '',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ]
                          else...[
                              Text(
                                _tech.isNotEmpty ? _tech[9]['action'] : '',
                              ),
                            ],
                        ],
                      )),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(
                        Text(_tech.isNotEmpty ? _tech[10]['name'] : ''),
                      ),
                      DataCell(Text(_tech.isNotEmpty ? _tech[10]['value'] : '',)),
                      DataCell(Column(mainAxisSize: MainAxisSize.min,
                        children: [
                          if(_tech[10]['action']=="매수") ...[
                            Text(
                              _tech.isNotEmpty ? _tech[10]['action'] : '',
                              style: TextStyle(color: Colors.red),
                            ),
                          ]
                          else if (_tech[10]['action']=="매도") ...[
                            Text(
                              _tech.isNotEmpty ? _tech[10]['action'] : '',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ]
                          else...[
                              Text(
                                _tech.isNotEmpty ? _tech[10]['action'] : '',
                              ),
                            ],
                        ],
                      )),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(
                        Text(_tech.isNotEmpty ? _tech[11]['name'] : ''),
                      ),
                      DataCell(Text(_tech.isNotEmpty ? _tech[11]['value'] : '',)),
                      DataCell(Column(mainAxisSize: MainAxisSize.min,
                        children: [
                          if(_tech[11]['action']=="매수") ...[
                            Text(
                              _tech.isNotEmpty ? _tech[11]['action'] : '',
                              style: TextStyle(color: Colors.red),
                            ),
                          ]
                          else if (_tech[11]['action']=="매도") ...[
                            Text(
                              _tech.isNotEmpty ? _tech[11]['action'] : '',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ]
                          else...[
                              Text(
                                _tech.isNotEmpty ? _tech[11]['action'] : '',
                              ),
                            ],
                        ],
                      )),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
              border: Border(
                  top : BorderSide(color: Get.isDarkMode ? Colors.white12 : Colors.black12, width: 1))), //테
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Row(children: [
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "매수:${_tech.isNotEmpty ? _tech[12]['매수'] : ''}  매도:${_tech.isNotEmpty ? _tech[12]['매도'] : ''}  중립:${_tech.isNotEmpty ? _tech[12]['중립'] : ''}\n 요약:${_tech.isNotEmpty ? _tech[12]['요약'] : ''}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget moving_average() {
    return Card(
      shape: RoundedRectangleBorder(
        //모서리를 둥글게 하기 위해 사용
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 4,
      child: Container(
        margin: EdgeInsets.all(5),
        width: double.infinity,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 50,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Row(children: [
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "이동평균",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ]),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              child: DataTable(
                horizontalMargin: 20.0,
                columnSpacing: 80.0,
                columns: <DataColumn>[
                  DataColumn(
                    label: Text(
                      '기간',
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      '단순 평균',
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      '지수 평균',
                    ),
                  ),
                ],
                rows: <DataRow>[
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text(_moving.isNotEmpty ? _moving[0]["period"] : '')),
                      DataCell(Column(mainAxisSize: MainAxisSize.min, children: [
                        (Text(_moving.isNotEmpty ? _moving[0]["simple"] : '')),
                        (Text(_moving.isNotEmpty ? _moving[0]["simple_action"] : '',style: _moving[0]["simple_action"] == "\ub9e4\uc218" ? TextStyle(color: Colors.red) : TextStyle(color: Colors.blue),)),
                      ])),
                      DataCell(Column(mainAxisSize: MainAxisSize.min, children: [
                        (Text(_moving.isNotEmpty ? _moving[0]["exponential"] : '')),
                        (Text(_moving.isNotEmpty ? _moving[0]["exponential_action"] : '',style: _moving[0]["exponential_action"] == "\ub9e4\uc218" ? TextStyle(color: Colors.red) : TextStyle(color: Colors.blue),)),
                      ])),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text(_moving.isNotEmpty ? _moving[1]["period"] : '')),
                      DataCell(Column(mainAxisSize: MainAxisSize.min, children: [
                        (Text(_moving.isNotEmpty ? _moving[1]["simple"] : '')),
                        (Text(_moving.isNotEmpty ? _moving[1]["simple_action"] : '',style: _moving[1]["simple_action"] == "\ub9e4\uc218" ? TextStyle(color: Colors.red) : TextStyle(color: Colors.blue),)),
                      ])),
                      DataCell(Column(mainAxisSize: MainAxisSize.min, children: [
                        (Text(_moving.isNotEmpty ? _moving[1]["exponential"] : '')),
                        (Text(_moving.isNotEmpty ? _moving[1]["exponential_action"] : '',style: _moving[1]["exponential_action"] == "\ub9e4\uc218" ? TextStyle(color: Colors.red) : TextStyle(color: Colors.blue),)),
                      ])),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text(_moving.isNotEmpty ? _moving[2]["period"] : '')),
                      DataCell(Column(mainAxisSize: MainAxisSize.min, children: [
                        (Text(_moving.isNotEmpty ? _moving[2]["simple"] : '')),
                        (Text(_moving.isNotEmpty ? _moving[2]["simple_action"] : '',style: _moving[2]["simple_action"] == "\ub9e4\uc218" ? TextStyle(color: Colors.red) : TextStyle(color: Colors.blue),)),
                      ])),
                      DataCell(Column(mainAxisSize: MainAxisSize.min, children: [
                        (Text(_moving.isNotEmpty ? _moving[2]["exponential"] : '')),
                        (Text(_moving.isNotEmpty ? _moving[2]["exponential_action"] : '',style: _moving[2]["exponential_action"] == "\ub9e4\uc218" ? TextStyle(color: Colors.red) : TextStyle(color: Colors.blue),)),
                      ])),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text(_moving.isNotEmpty ? _moving[3]["period"] : '')),
                      DataCell(Column(mainAxisSize: MainAxisSize.min, children: [
                        (Text(_moving.isNotEmpty ? _moving[3]["simple"] : '')),
                        (Text(_moving.isNotEmpty ? _moving[3]["simple_action"] : '',style: _moving[3]["simple_action"] == "\ub9e4\uc218" ? TextStyle(color: Colors.red) : TextStyle(color: Colors.blue),)),
                      ])),
                      DataCell(Column(mainAxisSize: MainAxisSize.min, children: [
                        (Text(_moving.isNotEmpty ? _moving[3]["exponential"] : '')),
                        (Text(_moving.isNotEmpty ? _moving[3]["exponential_action"] : '',style: _moving[3]["exponential_action"] == "\ub9e4\uc218" ? TextStyle(color: Colors.red) : TextStyle(color: Colors.blue),)),
                      ])),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text(_moving.isNotEmpty ? _moving[4]["period"] : '')),
                      DataCell(Column(mainAxisSize: MainAxisSize.min, children: [
                        (Text(_moving.isNotEmpty ? _moving[4]["simple"] : '')),
                        (Text(_moving.isNotEmpty ? _moving[4]["simple_action"] : '',style: _moving[4]["simple_action"] == "\ub9e4\uc218" ? TextStyle(color: Colors.red) : TextStyle(color: Colors.blue),)),
                      ])),
                      DataCell(Column(mainAxisSize: MainAxisSize.min, children: [
                        (Text(_moving.isNotEmpty ? _moving[4]["exponential"] : '')),
                        (Text(_moving.isNotEmpty ? _moving[4]["exponential_action"] : '',style: _moving[4]["exponential_action"] == "\ub9e4\uc218" ? TextStyle(color: Colors.red) : TextStyle(color: Colors.blue),)),
                      ])),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text(_moving.isNotEmpty ? _moving[5]["period"] : '')),
                      DataCell(Column(mainAxisSize: MainAxisSize.min, children: [
                        (Text(_moving.isNotEmpty ? _moving[5]["simple"] : '')),
                        (Text(_moving.isNotEmpty ? _moving[5]["simple_action"] : '',style: _moving[5]["simple_action"] == "\ub9e4\uc218" ? TextStyle(color: Colors.red) : TextStyle(color: Colors.blue),)),
                      ])),
                      DataCell(Column(mainAxisSize: MainAxisSize.min, children: [
                        (Text(_moving.isNotEmpty ? _moving[5]["exponential"] : '')),
                        (Text(_moving.isNotEmpty ? _moving[5]["exponential_action"] : '',style: _moving[5]["exponential_action"] == "\ub9e4\uc218" ? TextStyle(color: Colors.red) : TextStyle(color: Colors.blue),)),
                      ])),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border(
                      top : BorderSide(color: Get.isDarkMode ? Colors.white12 : Colors.black12, width: 1))), //테
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Row(children: [
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "매수:${_moving[6]["매수"]}  매도:${_moving[6]["매도"]}\n 요약:${_moving[6]["요약"]}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: Container(child: CircularProgressIndicator(),),)
        : ListView(
      children: [
        column_chart(),
        _consensus!["targetPrice"]!="NULL" && _consensus!["action"]!="NULL" ? _report() : Container(),
        _tech.isNotEmpty ? technical_indicators() : Container(),
        moving_average(),
      ],
    );
  }
  @override
// TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
