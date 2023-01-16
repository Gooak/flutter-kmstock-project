import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/src/page/Financial/financial.dart';
import 'package:untitled/src/page/Financial/financialMain.dart';
import 'package:untitled/src/page/Financial/opendart/opendart.dart';
import 'dart:convert';
import 'package:webview_flutter/webview_flutter.dart';

class stock_theme extends StatefulWidget {
  @override
  Stock_theme createState() => Stock_theme();
}
String Color = "";

class Stock_theme extends State<stock_theme> {
  late String str =Get.arguments[0];
  List? _dartData;
  int _pageIndex = 1;

  @override
  void initState() {
    Future.microtask(() async{
      _dartData = await _connect(index: _pageIndex.toString());
      setState(() {});
      return;
    });
    super.initState();
  }
/*  void initState() {
    connect();
    super.initState();
  }*/
/*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:Text("공시정보"),
      ),
      body: Container(),
    );
  }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(centerTitle: true,title: Text("테마주 "+str),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(16.0),
            ),
          ),),
        body: SafeArea(
          child: _dartData == null
              ? Center(child: Text("load..."),)
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
                      title: Text(_dartData![index]['\uc885\ubaa9\uba85'].toString()),
                      subtitle: Text(_dartData![index]['\uc885\ubaa9\uba85']),
                      trailing: Text(_dartData![index]['\ud3c9\uade0\ub4f1\ub77d\uc728'].toString()+"%",
                          style:  _dartData![index]['\ud3c9\uade0\ub4f1\ub77d\uc728'].toString().contains('-')
                          ? TextStyle(color: Colors.blue)
                          : TextStyle(color: Colors.red)),
                      onTap: (){
                        Get.to(() => Financial(/*Scaffold(
                          body:SafeArea(
                            child: CustomScrollView(
                              slivers: [
                                SliverAppBar(
                                  centerTitle: true,
                                  title: Text("재무제표"),
                                  floating: true,
                                  snap: true,
                                  actions: [
                                    IconButton(onPressed:(){Get.to(() => DartStock(), arguments: _dartData![index]['\uc885\ubaa9\uba85']);}, icon: Text("공시"))
                                  ],
                                ),
                                SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                        (context, index) {
                                      return GestureDetector(
                                        onTap: (){},
                                        child: Fin(),
                                      );
                                    },
                                    childCount: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),*/
                        ),arguments: _dartData![index]['\uc885\ubaa9\uba85']);
                      },
                    ),
                );
              }
          ),
        )
    );
  }

  Future<List> _connect({required String index}) async{
    /*const String _url = "https://opendart.fss.or.kr/api/list.json";
    const String _apiKey = "e50aac2aaa0bc5e55d91105ac6b5219b4992f32d";
    final _dateTime = DateTime.now();
    final String _endPoint = "$_url?crtfc_key=$_apiKey&bgn_de=${_dateTime.year.toString()+ (( _dateTime.month.toString().length < 2) ? '0${_dateTime.month.toString()}': _dateTime.month.toString()) +'01'}&page_no=$index&page_count=100";
    final http.Response _res = await http.get(_endPoint);
    var responseBody1 = _res.body;
    print("responseBody: ${responseBody1}");

    final Map<String, dynamic> _result = json.decode(_res.body);*/
    String url1 = "http://kmuproject.kro.kr:5568/sql/${"SELECT * FROM stock.stock_theme where `테마명` = "+"'"+str+"'"+";"}";
    String Changed_String1 = url1.replaceAll(' ', '!');
    var response1 = await http.get(Uri.parse(Changed_String1));

    var statusCode1 = response1.statusCode;
    var responseHeaders1 = response1.headers;
    var responseBody1 = response1.body;

    List _result = jsonDecode(responseBody1);

    //print("statusCode: ${statusCode1}");
    //print("responseHeaders: ${responseHeaders1}");
    print("responseBody: ${responseBody1}");
    /*if(['\ud3c9\uade0\ub4f1\ub77d\uc728'].toString().contains("-")) {
      String Color = "blue";
    }
    else {
      String Color = "blue";
    }*/
    return _result;
  }

/*  Future<List> connect() async {
    String url1 = "http://kmuproject.kro.kr:5568/sql/${"SELECT * FROM stock.stock_theme where `테마명` = "+"'"+str+"'"+";"}";
    //String url1 = "http://kmuproject.kro.kr:5568/sql/${"SELECT * FROM stock.stock_theme where `테마명` = `비철금속`;"}";
    String Changed_String1 = url1.replaceAll(' ', '!');
    var response1 = await http.get(Changed_String1);

    var statusCode1 = response1.statusCode;
    var responseHeaders1 = response1.headers;
    var responseBody1 = response1.body;

    List _result = jsonDecode(responseBody1);

    //print("statusCode: ${statusCode1}");
    //print("responseHeaders: ${responseHeaders1}");
    print("responseBody: ${responseBody1}");
    return _result;
  }*/
}