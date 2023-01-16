import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';


class SalesData {
  SalesData(this.year, this.sales,);

  final String year;
  final double?sales;
}

class Fin_Chart extends StatelessWidget {
   Fin_Chart({Key? key}) : super(key: key);

   String name=Get.arguments[0];
   String num1=Get.arguments[1];
   String num2=Get.arguments[2];
   String num3=Get.arguments[3];

  Widget chart(){
    return Container(
        width: double.infinity,
        height: 300,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), //모서리를 둥글게
            border: Border.all(color: Colors.black12, width: 3)), //테두리
        margin: EdgeInsets.all(5),
        child: name == null
            ? Center(child: Text("값이 없습니다."),)
            : SfCartesianChart(
            enableAxisAnimation: true,
            primaryXAxis: CategoryAxis(
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
            series: <CartesianSeries>[
              ColumnSeries<SalesData, String>(
                  dataSource: [
                    SalesData('20/01', double.parse(num1)/100000000),
                    SalesData('19/01', double.parse(num2)/100000000),
                    SalesData('18/01', double.parse(num3)/100000000),
                  ],
                  xValueMapper: (SalesData data, _) => data.year,
                  yValueMapper: (SalesData data, _) => data.sales
              ),
            ]
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:Text(name),
      ),
      body: chart(),
    );
  }
}
