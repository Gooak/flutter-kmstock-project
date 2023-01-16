import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:untitled/src/page/Financial/search.dart';
import 'package:untitled/src/page/stockMain/tap/query_stock.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import 'package:untitled/src/page/homeMain/query_home.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../Financial/financial.dart';
//오늘, 어제날짜 구하기

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
class Internal extends StatefulWidget {
  @override
  Internal_main createState() => Internal_main();
}

class Internal_main extends State<Internal>{
  String strToday ='';
  String strYesterday='';
  void getToday() {
    DateTime now = DateTime.now();
    DateTime Yester = now.subtract(Duration(days:2));
    DateTime today = now.subtract(Duration(days:1));
    DateFormat formatter = DateFormat('yyyyMMdd');
    strToday = formatter.format(today);
    strYesterday = formatter.format(Yester);
    print(strToday);
    print(strYesterday);
/*  DateTime now = DateTime.now();
  DateTime strToday = DateTime(now.year, now.month, now.day + (5 - now.weekday));
  DateTime strYesterday = strToday.subtract(Duration(days:1));
  DateFormat formatter = DateFormat('yyyyMMdd');
  strToday = formatter.format(now);
  strYesterday = formatter.format(Yester);
  print(strYesterday);
  print(strToday);*/
  }
  Query_stock query = Query_stock();
  Query_home query1 = Query_home();
  void initState() {
    super.initState();
    getToday();
    //searchText = '동화약품';
    //Future<String> Stock_Code;
/*    Stock_Code = Find_Stock_Code(searchText);
    Stock_Code.then((val) {
      // 종목코드가 나오면 해당 값을 출력
      print('val: $val');*/
    Future.microtask(() async{
      String KOSPI_ascent_rate = "SELECT `종목명`,`등락율` from stock.db_"+strToday+" WHERE `시장구분`='KOSPI' OR `시장구분`='KOSPI200' order by `등락율` Desc limit 5;";
      String KOSPI_rate_of_decline = "SELECT `종목명`,`등락율` from stock.db_"+strToday+" WHERE `시장구분`='KOSPI' OR `시장구분`='KOSPI200' order by `등락율` Asc limit 5;";
      String KOSDAQ_ascent_rate = "SELECT `종목명`,`등락율` from stock.db_"+strToday+" WHERE `시장구분`='KOSDAQ' order by `등락율` Desc limit 5;";
      String KOSDAQ_rate_of_decline = "SELECT `종목명`,`등락율` from stock.db_"+strToday+" WHERE `시장구분`='KOSDAQ' order by `등락율` Asc limit 5;";
/*      String KOSPI_ascent_rate = "SELECT `종목명`,`등락율` from stock.db_20220523 WHERE `시장구분`='KOSPI' OR `시장구분`='KOSPI200' order by `등락율` Desc limit 5;";
      String KOSPI_rate_of_decline = "SELECT `종목명`,`등락율` from stock.db_20220523 WHERE `시장구분`='KOSPI' OR `시장구분`='KOSPI200' order by `등락율` Asc limit 5;";
      String KOSDAQ_ascent_rate = "SELECT `종목명`,`등락율` from stock.db_20220523 WHERE `시장구분`='KOSDAQ' order by `등락율` Desc limit 5;";
      String KOSDAQ_rate_of_decline = "SELECT `종목명`,`등락율` from stock.db_20220523 WHERE `시장구분`='KOSDAQ' order by `등락율` Asc limit 5;";*/
      //String new_high = "select * from stock.db_"+strYesterday+" inner join stock.db_"+strToday+" on stock.db_"+strYesterday+".종목명 = stock.db_"+strToday+".종목명 where stock.db_"+strYesterday+".`52주최고가` < stock.db_"+strToday+".`52주최고가` group by stock.db_"+strYesterday+".종목명 order by stock.db_"+strYesterday+".등락율 desc limit 5;";
      //String new_low = "select * from stock.db_"+strYesterday+" inner join stock.db_"+strToday+" on stock.db_"+strYesterday+".종목명 = stock.db_"+strToday+".종목명 where stock.db_"+strYesterday+".`52주최저가` > stock.db_"+strToday+".`52주최저가` group by stock.db_"+strYesterday+".종목명 order by stock.db_"+strYesterday+".등락율 desc limit 5;;";
      String kospi_kosdaq = "price";
      await query1.Find_Kospi_kosdaq(kospi_kosdaq);
      String KOSPI_new_high = "SELECT stock.db_"+strToday+".`종목명`, stock.db_"+strToday+".`등락율` FROM stock.db_"+strToday+" inner join stock.db_"+strYesterday+" on stock.db_"+strToday+".`종목명` = stock.db_"+strYesterday+".`종목명` where stock.db_"+strYesterday+".`52주최고가` < stock.db_"+strToday+".`52주최고가` AND stock.db_"+strToday+".`시장구분` IN('KOSPI','KOSPI200') order by stock.db_"+strToday+".`등락율` desc limit 5;";
      String KOSPI_new_low = "SELECT stock.db_"+strToday+".`종목명`, stock.db_"+strToday+".`등락율` FROM stock.db_"+strToday+" inner join stock.db_"+strYesterday+" on stock.db_"+strToday+".`종목명` = stock.db_"+strYesterday+".`종목명` where stock.db_"+strYesterday+".`52주최저가` > stock.db_"+strToday+".`52주최저가` AND stock.db_"+strToday+".`시장구분` IN('KOSPI','KOSPI200') order by stock.db_"+strToday+".`등락율` Asc limit 5";
      String KOSDAQ_new_high = "SELECT stock.db_"+strToday+".`종목명`, stock.db_"+strToday+".`등락율` FROM stock.db_"+strToday+" inner join stock.db_"+strYesterday+" on stock.db_"+strToday+".`종목명` = stock.db_"+strYesterday+".`종목명` where stock.db_"+strYesterday+".`52주최고가` < stock.db_"+strToday+".`52주최고가` AND stock.db_"+strToday+".`시장구분` IN('KOSDAQ') order by stock.db_"+strToday+".`등락율` desc limit 5;";
      String KOSDAQ_new_low = "SELECT stock.db_"+strToday+".`종목명`, stock.db_"+strToday+".`등락율` FROM stock.db_"+strToday+" inner join stock.db_"+strYesterday+" on stock.db_"+strToday+".`종목명` = stock.db_"+strYesterday+".`종목명` where stock.db_"+strYesterday+".`52주최저가` > stock.db_"+strToday+".`52주최저가` AND stock.db_"+strToday+".`시장구분` IN('KOSDAQ') order by stock.db_"+strToday+".`등락율` Asc limit 5";
      await query.Find_ascent_rate(KOSPI_ascent_rate, KOSPI_rate_of_decline, KOSDAQ_ascent_rate, KOSDAQ_rate_of_decline);
      await query.Find_low_high(KOSPI_new_high, KOSPI_new_low,KOSDAQ_new_high,KOSDAQ_new_low);
/*      setState(() {
        super.setState(() {
        });
      });*/
      });
    Future.delayed(Duration(seconds:2), () {
      setState(() {
        super.setState(() {
        });
      });
    });
/*    }).catchError((error) {
      // error가 해당 에러를 출력
      print('error: $error');
    });*/
  }
  String searchText = '';
  String Search_Stock_Code = '';
  String test1= '-20';
  String test2= '20';
/*  Future<String> Find_Stock_Code(String Stock_Name) async
  {
    Search_Stock_Code =
    "SELECT 종목코드 FROM stock.db_20211115 WHERE 종목명 = '${Stock_Name}';";
    String url = "http://kmuproject.kro.kr:5568/sql/${Search_Stock_Code}";
    String Changed_String = url.replaceAll(' ', '!');
    var response = await http.get(Changed_String);

    var statusCode = response.statusCode;
    var responseHeaders = response.headers;
    var responseBody = response.body;
    List<dynamic> list = jsonDecode(responseBody);

    *//* print("statusCode: ${statusCode}");
    print("responseHeaders: ${responseHeaders}");
    print("responseBody: ${responseBody}");*//*
    return list[0]['종목코드'];
  }*/

