import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:untitled/src/page/Financial/query.dart';
import 'package:untitled/src/page/Financial/search.dart';
import 'dart:convert';
import 'package:webview_flutter/webview_flutter.dart';

import '../financial.dart';
import '../financial_candlechart.dart';
import '../homeMain/query_home.dart';
import 'financial.dart';

class StockMain extends StatefulWidget {
  @override
  stock_main createState() => stock_main();
}

class stock_main extends State<StockMain> with AutomaticKeepAliveClientMixin{
  final Completer<WebViewController> _controller = Completer<WebViewController>();
  FinancialState fb = FinancialState();
  fin_Query query = fin_Query();
  Query_home query1 = Query_home();
  Map<String, dynamic> _result={};
  late List<dynamic> info=[];

  late List<dynamic> sale=[];
  late List<dynamic> sale_name=[];
  String searchText = '';
  String StockCode ='';
  String dartCode = '';

  String corp_name='';
  String corp_name_eng='';
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState

    Future.microtask(() async{
      setState(() {
        isLoading = true;
      });
      FinancialState fb = FinancialState();
      searchText = fb.name;
      Future<String> Stock_Code;
      //_result = await _connect();
      //dividend = await Dividend();
      //setState(() {});
      Stock_Code = query.Find_Stock_Code(searchText);
      await Stock_Code.then((val) async {
        String hot_news = "SELECT title, date FROM stock.news where `종목코드`='${val}' order by date desc, time desc limit 5;";
/*        String Total_Debt="SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM c__financialstatements.fs${val} Where account_id = 'ifrs-full_Liabilities' And sj_div = 'BS';";
        String total_capital="select thstrm_amount,frmtrm_amount,bfefrmtrm_amount from c__financialstatements.fs005930 where account_id = 'ifrs-full_Equity' and (sj_div ='BS' or account_detail =  '연결재무제표 [member]');";
        String net_income = "SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM c__financialstatements.fs${val} Where account_id = 'ifrs-full_ProfitLoss' And (sj_div = 'IS' or sj_div = 'CIS');";
        String CFO="SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM c__financialstatements.fs${val} Where account_id = 'ifrs-full_CashFlowsFromUsedInOperatingActivities' And sj_div = 'CF';";
        await Find_Pie_data(Total_Debt, total_capital,net_income, CFO);*/
        String saleratio = "SELECT * FROM stock.salesratio where stockcode='${val}';";
        String saleratio_name = "SELECT * FROM stock.salesratio_name where stockcode='${val}';";
        _result = await _connect(val);
        info = await _connect1(val);
        sale = await Find_Pie_data(saleratio);
        sale_name = await Find_Pie_data(saleratio_name);
        await query1.Find_hot_news(hot_news);
        print(info);
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

  @override
  Widget stock_info() {
    return Card(
      shape: RoundedRectangleBorder(  //모서리를 둥글게 하기 위해 사용
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: SafeArea(
        child: SafeArea(
          child: _result == null
              ? Center(child: Text("load..."),)
              :Container(
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.all(30),
            width: double.infinity,
            height: 400, //테두리
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("이름"),
                          Text(_result['corp_name'].toString()),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("영문 이름"),
                          SizedBox(
                            width: 50,
                          ),
                          Expanded(child: Text(_result['corp_name_eng'].toString(),softWrap: true,textAlign: TextAlign.end,
                          style: const TextStyle(height: 1.39),),),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("대표 이사"),
                          Text(_result['ceo_nm'].toString()),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("주소"),
                          SizedBox(
                            width: 50,
                          ),
                          Expanded(child: Text(_result['adres'].toString(),softWrap: true,textAlign: TextAlign.end,),),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text("홈페이지"),
                            ],
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: 2,
                              ),
                              GestureDetector(onTap: (){Navigator.of(context).push<void>(
                                  MaterialPageRoute(
                                      builder: (BuildContext context) => Scaffold(
                                        appBar: AppBar(centerTitle:true,title: Text(_result['corp_name'].toString()),),
                                        body: SafeArea(
                                          child: WebView(
                                            initialUrl: _result['hm_url'].toString(),
                                            javascriptMode: JavascriptMode.unrestricted,
                                            onWebViewCreated: (WebViewController webViewController) {
                                              _controller.complete(webViewController);
                                            },
                                          ),
                                        ),
                                        floatingActionButton: FutureBuilder<WebViewController>(
                                            future: _controller.future,
                                            builder: (BuildContext context,
                                                AsyncSnapshot<WebViewController> controller) {
                                              if (controller.hasData) {
                                                return FloatingActionButton(
                                                    child: Icon(Icons.arrow_back),
                                                    onPressed: () {
                                                      controller.data!.goBack();
                                                    });
                                              }
                                              return Container();
                                            }
                                        ),
                                      )
                                  )
                              );
                              }, child: Text(_result['hm_url'].toString(),style: const TextStyle(color: Colors.blue),)),
                            ],
                          )
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("전화번호"),
                          Text(_result['phn_no'].toString()),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("팩스"),
                          Text(_result['fax_no'].toString()),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("설립일"),
                          Text(_result['est_dt'].toString()),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("결산월"),
                          Text(_result['acc_mt'].toString()+"월"),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget stock_info2() {
    return Card(
      shape: RoundedRectangleBorder(  //모서리를 둥글게 하기 위해 사용
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: SafeArea(
        child: SafeArea(
          child: info == null
              ? Center(child: Text("load..."),)
              :Container(
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.all(30),
            width: double.infinity,
            height: 150,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("시가총액(억)"),
                          Text(info.isNotEmpty ? info[0]['시가총액(억)'].toString() : ''),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("상장주식수(천)"),
                          Text(info.isNotEmpty ? info[0]['상장주식수(천)'].toString() : ''),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
/*
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
    return Container(
      margin: EdgeInsets.all(5),
      width: double.infinity,
      height: 300,
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
    );
  }

*/
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
    return SafeArea(
        child: Center(
            child: net_income_thstrm_amount == 0 && net_income_frmtrm_amount == 0 && net_income_bfefrmtrm_amount == 0
                ? Center(child: Text("load..."),)
                :Container(
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.all(30),
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), //모서리를 둥글게
                    border: Border.all(color: Colors.black12, width: 3)), //테두리
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
    );
  }

  Widget piechart() {
    final List<PieData_CFO> chartData = [

      PieData_CFO(sale_name.isNotEmpty ? sale_name[0]["first_product"].toString() : "", sale.isNotEmpty ? double.parse(sale[0]["first_product"].toString()) : 0, Color.fromRGBO(051,204,153,1)),
      PieData_CFO(sale_name.isNotEmpty ? sale_name[0]["second_product"].toString() : "", sale.isNotEmpty ? double.parse(sale[0]["second_product"].toString()) : 0, Color.fromRGBO(051,204,255,1)),
      PieData_CFO(sale_name.isNotEmpty ? sale_name[0]["third_product"].toString() : "", sale.isNotEmpty ? double.parse(sale[0]["third_product"].toString()) : 0, Color.fromRGBO(051,153,255,1)),
      PieData_CFO(sale_name.isNotEmpty ? sale_name[0]["etc_product"].toString() : "", sale.isNotEmpty ? double.parse(sale[0]["etc_product"].toString()) : 0, Color.fromRGBO(051,204,53,1)),
      //ChartData('Others', 52, Color.fromRGBO(255,189,57,1))
    ];
    return SafeArea(
        child: Card(
          shape: RoundedRectangleBorder(  //모서리를 둥글게 하기 위해 사용
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 4,
          child: Container(
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.all(30),
                  width: double.infinity,
                  height: 300,/*
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20), //모서리를 둥글게
                      border: Border.all(color: Colors.black12, width: 3)), //테두리*/
                  child: SfCircularChart(
                      title: ChartTitle(
                          text: '주 판매 물품',
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
          ),
        )
    );
  }
  Widget _news() {
    return Card(
      shape: RoundedRectangleBorder(  //모서리를 둥글게 하기 위해 사용
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 4,
      child: Container(
        margin: EdgeInsets.all(5),
        width: double.infinity,
        height: 400,
        /*decoration: BoxDecoration(
          color: Colors.white,
          //borderRadius: BorderRadius.circular(20), //모서리를 둥글게
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 2,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ), //테두리*/
/*        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), //모서리를 둥글게
            border: Border.all(color: Colors.black12, width: 3)), //테*/
        child: Column(
          children: [
            Expanded(child: Container(
                height: 20,
                width: double.infinity,
                decoration: BoxDecoration(),
                child: Row(children: [SizedBox(width: 10,),Text("뉴스",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),)],)
            )),
            Expanded(
              child: Card(
                child: ListTile(
                  onTap: (){
                  },
                  title: Text(query1.title1,),
                  subtitle: Text(query1.date1,style: const TextStyle(fontSize: 12),),
                ),
              ),
/*                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),*/
            ),
            Expanded(
              child: Card(
                child: ListTile(
                  onTap: (){
                  },
                  title: Text(query1.title2),
                  subtitle: Text(query1.date2,style: const TextStyle(fontSize: 12),),
                ),
              ),
/*                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),*/

            ),
            Expanded(
              child: Card(
                child: ListTile(
                  onTap: (){
                  },
                  title: Text(query1.title3),
                  subtitle: Text(query1.date3,style: const TextStyle(fontSize: 12),),
                ),
              ),
/*                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),*/
            ),
            Expanded(
              child: Card(
                child: ListTile(
                  onTap: (){
                  },
                  title: Text(query1.title4),
                  subtitle: Text(query1.date4,style: const TextStyle(fontSize: 12),),
                ),
              ),
/*                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),*/
            ),
            Expanded(
              child: Card(
                child: ListTile(
                  onTap: (){
                  },
                  title: Text(query1.title5),
                  subtitle: Text(query1.date5,style: const TextStyle(fontSize: 12),),
                ),
              ),
/*                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),*/
            ),
/*              Expanded(
                child: GestureDetector(
                  onTap: () {
                    *//*Navigator.push(context,MaterialPageRoute(builder: (context)=> News()));*//*
                    Get.to(News(),arguments: query.link5);
                  },
                  child:Container(
                    child: Row(
                      children: [
                        SizedBox(width: 30,),
                        SizedBox(width: 350,child: Text(query.title5),),
                      ],
                    ),
                    height: 70,
                    width: double.infinity,
                  ),),
              ),*/
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
        stock_info(),
        stock_info2(),
/*        piechart_total_assets(),
        piechart_net_income(),
        piechart_CFO(),*/
        piechart(),
        _news(),
      ],
    );
  }

  Future< Map<String, dynamic>> _connect(String StockCode) async{
    print(StockCode);
    String url1 = "http://kmuproject.kro.kr:5568/sql/${"SELECT * FROM stock.dartcode where stockcode = "+StockCode+";"}";
    String Changed_String1 = url1.replaceAll(' ', '!');
    var response1 = await http.get(Uri.parse(Changed_String1));

    var statusCode1 = response1.statusCode;
    var responseHeaders1 = response1.headers;
    var responseBody1 = response1.body;

    List list1 = jsonDecode(responseBody1);

    //print("statusCode: ${statusCode1}");
    //print("responseHeaders: ${responseHeaders1}");
    print("responseBody: ${responseBody1}");

    dartCode = list1[0]['dartcode'].toString();

    const String _url = "https://opendart.fss.or.kr/api/company.json";
    const String _apiKey = "e50aac2aaa0bc5e55d91105ac6b5219b4992f32d";
    DateTime now = DateTime.now();
    DateTime Month = now.subtract(Duration(days:365));
    DateFormat formatter = DateFormat('yyyyMMdd');

    String strToday = formatter.format(now);
    String strMonth = formatter.format(Month);
    print(strMonth);
    final String _endPoint = "$_url?crtfc_key=$_apiKey&corp_code="+dartCode+"";
    //final String _endPoint = "$_url?crtfc_key=$_apiKey&corp_code=00126380";
    final http.Response _res = await http.get(Uri.parse(_endPoint));
    var responseBody12 = _res.body;
    //_result = json.decode(_res.body);
    print(responseBody12);
    Map<String, dynamic> result = json.decode(_res.body);
    corp_name = (result['adres']);
    print(corp_name);
    return result;
  }

  Future <List<dynamic>> _connect1(String StockCode) async{
    DateTime now = DateTime.now();
    DateTime yester = now.subtract(Duration(days:1));
    DateFormat formatter = DateFormat('yyyyMMdd');
    String stryester = formatter.format(yester);
    //String url1 = "http://kmuproject.kro.kr:5568/sql/${"SELECT * FROM stock.db_"+stryester+" where `종목코드`="+StockCode+";"}";
    String url1 = "http://kmuproject.kro.kr:5568/sql/${"SELECT * FROM stock.db_20220524 where `종목코드`="+StockCode+";"}";
    String Changed_String1 = url1.replaceAll(' ', '!');
    var response1 = await http.get(Uri.parse(Changed_String1));

    var statusCode1 = response1.statusCode;
    var responseHeaders1 = response1.headers;
    var responseBody1 = response1.body;

    List<dynamic> result = json.decode(response1.body);
    //print("statusCode: ${statusCode1}");
    //print("responseHeaders: ${responseHeaders1}");
    //print("responseBody: ${responseBody1}");
    print(result);
    return result;
  }

  Future<List<dynamic>> Find_Pie_data(String saleratio)async{

    String url1 = "http://kmuproject.kro.kr:5568/sql/${saleratio}";
    String Changed_String1 = url1.replaceAll(' ', '!');
    var response1 = await http.get(Uri.parse(Changed_String1));

    var statusCode1 = response1.statusCode;
    var responseHeaders1 = response1.headers;
    var responseBody1 = response1.body;

    print(responseBody1);
    List<dynamic> list1 = jsonDecode(responseBody1);
    return list1;
  }

  Future<List<dynamic>> Find_Pie_data_name(String saleratio)async{

    String url1 = "http://kmuproject.kro.kr:5568/sql/${saleratio}";
    String Changed_String1 = url1.replaceAll(' ', '!');
    var response1 = await http.get(Uri.parse(Changed_String1));

    var statusCode1 = response1.statusCode;
    var responseHeaders1 = response1.headers;
    var responseBody1 = response1.body;

    print(responseBody1);
    List<dynamic> list1 = jsonDecode(responseBody1);
    return list1;
  }
/*  Future<void> Find_Pie_data(String total_capital, Total_Debt, net_income ,CFO) async
  {
    String url1 = "http://kmuproject.kro.kr:5568/sql/${Total_Debt}";
    String Changed_String1 = url1.replaceAll(' ', '!');
    var response1 = await http.get(Uri.parse(Changed_String1));

    var statusCode1 = response1.statusCode;
    var responseHeaders1 = response1.headers;
    var responseBody1 = response1.body;

    List list1 = jsonDecode(responseBody1);

*//*    print("statusCode: ${statusCode1}");
    print("responseHeaders: ${responseHeaders1}");
    print("responseBody: ${responseBody1}");*//*

*//*    print(list1[0]['bfefrmtrm_amount']);
    print(list1[0]['frmtrm_amount']);
    print(list1[0]['thstrm_amount']);*//*

    Total_Debt_thstrm_amount = (double.parse(list1[0]['thstrm_amount'])/100000000);
    //d_Total_assets3 = double.parse(Total_Debt) / 100000000;
    Total_Debt_frmtrm_amount = double.parse(list1[0]['frmtrm_amount'])/100000000;
    //d_Total_assets2 = double.parse(Total_Debt) / 100000000;
    Total_Debt_bfefrmtrm_amount = double.parse(list1[0]['bfefrmtrm_amount'])/100000000;
    //d_Total_assets1 = double.parse(Total_Debt) / 100000000;

    String url2 = "http://kmuproject.kro.kr:5568/sql/${total_capital}";
    String Changed_String2 = url2.replaceAll(' ', '!');
    var response2 = await http.get(Uri.parse(Changed_String2));

    var statusCode2 = response2.statusCode;
    var responseHeaders2 = response2.headers;
    var responseBody2 = response2.body;

    List list2 = jsonDecode(responseBody2);

*//*    print("statusCode: ${statusCode1}");
    print("responseHeaders: ${responseHeaders1}");
    print("responseBody: ${responseBody1}");*//*

*//*    print(list1[0]['bfefrmtrm_amount']);
    print(list1[0]['frmtrm_amount']);
    print(list1[0]['thstrm_amount']);*//*

    total_capital_thstrm_amount = (double.parse(list2[0]['thstrm_amount'])/100000000);
    //d_Total_assets3 = double.parse(Total_Debt) / 100000000;
    total_capital_frmtrm_amount = double.parse(list2[0]['frmtrm_amount'])/100000000;
    //d_Total_assets2 = double.parse(Total_Debt) / 100000000;
    total_capital_bfefrmtrm_amount = double.parse(list2[0]['bfefrmtrm_amount'])/100000000;
    //d_Total_assets1 = double.parse(Total_Debt) / 100000000;

    String url3 = "http://kmuproject.kro.kr:5568/sql/${net_income}";
    String Changed_String3 = url3.replaceAll(' ', '!');
    var response3 = await http.get(Uri.parse(Changed_String3));

    var statusCode3 = response3.statusCode;
    var responseHeaders3 = response3.headers;
    var responseBody3 = response3.body;

    List list3 = jsonDecode(responseBody3);

*//*    print("statusCode: ${statusCode1}");
    print("responseHeaders: ${responseHeaders1}");
    print("responseBody: ${responseBody1}");*//*

*//*    print(list1[0]['bfefrmtrm_amount']);
    print(list1[0]['frmtrm_amount']);
    print(list1[0]['thstrm_amount']);*//*

    net_income_thstrm_amount = (double.parse(list3[0]['thstrm_amount'])/100000000);
    //d_Total_assets3 = double.parse(Total_Debt) / 100000000;
    net_income_frmtrm_amount = double.parse(list3[0]['frmtrm_amount'])/100000000;
    //d_Total_assets2 = double.parse(Total_Debt) / 100000000;
    net_income_bfefrmtrm_amount = double.parse(list3[0]['bfefrmtrm_amount'])/100000000;
    //d_Total_assets1 = double.parse(Total_Debt) / 100000000;

    String url4 = "http://kmuproject.kro.kr:5568/sql/${CFO}";
    String Changed_String4 = url4.replaceAll(' ', '!');
    var response4 = await http.get(Uri.parse(Changed_String4));

    var statusCode4 = response4.statusCode;
    var responseHeaders4 = response4.headers;
    var responseBody4 = response4.body;

    List list4 = jsonDecode(responseBody4);

*//*    print("statusCode: ${statusCode1}");
    print("responseHeaders: ${responseHeaders1}");
    print("responseBody: ${responseBody1}");*//*

*//*    print(list1[0]['bfefrmtrm_amount']);
    print(list1[0]['frmtrm_amount']);
    print(list1[0]['thstrm_amount']);*//*

    CFO_thstrm_amount = (double.parse(list4[0]['thstrm_amount'])/100000000);
    //d_Total_assets3 = double.parse(Total_Debt) / 100000000;
    CFO_frmtrm_amount = double.parse(list4[0]['frmtrm_amount'])/100000000;
    //d_Total_assets2 = double.parse(Total_Debt) / 100000000;
    CFO_bfefrmtrm_amount = double.parse(list4[0]['bfefrmtrm_amount'])/100000000;
    //d_Total_assets1 = double.parse(Total_Debt) / 100000000;
  }*/
/*  Future< Map<String, dynamic>> Dividend(*//*String StockCode*//*) async{
    const String _url = "https://opendart.fss.or.kr/api/alotMatter.json";
    const String _apiKey = "e50aac2aaa0bc5e55d91105ac6b5219b4992f32d";
    DateTime now = DateTime.now();
    DateTime Month = now.subtract(Duration(days:365));
    DateFormat formatter = DateFormat('yyyyMMdd');

    String strToday = formatter.format(now);
    String strMonth = formatter.format(Month);
    print(strMonth);
    //final String _endPoint = "$_url?crtfc_key=$_apiKey&corp_code="+dartCode+"";
    final String _endPoint = "$_url?crtfc_key=$_apiKey&corp_code=00126380&bsns_year=2021&reprt_code=11011";
    final http.Response _res = await http.get(_endPoint);
    var responseBody12 = _res.body;
    //_result = json.decode(_res.body);
    //print(responseBody12);
    Map<String, dynamic> dividend = json.decode(_res.body);
    print(dividend);
    return dividend;
  }*/
  @override
// TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
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