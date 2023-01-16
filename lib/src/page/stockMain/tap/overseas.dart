/*
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

import '../../Financial/financial_chart.dart';
import 'internal.dart';

class Overseas extends StatelessWidget{
  const Overseas({Key? key}) : super(key: key);

  Widget _Chart(){
    return Container(
      width: double.infinity,
      height: 150,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Center(
              child: Container(
                width: 170,
                height: 170,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("다우 산업"),
                    Text("36,357.95",style: TextStyle(fontSize: 20),),
                    Text("203.72 0.56%"),
                    Expanded(child:
                    Center(
                        child: Container(
                            width: 170,
                            height: 100,
                            child: Center(
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
                            )
                        )
                    ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Container(
                width: 170,
                height: 170,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("나스닥 종합"),
                    Text("15,971.59",style: TextStyle(fontSize: 20),),
                    Text("31.28 0.20%"),
                    Expanded(child:
                    Center(
                        child: Container(
                            width: 170,
                            height: 100,
                            child: Center(
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
                            )
                        )
                    ),
                    ),
                  ],
                ),
              ),
            ),),
        ],
      ),);
  }

  Widget _Chart1(){
    return Container(
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 3, color: Colors.black))),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Center(
              child: Container(
                width: 170,
                height: 170,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("니케이 225"),
                    Text("15,971.59",style: TextStyle(fontSize: 20),),
                    Text("182.80 0.61%"),
                    Expanded(child:
                    Center(
                        child: Container(
                            width: 170,
                            height: 100,
                            child: Center(
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
                            )
                        )
                    ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Container(
                width: 170,
                height: 170,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("상해종합"),
                    Text("3,491.57",style: TextStyle(fontSize: 20),),
                    Text("35.30 1.00%"),
                    Expanded(child:
                    Center(
                        child: Container(
                            width: 170,
                            height: 100,
                            child: Center(
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
                            )
                        )
                    ),
                    ),
                  ],
                ),
              ),
            ),),
        ],
      ),);
  }
  Widget _Risemain(){
    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
      width: double.infinity,
      height: 50,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Row(children: [
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
    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 3, color: Colors.black))),
      child: Row(
        children: [
          Expanded(child:
          DataTable(
            horizontalMargin: 10.0,
            columnSpacing: 35.0,
            columns: const <DataColumn>[
              DataColumn(
                label: Text(
                  '이름',
                ),
              ),
              DataColumn(
                label: Text(
                  '주가',
                ),
              ),
              DataColumn(
                label: Text(
                  '퍼센트',
                ),
              ),
            ],
            rows: const <DataRow>[
              DataRow(
                cells: <DataCell>[
                  DataCell(Text('에이비스 버짓 그룹'),),
                  DataCell(Text('357.17'),),
                  DataCell(Text('0.0%',style: TextStyle(color: Colors.red),)),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Text('OLB 그룹')),
                  DataCell(Text('8.60'),),
                  DataCell(Text('0.0%',style: TextStyle(color: Colors.red),)),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Text('SAB BIOTHERAPEUTICS')),
                  DataCell(Text('1.75'),),
                  DataCell(Text('0.0%',style: TextStyle(color: Colors.red),)),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Text('엑셀 브랜즈')),
                  DataCell(Text('1.95'),),
                  DataCell(Text('0.0%',style: TextStyle(color: Colors.red),)),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Text('화디 인터내셔널 그룹')),
                  DataCell(Text('24.31'),),
                  DataCell(Text('0.0%',style: TextStyle(color: Colors.red),)),
                ],
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
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
      width: double.infinity,
      height: 50,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Row(children: [
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
    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 3, color: Colors.black))),
      child: Row(
        children: [
          Expanded(child:
          DataTable(
            horizontalMargin: 10.0,
            columnSpacing: 30.0,
            columns: const <DataColumn>[
              DataColumn(
                label: Text(
                  '이름',
                ),
              ),
              DataColumn(
                label: Text(
                  '주가',
                ),
              ),
              DataColumn(
                label: Text(
                  '퍼센트',
                ),
              ),
            ],
            rows: const <DataRow>[
              DataRow(
                cells: <DataCell>[
                  DataCell(Text('버크스 그룹'),),
                  DataCell(Text('3.77'),),
                  DataCell(Text('0.0%',style: TextStyle(color: Colors.blue),)),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Text('체그')),
                  DataCell(Text('32.12'),),
                  DataCell(Text('0.0%',style: TextStyle(color: Colors.blue),)),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Text('TRITERRAS')),
                  DataCell(Text('1.16'),),
                  DataCell(Text('0.0%',style: TextStyle(color: Colors.blue),)),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Text('BETTER THERAPEUTICS INC')),
                  DataCell(Text('11.50'),),
                  DataCell(Text('0.0%',style: TextStyle(color: Colors.blue),)),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Text('CLENE INC C')),
                  DataCell(Text('11.50'),),
                  DataCell(Text('0.0%',style: TextStyle(color: Colors.blue),)),
                ],
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
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
      width: double.infinity,
      height: 50,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Row(children: [
              Text(
                "거래량",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ]),
          ),
        ],
      ),
    );
  }
  Widget _Record_high(){
    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 3, color: Colors.black))),
      child: Row(
        children: [
          Expanded(child:
          DataTable(
            horizontalMargin: 10.0,
            columnSpacing: 30.0,
            columns: const <DataColumn>[
              DataColumn(
                label: Text(
                  '이름',
                ),
              ),
              DataColumn(
                label: Text(
                  '주가',
                ),
              ),
              DataColumn(
                label: Text(
                  '퍼센트',
                ),
              ),
            ],
            rows: const <DataRow>[
              DataRow(
                cells: <DataCell>[
                  DataCell(Text('버크스 그룹'),),
                  DataCell(Text('3.77'),),
                  DataCell(Text('0.0%',style: TextStyle(color: Colors.blue),)),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Text('체그')),
                  DataCell(Text('32.12'),),
                  DataCell(Text('0.0%',style: TextStyle(color: Colors.blue),)),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Text('TRITERRAS')),
                  DataCell(Text('1.16'),),
                  DataCell(Text('0.0%',style: TextStyle(color: Colors.blue),)),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Text('BETTER THERAPEUTICS INC')),
                  DataCell(Text('11.50'),),
                  DataCell(Text('0.0%',style: TextStyle(color: Colors.blue),)),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Text('CLENE INC C')),
                  DataCell(Text('11.50'),),
                  DataCell(Text('0.0%',style: TextStyle(color: Colors.blue),)),
                ],
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
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
      width: double.infinity,
      height: 50,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Row(children: [
              Text(
                "거래대금",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ]),
          ),
        ],
      ),
    );
  }
  Widget _Record_low(){
    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 3, color: Colors.black))),
      child: Row(
        children: [
          Expanded(child:
          DataTable(
            horizontalMargin: 10.0,
            columnSpacing: 30.0,
            columns: const <DataColumn>[
              DataColumn(
                label: Text(
                  '이름',
                ),
              ),
              DataColumn(
                label: Text(
                  '주가',
                ),
              ),
              DataColumn(
                label: Text(
                  '퍼센트',
                ),
              ),
            ],
            rows: const <DataRow>[
              DataRow(
                cells: <DataCell>[
                  DataCell(Text('버크스 그룹'),),
                  DataCell(Text('3.77'),),
                  DataCell(Text('0.0%',style: TextStyle(color: Colors.blue),)),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Text('체그')),
                  DataCell(Text('32.12'),),
                  DataCell(Text('0.0%',style: TextStyle(color: Colors.blue),)),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Text('TRITERRAS')),
                  DataCell(Text('1.16'),),
                  DataCell(Text('0.0%',style: TextStyle(color: Colors.blue),)),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Text('BETTER THERAPEUTICS INC')),
                  DataCell(Text('11.50'),),
                  DataCell(Text('0.0%',style: TextStyle(color: Colors.blue),)),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Text('CLENE INC C')),
                  DataCell(Text('11.50'),),
                  DataCell(Text('0.0%',style: TextStyle(color: Colors.blue),)),
                ],
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
        _Chart1(),
        _Risemain(),
        _Rise(),
        _Dropmain(),
        _Drop(),
        _Record_highmain(),
        _Record_high(),
        _Record_lowmain(),
        _Record_low(),
      ],),
    );
  }
}
*/
