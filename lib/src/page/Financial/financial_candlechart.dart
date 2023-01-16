import 'dart:async';
import 'dart:convert';
//import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:intl/intl.dart';
import 'package:untitled/src/page/Financial/query.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../controller/auth_controller.dart';
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
    empty: json["close"].toInt(),
    date: DateTime.parse(json["date"]),
  );

  Map<String, dynamic> toJson() => {
    "close": empty!,
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
  };
}
String stockCode = '';

class Fin_Candle extends StatefulWidget {
  @override
  Fin_Candle_Main createState() => Fin_Candle_Main();
}

class Fin_Candle_Main extends State<Fin_Candle>  with AutomaticKeepAliveClientMixin{
  String searchText = Get.arguments;
  fin_Query query = fin_Query();
  Timer? _timer;
  List<ChartData> _Chartdata = [];
  List<EnvelData> _Enveldata = [];
  Map<String, dynamic> _result={};
  late ZoomPanBehavior _zoomPanBehavior;
  late TooltipBehavior _tooltipBehavior;
  DateTime now = DateTime.now();
  //List<ChartData1> _Chartdata1=[];
  late TrackballBehavior _trackballBehavior;
  bool isLoading = false;

  Future<void> readdata() async{

    FinancialState fs = FinancialState();
    print(fs.name);
/*    final usercol=FirebaseFirestore.instance
        .collection("userstock")
        .where('uid', isEqualTo: AuthController.to.user.value.uid)
        .where('name', isEqualTo: fs.name);
    usercol.get().then((value) => {
      print(value)
    });*/
    await FirebaseFirestore.instance.collection("userstock")
    .where('uid', isEqualTo: AuthController.to.user.value.uid)
        .where('name', isEqualTo: fs.name)
        .get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        //print(result.data());
        _result = result.data();
      });
    });
  }


  Future<void> Find_dataTime(String data) async
  {
    String url1 = "http://kmuproject.kro.kr:5568/sql/${data}";
    String Changed_String1 = url1.replaceAll(' ', '!');
    var response1 = await https.get(Uri.parse(Changed_String1));

    var statusCode1 = response1.statusCode;
    var responseHeaders1 = response1.headers;
    //var responseBody1 = response1.body;
    var responseBody1 = jsonDecode(response1.body);
   // print("statusCode: ${statusCode1}");
    //print("responseHeaders: ${responseHeaders1}");
    print("responseBody: ${responseBody1}");
    _Chartdata =
    List<ChartData>.from(responseBody1.map((x) => ChartData.fromJson(x)));
    //_Chartdata.removeRange(400, 5300);
    print(_Chartdata.length);
  }
  Future<void> Find_envel(String data) async
  {
    String url1 = "http://kmuproject.kro.kr:5568/envel/${data}/20";
    String Changed_String1 = url1.replaceAll(' ', '!');
    var response1 = await https.get(Uri.parse(Changed_String1));

    var statusCode1 = response1.statusCode;
    var responseHeaders1 = response1.headers;
    //var responseBody1 = response1.body;
    var responseBody1 = jsonDecode(response1.body);
    //print("statusCode: ${statusCode1}");
    //print("responseHeaders: ${responseHeaders1}");
    //print("responseBody: ${responseBody1}");
    _Enveldata =
    List<EnvelData>.from(responseBody1.map((x) => EnvelData.fromJson(x)));
    print(_Enveldata.length);
  }
  @override
  void initState() {
    setState(() {
      isLoading = true;
    });
    // TODO: implement initState
    super.initState();
    _trackballBehavior = TrackballBehavior(enable: true, activationMode:  ActivationMode.singleTap);
    FinancialState fb = FinancialState();
    searchText = fb.name;
    Future<String> Stock_Code;
    Stock_Code = query.Find_Stock_Code(searchText);
    _tooltipBehavior = TooltipBehavior(enable: true,);
    _zoomPanBehavior = ZoomPanBehavior(enablePinching: true);
    if(fb.name == ""){
      searchText = Get.arguments;
    }

    Stock_Code.then((val) async {
      // 종목코드가 나오면 해당 값을 출력
      print('val: $val');
      stockCode = val;
      await readdata();
      print(_result);
      String find_date="SELECT * FROM finance_timedata.history_${val} WHERE 날짜 BETWEEN '2017-11-01' AND now();";
      await(Find_dataTime(find_date));
      await(Find_envel(val));
      //await(Find_dataTime1(find_date1));
      print(_Chartdata.length);
    }).catchError((error) {
      // error가 해당 에러를 출력
      print('error: $error');
    });
    Future.delayed(Duration(seconds:2), () {
      print(_Chartdata.length);
      setState(() {
        super.setState(() {
          isLoading = false;
        });
      });
    });
  }
  @override
  Widget build(BuildContext context) {
      print(_Chartdata.length);
      setState(() {
      });
      return isLoading
          ? Center(child: Container(child: CircularProgressIndicator(),),)
          :SafeArea(
          child: Scaffold(
            /*appBar: AppBar(
              automaticallyImplyLeading: false,
              title: GestureDetector(
                onTap: (){
                  _displayTextInputDialog();
                },
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          child: Text("단가\n"+price,textAlign: TextAlign.center,),
                        ),
                        Container(
                          child: Text('수량\n'+quantity,textAlign: TextAlign.center,),
                        ),
                        Container(
                          child: Text("매수액\n"+purchase_amount,textAlign: TextAlign.center,),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),*/
/*            margin: EdgeInsets.all(5),
            width: double.infinity,
            height: 300,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), //모서리를 둥글게
                border: Border.all(color: Colors.black12, width: 3)), //테두리*/
            body: _Chartdata == null
                ? Center(child: Text("load..."),)
                :SfCartesianChart(
              primaryXAxis: DateTimeAxis(
                  dateFormat: DateFormat.yMd(),
/*                  plotBands: [
                    PlotBand(
                      color: Colors.lightBlue,
                      text:('AI'),
                      textStyle: TextStyle(
                        color: Colors.white,
                      ),
                      textAngle: 0,
                      isVisible: true,
                      start:_Chartdata[0].purple,
                      end: now.add(const Duration(days: 7)) ,
                      //start:DateTime(오늘날짜),
                      //end:DateTime(예측날짜),
                    )
                  ]*/
              ),
              primaryYAxis: NumericAxis(
                opposedPosition: true,
              ),
              enableAxisAnimation: true,
              trackballBehavior : _trackballBehavior,
              tooltipBehavior: _tooltipBehavior,
              zoomPanBehavior: _zoomPanBehavior,
                annotations: <CartesianChartAnnotation>[
                  CartesianChartAnnotation(
                      widget: Container(
                          child: _result['price'] == null
                              ? const Text(' ')
                              :Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10), //모서리를 둥글게
                                  border: Border.all(color: Colors.black, width: 2)),
                          child: Text("평단가: ${_result['price']}",style: TextStyle(fontSize: 20),)),),
                      coordinateUnit: CoordinateUnit.logicalPixel,
                      region: AnnotationRegion.plotArea,
                      x: 200,
                      y: 20),
                ],
              //title: ChartTitle(text: searchText),
              series: <CartesianSeries>[
                LineSeries<EnvelData, DateTime>(
                  // Bind data source
                  dataSource: _Enveldata,
                  xValueMapper: (EnvelData sales, _) => sales.date!,
                  yValueMapper: (EnvelData sales, _) => sales.empty!,
                ),
                LineSeries<EnvelData, DateTime>(
                  // Bind data source
                  dataSource: _Enveldata,
                  xValueMapper: (EnvelData sales, _) => sales.date!,
                  yValueMapper: (EnvelData sales, _) => (sales.empty!*1.1),
                ),
                LineSeries<EnvelData, DateTime>(
                  // Bind data source
                  dataSource: _Enveldata,
                  xValueMapper: (EnvelData sales, _) => sales.date!,
                  yValueMapper: (EnvelData sales, _) => (sales.empty!*0.9),
                ),
                CandleSeries<ChartData, DateTime>(
                    dataSource: _Chartdata,
                    xValueMapper: (ChartData data, _) => data.purple!,
                    highValueMapper: (ChartData data, _) => data.data!,
                    lowValueMapper: (ChartData data, _) => data.tentacled!,
                    openValueMapper: (ChartData data, _) => (data.fluffy!),
                    closeValueMapper: (ChartData data, _) => data.sticky!,
                ),
              ],
            ),
          ),
      );
    }
  TextEditingController priceController = TextEditingController();
  TextEditingController QuantityController = TextEditingController();
  String price = '';
  String quantity = '';
  int purchase_amount_int =0;
  String purchase_amount ='';
  void _displayTextInputDialog() async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('단가 수량 입력'),
            content: Container(
              height: 200,
              width: 100,
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 50,
                    width: 200,
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Colors.grey.withOpacity(0.2),
                        hintText: "단가",
                      ),
                      controller: priceController,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 50,
                    width: 200,
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Colors.grey.withOpacity(0.2),
                        hintText: "수량",
                      ),
                      controller: QuantityController,
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text("저장"),
                onPressed: () {
                  price = priceController.text;
                  quantity = QuantityController.text;
                  purchase_amount_int = int.parse(price)*int.parse(quantity);
                  purchase_amount = purchase_amount_int.toString();
                  setState(() {
                    super.setState(() {

                    });
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }
  @override
// TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