  Widget _Chart(){
    final List<Color> bluecolor = <Color>[];
    bluecolor.add(Colors.blue[50]!);
    bluecolor.add(Colors.blue[100]!);
    bluecolor.add(Colors.blue);

    final List<double> bluestops = <double>[];
    bluestops.add(0.0);
    bluestops.add(0.5);
    bluestops.add(1.0);

    final LinearGradient bluegradientColors =
    LinearGradient(colors: bluecolor, stops: bluestops,begin: Alignment.bottomCenter,
        end: Alignment.topCenter);

    final List<Color> redecolor = <Color>[];
    redecolor.add(Colors.red[50]!);
    redecolor.add(Colors.red[100]!);
    redecolor.add(Colors.red);

    final List<double> redstops = <double>[];
    redstops.add(0.0);
    redstops.add(0.5);
    redstops.add(1.0);

    final LinearGradient redgradientColors =
    LinearGradient(colors: redecolor, stops: redstops,begin: Alignment.bottomCenter,
        end: Alignment.topCenter);

    return Card(
      shape: RoundedRectangleBorder(  //모서리를 둥글게 하기 위해 사용
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 4,
      child: Container(
        margin: EdgeInsets.all(5),
        width: double.infinity,
        height: 100, //테두리
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Center(
                    child: Container(
                      width: 170,
                      height: 70,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("KOSPI ",style: TextStyle(fontWeight: FontWeight.bold),),
                          Text(query1.Kospi1,style: TextStyle(fontSize: 20),),
                          Text(query1.Kospi2,style: query1.Kospi2.contains('-')
                              ? TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)
                              : TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
/*                      Expanded(child:
                          Center(
                            child: Container(
                              width: 170,
                              height: 100,
                              child: Center(
                                  child: SfCartesianChart(
                                      plotAreaBorderWidth: 0,
                                      enableAxisAnimation: true,
                                    // Initialize category axis
                                      primaryXAxis: CategoryAxis(
                                        isVisible: false,
                                        majorGridLines: MajorGridLines(width: 0),
                                      ),
                                      primaryYAxis: NumericAxis(
                                        isVisible: false,
                                      ),
                                      series: <ChartSeries>[
                                        AreaSeries<SalesData, String>(
                                          // Bind data source
                                            dataSource: <SalesData>[
                                              SalesData('60분', 35),
                                              SalesData('45분', 28),
                                              SalesData('15분', 32),
                                              SalesData('30분', 34),
                                              SalesData('1분', 20)
                                            ],
                                            borderColor: test1.contains('-')
                                                        ? Colors.blue
                                                        : Colors.red,
                                            borderWidth: 2,
                                            xValueMapper: (SalesData sales, _) => sales.year,
                                            yValueMapper: (SalesData sales, _) => sales.sales,
                                            gradient: test1.contains('-')
                                                      ? bluegradientColors
                                                      : redgradientColors
                                        )
                                      ]
                                  )
                              )
                            )
                          ),
                          ),*/
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Container(
                      width: 170,
                      height: 70,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("KOSDAQ ",style: TextStyle(fontWeight: FontWeight.bold),),
                          Text(query1.Kospdaq1,style: TextStyle(fontSize: 20),),
                          Text(query1.Kospdaq2,style: query1.Kospdaq2.contains('-')
                              ? TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)
                              : TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                         /* Expanded(child:
                          Center(
                              child: Container(
                                  width: 170,
                                  height: 100,
                                  child: Center(
                                      child: SfCartesianChart(
                                          plotAreaBorderWidth: 0,
                                          enableAxisAnimation: true,
                                        // Initialize category axis
                                          primaryXAxis: CategoryAxis(
                                            isVisible: false,
                                            majorGridLines: MajorGridLines(width: 0),
                                          ),
                                          primaryYAxis: NumericAxis(
                                            isVisible: false,
                                          ),
                                          series: <ChartSeries>[
                                            AreaSeries<SalesData, String>(
                                              // Bind data source
                                                dataSource: <SalesData>[
                                                  SalesData('60분', 35),
                                                  SalesData('45분', 28),
                                                  SalesData('15분', 32),
                                                  SalesData('30분', 34),
                                                  SalesData('1분', 60)
                                                ],
                                                borderColor: test2.contains('-')
                                                    ? Colors.blue
                                                    : Colors.red,
                                                borderWidth: 2,
                                                xValueMapper: (SalesData sales, _) => sales.year,
                                                yValueMapper: (SalesData sales, _) => sales.sales,
                                                gradient: test2.contains('-')
                                                    ? bluegradientColors
                                                    : redgradientColors
                                            )
                                          ]
                                      )
                                  )
                              )
                          ),
                          ),*/
                        ],
                      ),
                    ),
                  ),),
              ],
            ),
          ],
        ),),
    );
  }
  Widget _Risemain(){
    return Container(
      width: double.infinity,
      height: 50,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Row(children: [
              SizedBox(width: 10,),
              Text(
                "상승률",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ]),
          ),
        ],
      ),
    );
  }
  Widget _Rise(){
    return Card(
      shape: RoundedRectangleBorder(  //모서리를 둥글게 하기 위해 사용
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 4,
      child: Column(
        children:[
          SizedBox(height: 10,),
      Row(children: [
      SizedBox(width: 10,),
        Text(
          "상승률",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        ]),
          Container(
            height: 300,
            margin: EdgeInsets.all(5),
            child: Row(
              children: [
                Expanded(child:
                DataTable(
                  horizontalMargin: 10.0,
                  columnSpacing: 35.0,
                  columns: <DataColumn>[
                    DataColumn(
                      label: Text(
                        '코스피',
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        '등락률',
                      ),
                    ),
                  ],
                  rows: <DataRow>[
                    DataRow(
                      cells: <DataCell>[
                        DataCell(GestureDetector(
                          onTap: (){
                            query.ascent_rate1==''
                                ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Row(children: [const Icon(Icons.clear, color: Colors.white,), const SizedBox(width: 20,), Expanded(child: Text('에러!', style: TextStyle(fontSize: 18),),),],),))
                                : Get.to(() => Financial(), arguments: query.ascent_rate1.toString());
                          },
                          child: Text(query.ascent_rate1,),
                        )),
                        DataCell(Text(query.ascent_rate6+"%",style: TextStyle(color: Colors.red),)),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(GestureDetector(
                          onTap: (){
                            query.ascent_rate2==''
                                ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Row(children: [const Icon(Icons.clear, color: Colors.white,), const SizedBox(width: 20,), Expanded(child: Text('에러!', style: TextStyle(fontSize: 18),),),],),))
                                : Get.to(() => Financial(), arguments: query.ascent_rate2.toString());
                          },
                          child: Text(query.ascent_rate2),
                        )),
                        DataCell(Text(query.ascent_rate7+"%",style: TextStyle(color: Colors.red),)),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(GestureDetector(
                          onTap: (){
                            query.ascent_rate3==''
                                ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Row(children: [const Icon(Icons.clear, color: Colors.white,), const SizedBox(width: 20,), Expanded(child: Text('에러!', style: TextStyle(fontSize: 18),),),],),))
                                : Get.to(() => Financial(), arguments: query.ascent_rate3.toString());
                          },
                          child: Text(query.ascent_rate3),
                        )),
                        DataCell(Text(query.ascent_rate8+"%",style: TextStyle(color: Colors.red),)),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(GestureDetector(
                          onTap: (){
                            query.ascent_rate4==''
                                ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Row(children: [const Icon(Icons.clear, color: Colors.white,), const SizedBox(width: 20,), Expanded(child: Text('에러!', style: TextStyle(fontSize: 18),),),],),))
                                : Get.to(() => Financial(), arguments: query.ascent_rate4.toString());
                          },
                          child: Text(query.ascent_rate4),
                        )),
                        DataCell(Text(query.ascent_rate9+"%",style: TextStyle(color: Colors.red),)),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(GestureDetector(
                          onTap: (){
                            query.ascent_rate5==''
                                ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Row(children: [const Icon(Icons.clear, color: Colors.white,), const SizedBox(width: 20,), Expanded(child: Text('에러!', style: TextStyle(fontSize: 18),),),],),))
                                : Get.to(() => Financial(), arguments: query.ascent_rate5.toString());
                          },
                          child: Text(query.ascent_rate5),
                        )),
                        DataCell(Text(query.ascent_rate10+"%".toString(),style: TextStyle(color: Colors.red),)),
                      ],
                    ),
                  ],
                ),
                ),
                Expanded(child:
                DataTable(
                  horizontalMargin: 10.0,
                  columnSpacing: 35.0,
                  columns: const <DataColumn>[
                    DataColumn(
                      label: Text(
                        '코스닥',
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        '등락률',
                      ),
                    ),
                  ],
                  rows:  <DataRow>[
                    DataRow(
                      cells: <DataCell>[
                        DataCell(GestureDetector(
                          onTap: (){
                            query.KOSDAQ_ascent_rate1==''
                                ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Row(children: [const Icon(Icons.clear, color: Colors.white,), const SizedBox(width: 20,), Expanded(child: Text('에러!', style: TextStyle(fontSize: 18),),),],),))
                                : Get.to(() => Financial(), arguments: query.KOSDAQ_ascent_rate1.toString());
                          },
                          child: Text(query.KOSDAQ_ascent_rate1),
                        )),
                        DataCell(Text(query.KOSDAQ_ascent_rate6+"%",style: TextStyle(color: Colors.red),)),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(GestureDetector(
                          onTap: (){
                            query.KOSDAQ_ascent_rate2==''
                                ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Row(children: [const Icon(Icons.clear, color: Colors.white,), const SizedBox(width: 20,), Expanded(child: Text('에러!', style: TextStyle(fontSize: 18),),),],),))
                                : Get.to(() => Financial(), arguments: query.KOSDAQ_ascent_rate2.toString());
                          },
                          child: Text(query.KOSDAQ_ascent_rate2),
                        )),
                        DataCell(Text(query.KOSDAQ_ascent_rate7+"%",style: TextStyle(color: Colors.red),)),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(GestureDetector(
                          onTap: (){
                            query.KOSDAQ_ascent_rate3==''
                                ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Row(children: [const Icon(Icons.clear, color: Colors.white,), const SizedBox(width: 20,), Expanded(child: Text('에러!', style: TextStyle(fontSize: 18),),),],),))
                                : Get.to(() => Financial(), arguments: query.KOSDAQ_ascent_rate3.toString());
                          },
                          child: Text(query.KOSDAQ_ascent_rate3),
                        )),
                        DataCell(Text(query.KOSDAQ_ascent_rate8+"%",style: TextStyle(color: Colors.red),)),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(GestureDetector(
                          onTap: (){
                            query.KOSDAQ_ascent_rate4==''
                                ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Row(children: [const Icon(Icons.clear, color: Colors.white,), const SizedBox(width: 20,), Expanded(child: Text('에러!', style: TextStyle(fontSize: 18),),),],),))
                                : Get.to(() => Financial(), arguments: query.KOSDAQ_ascent_rate4.toString());
                          },
                          child: Text(query.KOSDAQ_ascent_rate4),
                        )),
                        DataCell(Text(query.KOSDAQ_ascent_rate9+"%",style: TextStyle(color: Colors.red),)),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(GestureDetector(
                          onTap: (){
                            query.KOSDAQ_ascent_rate5==''
                                ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Row(children: [const Icon(Icons.clear, color: Colors.white,), const SizedBox(width: 20,), Expanded(child: Text('에러!', style: TextStyle(fontSize: 18),),),],),))
                                : Get.to(() => Financial(), arguments: query.KOSDAQ_ascent_rate5.toString());
                          },
                          child: Text(query.KOSDAQ_ascent_rate5),
                        )),
                        DataCell(Text(query.KOSDAQ_ascent_rate10+"%".toString(),style: TextStyle(color: Colors.red),)),
                      ],
                    ),
                  ],
                ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _Dropmain(){
    return Container(
      width: double.infinity,
      height: 50,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Row(children: [
              SizedBox(width: 10,),
              Text(
                "하락률",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ]),
          ),
        ],
      ),
    );
  }
  Widget _Drop(){
    return Card(
      shape: RoundedRectangleBorder(  //모서리를 둥글게 하기 위해 사용
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 4,
      child: Column(
        children: [
          SizedBox(height: 10,),
          Row(children: [
            SizedBox(width: 10,),
            Text(
              "하락률",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ]),
          Container(
            height: 300,
            margin: EdgeInsets.all(5),
            child: Row(
              children: [
                Expanded(child:
                DataTable(
                  horizontalMargin: 10.0,
                  columnSpacing: 30.0,
                  columns: const <DataColumn>[
                    DataColumn(
                      label: Text(
                        '코스피',
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        '등락률',
                      ),
                    ),
                  ],
                  rows:  <DataRow>[
                    DataRow(
                      cells: <DataCell>[
                        DataCell(GestureDetector(
                          onTap: (){
                            query.rate_of_decline1==''
                                ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Row(children: [const Icon(Icons.clear, color: Colors.white,), const SizedBox(width: 20,), Expanded(child: Text('에러!', style: TextStyle(fontSize: 18),),),],),))
                                : Get.to(() => Financial(), arguments: query.rate_of_decline1.toString());
                          },
                          child: Text(query.rate_of_decline1),
                        )),
                        DataCell(Text(query.rate_of_decline6+"%",style: TextStyle(color: Colors.blue),)),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(GestureDetector(
                          onTap: (){
                            query.rate_of_decline2==''
                                ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Row(children: [const Icon(Icons.clear, color: Colors.white,), const SizedBox(width: 20,), Expanded(child: Text('에러!', style: TextStyle(fontSize: 18),),),],),))
                                : Get.to(() => Financial(), arguments: query.rate_of_decline2.toString());
                          },
                          child: Text(query.rate_of_decline2),
                        )),
                        DataCell(Text(query.rate_of_decline7+"%",style: TextStyle(color: Colors.blue),)),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(GestureDetector(
                          onTap: (){
                            query.rate_of_decline3==''
                                ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Row(children: [const Icon(Icons.clear, color: Colors.white,), const SizedBox(width: 20,), Expanded(child: Text('에러!', style: TextStyle(fontSize: 18),),),],),))
                                : Get.to(() => Financial(), arguments: query.rate_of_decline3.toString());
                          },
                          child: Text(query.rate_of_decline3),
                        )),
                        DataCell(Text(query.rate_of_decline8+"%",style: TextStyle(color: Colors.blue),)),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(GestureDetector(
                          onTap: (){
                            query.rate_of_decline4==''
                                ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Row(children: [const Icon(Icons.clear, color: Colors.white,), const SizedBox(width: 20,), Expanded(child: Text('에러!', style: TextStyle(fontSize: 18),),),],),))
                                : Get.to(() => Financial(), arguments: query.rate_of_decline4.toString());
                          },
                          child: Text(query.rate_of_decline4),
                        )),
                        DataCell(Text(query.rate_of_decline9+"%",style: TextStyle(color: Colors.blue),)),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(GestureDetector(
                          onTap: (){
                            query.rate_of_decline5==''
                                ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Row(children: [const Icon(Icons.clear, color: Colors.white,), const SizedBox(width: 20,), Expanded(child: Text('에러!', style: TextStyle(fontSize: 18),),),],),))
                                : Get.to(() => Financial(), arguments: query.rate_of_decline5.toString());
                          },
                          child: Text(query.rate_of_decline5),
                        )),
                        DataCell(Text(query.rate_of_decline10+"%",style: TextStyle(color: Colors.blue),)),
                      ],
                    ),
                  ],
                ),
                ),
                Expanded(child:
                DataTable(
                  horizontalMargin: 10.0,
                  columnSpacing: 30.0,
                  columns: const <DataColumn>[
                    DataColumn(
                      label: Text(
                        '코스닥',
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        '등락률',
                      ),
                    ),
                  ],
                  rows:  <DataRow>[
                    DataRow(
                      cells: <DataCell>[
                        DataCell(GestureDetector(
                          onTap: (){
                            query.KOSDAQ_rate_of_decline1==''
                                ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Row(children: [const Icon(Icons.clear, color: Colors.white,), const SizedBox(width: 20,), Expanded(child: Text('에러!', style: TextStyle(fontSize: 18),),),],),))
                                : Get.to(() => Financial(), arguments: query.KOSDAQ_rate_of_decline1.toString());
                          },
                          child: Text(query.KOSDAQ_rate_of_decline1),
                        )),
                        DataCell(Text(query.KOSDAQ_rate_of_decline6+"%",style: TextStyle(color: Colors.blue),)),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(GestureDetector(
                          onTap: (){
                            query.KOSDAQ_rate_of_decline2==''
                                ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Row(children: [const Icon(Icons.clear, color: Colors.white,), const SizedBox(width: 20,), Expanded(child: Text('에러!', style: TextStyle(fontSize: 18),),),],),))
                                : Get.to(() => Financial(), arguments: query.KOSDAQ_rate_of_decline2.toString());
                          },
                          child: Text(query.KOSDAQ_rate_of_decline2),
                        )),
                        DataCell(Text(query.KOSDAQ_rate_of_decline7+"%",style: TextStyle(color: Colors.blue),)),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(GestureDetector(
                          onTap: (){
                            query.KOSDAQ_rate_of_decline3==''
                                ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Row(children: [const Icon(Icons.clear, color: Colors.white,), const SizedBox(width: 20,), Expanded(child: Text('에러!', style: TextStyle(fontSize: 18),),),],),))
                                : Get.to(() => Financial(), arguments: query.KOSDAQ_rate_of_decline3.toString());
                          },
                          child: Text(query.KOSDAQ_rate_of_decline3),
                        )),
                        DataCell(Text(query.KOSDAQ_rate_of_decline8+"%",style: TextStyle(color: Colors.blue),)),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(GestureDetector(
                          onTap: (){
                            query.KOSDAQ_rate_of_decline4==''
                                ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Row(children: [const Icon(Icons.clear, color: Colors.white,), const SizedBox(width: 20,), Expanded(child: Text('에러!', style: TextStyle(fontSize: 18),),),],),))
                                : Get.to(() => Financial(), arguments: query.KOSDAQ_rate_of_decline4.toString());
                          },
                          child: Text(query.KOSDAQ_rate_of_decline4),
                        )),
                        DataCell(Text(query.KOSDAQ_rate_of_decline9+"%",style: TextStyle(color: Colors.blue),)),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(GestureDetector(
                          onTap: (){
                            query.KOSDAQ_rate_of_decline5==''
                                ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Row(children: [const Icon(Icons.clear, color: Colors.white,), const SizedBox(width: 20,), Expanded(child: Text('에러!', style: TextStyle(fontSize: 18),),),],),))
                                : Get.to(() => Financial(), arguments: query.KOSDAQ_rate_of_decline5.toString());
                          },
                          child: Text(query.KOSDAQ_rate_of_decline5),
                        )),
                        DataCell(Text(query.KOSDAQ_rate_of_decline10+"%",style: TextStyle(color: Colors.blue),)),
                      ],
                    ),
                  ],
                ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _Record_highmain(){
    return Container(
      width: double.infinity,
      height: 50,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Row(children: [
              SizedBox(width: 10,),
              Text(
                "신고가",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ]),
          ),
        ],
      ),
    );
  }
  Widget _Record_high(){
    return Card(
      shape: RoundedRectangleBorder(  //모서리를 둥글게 하기 위해 사용
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        children: [
          SizedBox(height: 10,),
          Row(children: [
            SizedBox(width: 10,),
            Text(
              "신고가",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ]),
          Container(
            height: 300,
            margin: EdgeInsets.all(5),
            child: Row(
              children: [
                Expanded(child:
                DataTable(
                  horizontalMargin: 10.0,
                  columnSpacing: 35.0,
                  columns:  <DataColumn>[
                    DataColumn(
                      label: Text(
                        '코스피',
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        '등락률',
                      ),
                    ),
                  ],
                  rows:  <DataRow>[
                    DataRow(
                      cells: <DataCell>[
                        DataCell(GestureDetector(
                          onTap: (){
                            query.high1==''
                                ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Row(children: [const Icon(Icons.clear, color: Colors.white,), const SizedBox(width: 20,), Expanded(child: Text('에러!', style: TextStyle(fontSize: 18),),),],),))
                                : Get.to(() => Financial(), arguments: query.high1.toString());
                          },
                          child: Text(query.high1),
                        )),
                        DataCell(Text(query.high6+'%',style: TextStyle(color: Colors.red),)),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(GestureDetector(
                          onTap: (){
                            query.high2==''
                                ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Row(children: [const Icon(Icons.clear, color: Colors.white,), const SizedBox(width: 20,), Expanded(child: Text('에러!', style: TextStyle(fontSize: 18),),),],),))
                                : Get.to(() => Financial(), arguments: query.high2.toString());
                          },
                          child: Text(query.high2),
                        )),
                        DataCell(Text(query.high7+'%',style: TextStyle(color: Colors.red),)),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(GestureDetector(
                          onTap: (){
                            query.high3==''
                                ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Row(children: [const Icon(Icons.clear, color: Colors.white,), const SizedBox(width: 20,), Expanded(child: Text('에러!', style: TextStyle(fontSize: 18),),),],),))
                                : Get.to(() => Financial(), arguments: query.high3.toString());
                          },
                          child: Text(query.high3),
                        )),
                        DataCell(Text(query.high8+'%',style: TextStyle(color: Colors.red),)),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(GestureDetector(
                          onTap: (){
                            query.high4==''
                                ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Row(children: [const Icon(Icons.clear, color: Colors.white,), const SizedBox(width: 20,), Expanded(child: Text('에러!', style: TextStyle(fontSize: 18),),),],),))
                                : Get.to(() => Financial(), arguments: query.high4.toString());
                          },
                          child: Text(query.high4),
                        )),
                        DataCell(Text(query.high9+'%',style: TextStyle(color: Colors.red),)),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(GestureDetector(
                          onTap: (){
                            query.high5==''
                                ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Row(children: [const Icon(Icons.clear, color: Colors.white,), const SizedBox(width: 20,), Expanded(child: Text('에러!', style: TextStyle(fontSize: 18),),),],),))
                                : Get.to(() => Financial(), arguments: query.high5.toString());
                          },
                          child: Text(query.high5),
                        )),
                        DataCell(Text(query.high10+'%',style: TextStyle(color: Colors.red),)),
                      ],
                    ),
                  ],
                ),
                ),
                Expanded(child:
                DataTable(
                  horizontalMargin: 10.0,
                  columnSpacing: 35.0,
                  columns:  <DataColumn>[
                    DataColumn(
                      label: Text(
                        '코스닥',
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        '등락률',
                      ),
                    ),
                  ],
                  rows:  <DataRow>[
                    DataRow(
                      cells: <DataCell>[
                        DataCell(GestureDetector(
                          onTap: (){
                            Get.to(() => Financial(), arguments: query.KOSDAQ_high1.toString());
                          },
                          child: Text(query.KOSDAQ_high1),
                        )),
                        DataCell(Text(query.KOSDAQ_high6+'%',style: TextStyle(color: Colors.red),)),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(GestureDetector(
                          onTap: (){
                            Get.to(() => Financial(), arguments: query.KOSDAQ_high2.toString());
                          },
                          child: Text(query.KOSDAQ_high2),
                        )),
                        DataCell(Text(query.KOSDAQ_high7+'%',style: TextStyle(color: Colors.red),)),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(GestureDetector(
                          onTap: (){
                            Get.to(() => Financial(), arguments: query.KOSDAQ_high3.toString());
                          },
                          child: Text(query.KOSDAQ_high3),
                        )),
                        DataCell(Text(query.KOSDAQ_high8+'%',style: TextStyle(color: Colors.red),)),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(GestureDetector(
                          onTap: (){
                            Get.to(() => Financial(), arguments: query.KOSDAQ_high4.toString());
                          },
                          child: Text(query.KOSDAQ_high4),
                        )),
                        DataCell(Text(query.KOSDAQ_high9+'%',style: TextStyle(color: Colors.red),)),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(GestureDetector(
                          onTap: (){
                            Get.to(() => Financial(), arguments: query.KOSDAQ_high5.toString());
                          },
                          child: Text(query.KOSDAQ_high5),
                        )),
                        DataCell(Text(query.KOSDAQ_high10+'%',style: TextStyle(color: Colors.red),)),
                      ],
                    ),
                  ],
                ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _Record_lowmain(){
    return Container(
      width: double.infinity,
      height: 50,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Row(children: [
              SizedBox(width: 10,),
              Text(
                "신저가",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ]),
          ),
        ],
      ),
    );
  }
  Widget _Record_low(){
    return Card(
      shape: RoundedRectangleBorder(  //모서리를 둥글게 하기 위해 사용
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        children: [
          SizedBox(height : 10,),
          Row(children: [
            SizedBox(width: 10,),
            Text(
              "신저가",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ]),
          Container(
            height: 300,
            margin: EdgeInsets.all(5), //테두리
            child: Row(
              children: [
                Expanded(child:
                DataTable(
                  horizontalMargin: 10.0,
                  columnSpacing: 30.0,
                  columns:  <DataColumn>[
                    DataColumn(
                      label: Text(
                        '코스피',
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        '등락률',
                      ),
                    ),
                  ],
                  rows:  <DataRow>[
                    DataRow(
                      cells: <DataCell>[
                        DataCell(GestureDetector(
                          onTap: (){
                            Get.to(() => Financial(), arguments: query.low1.toString());
                          },
                          child: Text(query.low1),
                        )),
                        DataCell(Text(query.low6+'%',style: TextStyle(color: Colors.blue),)),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(GestureDetector(
                          onTap: (){
                            Get.to(() => Financial(), arguments: query.low2.toString());
                          },
                          child: Text(query.low2),
                        )),
                        DataCell(Text(query.low7+'%',style: TextStyle(color: Colors.blue),)),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(GestureDetector(
                          onTap: (){
                            Get.to(() => Financial(), arguments: query.low3.toString());
                          },
                          child: Text(query.low3),
                        )),
                        DataCell(Text(query.low8+'%',style: TextStyle(color: Colors.blue),)),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(GestureDetector(
                          onTap: (){
                            Get.to(() => Financial(), arguments: query.low4.toString());
                          },
                          child: Text(query.low4),
                        )),
                        DataCell(Text(query.low9+'%',style: TextStyle(color: Colors.blue),)),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(GestureDetector(
                          onTap: (){
                            Get.to(() => Financial(), arguments: query.low5.toString());
                          },
                          child: Text(query.low5),
                        )),
                        DataCell(Text(query.low10+'%',style: TextStyle(color: Colors.blue),)),
                      ],
                    ),
                  ],
                ),
                ),
                Expanded(child:
                DataTable(
                  horizontalMargin: 10.0,
                  columnSpacing: 30.0,
                  columns:  <DataColumn>[
                    DataColumn(
                      label: Text(
                        '코스닥',
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        '등락률',
                      ),
                    ),
                  ],
                  rows:  <DataRow>[
                    DataRow(
                      cells: <DataCell>[
                        DataCell(GestureDetector(
                          onTap: (){
                            Get.to(() => Financial(), arguments: query.KOSDAQ_low1.toString());
                          },
                          child: Text(query.KOSDAQ_low1),
                        )),
                        DataCell(Text(query.KOSDAQ_low6+'%',style: TextStyle(color: Colors.blue),)),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(GestureDetector(
                          onTap: (){
                            Get.to(() => Financial(), arguments: query.KOSDAQ_low2.toString());
                          },
                          child: Text(query.KOSDAQ_low2),
                        )),
                        DataCell(Text(query.KOSDAQ_low7+'%',style: TextStyle(color: Colors.blue),)),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(GestureDetector(
                          onTap: (){
                            Get.to(() => Financial(), arguments: query.KOSDAQ_low3.toString());
                          },
                          child: Text(query.KOSDAQ_low3),
                        )),
                        DataCell(Text(query.KOSDAQ_low8+'%',style: TextStyle(color: Colors.blue),)),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(GestureDetector(
                          onTap: (){
                            Get.to(() => Financial(), arguments: query.KOSDAQ_low4.toString());
                          },
                          child: Text(query.KOSDAQ_low4),
                        )),
                        DataCell(Text(query.KOSDAQ_low9+'%',style: TextStyle(color: Colors.blue),)),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(GestureDetector(
                          onTap: (){
                            Get.to(() => Financial(), arguments: query.KOSDAQ_low5.toString());
                          },
                          child: Text(query.KOSDAQ_low5),
                        )),
                        DataCell(Text(query.KOSDAQ_low10+'%',style: TextStyle(color: Colors.blue),)),
                      ],
                    ),
                  ],
                ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        _Chart(),
        //_Risemain(),
        _Rise(),
        //_Dropmain(),
        _Drop(),
        //_Record_highmain(),
        _Record_high(),
        //_Record_lowmain(),
        _Record_low(),
      ],),
    );
  }
}
