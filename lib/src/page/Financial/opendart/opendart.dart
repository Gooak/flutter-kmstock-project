import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:untitled/src/page/Financial/stock_main.dart';
import 'dart:convert';
import 'package:webview_flutter/webview_flutter.dart';

import '../financial.dart';
import '../financial_candlechart.dart';

class DartStock extends StatefulWidget {
  @override
  _DartStockState createState() => _DartStockState();
}

class _DartStockState extends State<DartStock> with AutomaticKeepAliveClientMixin{
  final Completer<WebViewController> _controller = Completer<WebViewController>();

  String StockCode = stockCode;
  String dartCode = '';
  String rcept_no= "";

  @override
  List? _dartData;
  int _pageIndex = 1;

  @override
  void initState() {
    // TODO: implement initState
    Future.microtask(() async{
      _dartData = await _connect(index: _pageIndex.toString());
      setState(() {});
      return;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        /*appBar: AppBar(centerTitle: true,title: Text("공시정보"),),*/
        body: SafeArea(
          child: _dartData == null
              ? Center(child: Container(child: CircularProgressIndicator(),),)
              : ListView.builder(
              itemCount: _dartData!.length+1,
              itemBuilder: (BuildContext context, int index){
                if(index == _dartData!.length) return Container(
                  child: Center(
                      child: TextButton(
                        child: Text(""),
                        onPressed: () async{
                          _pageIndex++;
                          setState(() {});
                          return;
                        },
                      )
                  ),
                );
                return Card(
                  child: ListTile(
                    title: Text(_dartData![index]['report_nm'].toString()),
                    subtitle: Text(_dartData![index]['rcept_no']),
                    onTap: () => Navigator.of(context).push<void>(
                        MaterialPageRoute(
                            builder: (BuildContext context) => Scaffold(
                              appBar: AppBar(centerTitle:true,title: Text(_dartData![index]['corp_name'].toString()),),
                              body: SafeArea(
                                child: WebView(
                                  initialUrl: "https://dart.fss.or.kr/dsaf001/main.do?rcpNo=${_dartData![index]['rcept_no'].toString()}",
                                  javascriptMode: JavascriptMode.unrestricted,
                                ),
                              ),
                            )
                        )
                    ),
                  ),
                );
              }
          ),
        )
    );
  }

  Future<List> _connect({required String index}) async{
    FinancialState fb = FinancialState();
    print(fb.name);
    String Search_Stock_Code = "SELECT 종목코드 FROM stock.db_20220524 WHERE 종목명 = '${fb.name}';";
    String url = "http://kmuproject.kro.kr:5568/sql/${Search_Stock_Code}";
    String Changed_String = url.replaceAll(' ', '!');
    var response = await http.get(Uri.parse(Changed_String));

    var statusCode = response.statusCode;
    var responseHeaders = response.headers;
    var responseBody = response.body;
    List<dynamic> list = jsonDecode(responseBody);


    String url1 = "http://kmuproject.kro.kr:5568/sql/${"SELECT * FROM stock.dartcode where stockcode = "+list[0]['종목코드']+";"}";
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

    print(dartCode);
    const String _url = "https://opendart.fss.or.kr/api/list.json";
    const String _apiKey = "e50aac2aaa0bc5e55d91105ac6b5219b4992f32d";
    DateTime now = DateTime.now();
    DateTime Month = now.subtract(Duration(days:365));
    DateFormat formatter = DateFormat('yyyyMMdd');

    String strToday = formatter.format(now);
    String strMonth = formatter.format(Month);
    print(strMonth);
    //final String _endPoint = "$_url?crtfc_key=$_apiKey&corp_code="+dartCode+"&bgn_de="+strMonth+"&end_de="+strToday+"";
    final String _endPoint = "https://opendart.fss.or.kr/api/list.json?crtfc_key=e50aac2aaa0bc5e55d91105ac6b5219b4992f32d&corp_code=${dartCode}&bgn_de=${strMonth}&end_de${strToday}";
    final http.Response _res = await http.get(Uri.parse(_endPoint));
    var responseBody12 = _res.body;

    print("responseBody: ${responseBody12}");

    final Map<String, dynamic> _result = json.decode(_res.body);

    //rcept_no = _result['list'][0]["rcept_no"].toString();
    print(_result['list']);
    return _result['list'];
    print(dartCode);
    print(rcept_no);
  }
  @override
// TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
