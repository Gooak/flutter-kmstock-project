import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:untitled/src/page/Financial/financial.dart';
import 'package:untitled/src/page/event/event.dart';
import 'package:untitled/src/page/homeMain/query_home.dart';
import 'package:untitled/src/page/homeMain/stock_theme.dart';
import 'package:untitled/src/page/homeMain/tap/news.dart';
import 'package:untitled/src/page/homeMain/tap/reportmain.dart';
import 'package:untitled/src/page/stockMain/stock.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:untitled/src/controller/app_controller.dart';

//오늘날짜 구하기


class HomeMain extends StatefulWidget {
  @override
  HomeMain_new createState() => HomeMain_new();
}
class HomeMain_new extends State<HomeMain>{
  Query_home query = Query_home();
  bool isLoading = false;

  String strToday ='';
  void getToday() {
    DateTime now = DateTime.now();
    DateTime today = now.subtract(Duration(days:1));
    DateFormat formatter = DateFormat('yyyyMMdd');
    strToday = formatter.format(today);
  }
  @override
  void initState() {
    setState(() {
      isLoading = true;
    });
    super.initState();
    getToday();
    Future.microtask(() async{
      getToday();
      //searchText = '동화약품';
/*    Future<String> Stock_Code;
    Stock_Code = Find_Stock_Code(searchText);
    Stock_Code.then((val) {
      // 종목코드가 나오면 해당 값을 출력
      print('val: $val');*/
      String hot_news = "SELECT * FROM stock.news where link is not null order by date desc, time desc limit 5;";
      String stock = "SELECT `종목명`,`현재가`,`등락율` from stock.db_" + strToday +
          " order by `등락율` Desc limit 5;";
      String kospi_kosdaq = "price";
      //String stock = "SELECT `종목명`,`현재가`,`등락율` from stock.db_20220418 order by `등락율` Desc limit 5;";
      await query.Find_kmstock();
      await query.Find_Kospi_kosdaq(kospi_kosdaq);
      await query.Find_hot_news(hot_news);
      await query.Find_stock(stock);
/*    }).catchError((error) {
      // error가 해당 에러를 출력
      print('error: $error');
    });*/
    });
    Future.delayed(Duration(seconds: 4), () {
      setState(() {
        super.setState(() {
          isLoading = false;
        });
      });
    });
    setState(() {
      super.setState(() {
      });
    });
  }

/*  Future<String> Find_Stock_Code(String Stock_Name) async
  {
    Search_Stock_Code = "SELECT 종목코드 FROM stock.db_20211115 WHERE 종목명 = '${Stock_Name}';";
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
  Widget _todayName(BuildContext context){
    return Container(
        margin: EdgeInsets.all(5),
        width: double.infinity,
        height: 50,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [SizedBox(width: 10,),
            Text(
          "KM_Stock 강추 TOP3",
          style: TextStyle(fontFamily: "text",fontWeight: FontWeight.bold, fontSize:30),)],
        ))
    ;
  }
  Widget _today(BuildContext context) {
    return GestureDetector(
      onTap: (){
        showDialog1();
      },
      child: Card(
        shape: RoundedRectangleBorder(  //모서리를 둥글게 하기 위해 사용
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 4,
        child: Container(
          margin: EdgeInsets.all(5),
          width: double.infinity,
          height: 230,
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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: EdgeInsets.all(5),
                        width: double.infinity,
                        height: 50,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [SizedBox(width: 10,), Text(
                            "KM_Stock 강추 TOP3",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),)],
                        )),
                    TextButton(
                      onPressed: () {
/*                    Navigator.push(context,
                            MaterialPageRoute(
                                builder: (context)=> Event()));*/
                        Get.to(() => Financial(), arguments: query.kmstock1.toString());
                      },
                      child: Text("1. ${query.kmstock1}",
                          style: TextStyle(fontSize: 20,)),
                    ),
                    TextButton(
                        onPressed: () {
/*                      Navigator.push(context,
                              MaterialPageRoute(
                                  builder: (context)=> Event()));*/
                          Get.to(() => Financial(), arguments: query.kmstock2.toString());
                        },
                        child: Text(
                          "2. ${query.kmstock2}",
                          style: TextStyle(fontSize: 20,),
                        )),
                    TextButton(
                        onPressed: () {
/*                      Navigator.push(context,
                              MaterialPageRoute(
                                  builder: (context)=> Event()));*/
                          Get.to(() => Financial(), arguments: query.kmstock3.toString());
                        },
                        child: Text(
                          "3. ${query.kmstock3}",
                          style: TextStyle(fontSize: 20,),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _issue_name(){
    return Container(
      width: double.infinity,
      height: 50,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Row(children: [
              SizedBox(width: 10,),
              Text(
                "국내 지수 (코스피 코스닥)",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ]),
          ),
        ],
      ),
    );
  }
  Widget _issue(BuildContext context) {
/*    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(
                builder: (context)=> Stock()));
      },
      child: new Container(
        width: double.infinity,
        height: 150,
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(width: 3, color: Colors.black))),
        child: Column(
          children: <Widget>[
            Expanded(
                child: Row(
              children: [
                Text(
                  "국내/해외지수",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                )
              ],
            )),
            Expanded(
              child: Row(children: [
                Text(
                  "KOSPI ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.red),
                ),
                Text(
                  "2,956.30 ▼ 3.16 (-0.11%)",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 8,
                      color: Colors.blue),
                ),
                Text(
                  "KOSDAQ ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.red),
                ),
                Text(
                  "953.11 ▼ 0.32 (-0.03%)",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 8,
                      color: Colors.blue),
                ),
              ]),
            ),
            Expanded(
              child: Row(
                children: [
                  Text(
                    "심천종합 ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.red),
                  ),
                  Text(
                    "2,413.92 ▲ 18.87 (+0.79%)",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 8,
                        color: Colors.red),
                  ),
                  Text(
                    "상해종합 ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.red),
                  ),
                  Text(
                    "3,592.17 ▲ 24.00 (+0.67%)",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 8,
                        color: Colors.red),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }*/
    return GestureDetector(
        onTap: (){
/*        Navigator.push(context,
              MaterialPageRoute(
                  builder: (context)=> Stock()));*/
          AppController.to.curretIndex.value=2;
        },
        child: Card(
          shape: RoundedRectangleBorder(  //모서리를 둥글게 하기 위해 사용
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 4,
          child: Container(
          margin: EdgeInsets.all(5),
          width: double.infinity,
          height: 180,
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
/*          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), //모서리를 둥글게
              border: Border.all(color: Colors.black12, width: 3)), //테*/
          child: Column(
            children: [
            Container(
            width: double.infinity,
            height: 50,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Row(children: [
                    SizedBox(width: 10,),
                    Text(
                      "국내 지수 (코스피 코스닥)",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ]),
                ),
              ],
            ),
          ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Center(
                      child: Container(
                        width: 170,
                        height: 120,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("KOSPI ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
                            Text(query.Kospi1,style: TextStyle(fontSize: 25),),
                            Text(query.Kospi2,style: query.Kospi2.contains('-')
                                ? TextStyle(fontWeight: FontWeight.bold, fontSize: 23, color: Colors.blue)
                                : TextStyle(fontWeight: FontWeight.bold, fontSize: 23, color: Colors.red)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Container(
                        width: 170,
                        height: 120,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("KOSDAQ ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
                            Text(query.Kospdaq1,style: TextStyle(fontSize: 25),),
                            Text(query.Kospdaq2,style: query.Kospdaq2.contains('-')
                                ? TextStyle(fontWeight: FontWeight.bold, fontSize: 23, color: Colors.blue)
                                : TextStyle(fontWeight: FontWeight.bold, fontSize: 23, color: Colors.red)),
                          ],
                        ),
                      ),
                    ),),
                ],
              ),
            ],
          ),),
      ),
    );
  }

  Widget _thema_name(){
    return Container(
      width: double.infinity,
      height: 50,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Row(children: [
              SizedBox(width: 10,),
              Text(
                "테마별 / 종목",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ]),
          ),
        ],
      ),
    );
  }
  Widget _thema(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(  //모서리를 둥글게 하기 위해 사용
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 4,
      child: Container(
        margin: EdgeInsets.all(5),
        width: double.infinity,
        height: 230,
/*      decoration: BoxDecoration(
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
        ),*/
/*        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), //모서리를 둥글게
            border: Border.all(color: Colors.black12, width: 3)), //테*/
        child: Column(
          children: [
          Container(
          width: double.infinity,
          height: 50,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Row(children: [
                  SizedBox(width: 10,),
                  Text(
                    "테마별 / 종목",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ]),
              ),
            ],
          ),
        ),
            Container(
              height: 150.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Container(
                    width: 160.0,
                    height: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Stack(children: [
                          SizedBox(
                              height: 130,
                              width: 150,
                              child: IconButton(
                                onPressed: () {
                                  Get.to(() => stock_theme(), arguments: ['반도체 장비']);
                                },
                                icon: Image.asset("images/반도체.jpg",),
                              )),
                          Positioned(top: 20,left: 10,
                              child: Container(
                                /*decoration: BoxDecoration(
                                  gradient: LinearGradient(begin: FractionalOffset.topCenter,
                                      end: FractionalOffset.bottomCenter,
                                      colors: [Colors.black, Colors.white]
                                  )
                                ), *///테두리
                            child: Text("반도체",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                          ))],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 160.0,
                    height: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Stack(children: [
                          SizedBox(
                              height: 130,
                              width: 150,
                              child: IconButton(
                                onPressed: () {
                                  Get.to(() => stock_theme(), arguments: ['보안주(정보)']);
                                },
                                icon: Image.asset("images/보안.jpg",),
                              )),
                          Positioned(top: 20,left: 10,
                              child: Container(
                                child: Text("보안",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                              ))],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 160.0,
                    height: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Stack(children: [
                          SizedBox(
                              height: 130,
                              width: 150,
                              child: IconButton(
                                onPressed: () {
                                  Get.to(() => stock_theme(), arguments: ['화장품']);
                                },
                                icon: Image.asset("images/나노.jpg",),
                              )),
                          Positioned(top: 20,left: 10,
                              child: Container(
                                child: Text("나노",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                              ))],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 160.0,
                    height: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Stack(children: [
                          SizedBox(
                              height: 130,
                              width: 150,
                              child: IconButton(
                                onPressed: () {
                                  Get.to(() => stock_theme(), arguments: ['제약업체']);
                                },
                                icon: Image.asset("images/약품.jpg",),
                              )),
                          Positioned(top: 20,left: 10,
                              child: Container(
                                child: Text("약품",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                              ))],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 160.0,
                    height: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Stack(children: [
                          SizedBox(
                              height: 130,
                              width: 150,
                              child: IconButton(
                                onPressed: () {
                                  Get.to(() => stock_theme(), arguments: ['게임']);
                                },
                                icon: Image.asset("images/게임.jpg",),
                              )),
                          Positioned(top: 20,left: 10,
                              child: Container(
                                child: Text("게임",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                              ))],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _volume(BuildContext context) {
    return GestureDetector(
        onTap: () {
/*        Navigator.push(context,
              MaterialPageRoute(
                  builder: (context)=> Stock()));*/
          AppController.to.curretIndex.value=2;
        },
        child: Card(
          shape: RoundedRectangleBorder(  //모서리를 둥글게 하기 위해 사용
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 4,
          child: Container(
          margin: EdgeInsets.all(5),
          width: double.infinity,
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
/*          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), //모서리를 둥글게
              border: Border.all(color: Colors.black12, width: 3)), //테*/
          child: Column(
            children: [
            Container(
            width: double.infinity,
            height: 50,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Row(children: [
                    SizedBox(width: 10,),
                    Text(
                      "간략 증시",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
                  headingRowHeight: 0,
                  columns: <DataColumn>[
                    DataColumn(
                      label: Text(
                        '',
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        '',
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        '',
                      ),
                    ),
                  ],
                  rows: <DataRow>[
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text(query.name1),),
                        DataCell(Text(query.current_price1,style: TextStyle(color: Colors.red))),
                        DataCell(Text(query.percent1+'%',style: TextStyle(color: Colors.red),)),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text(query.name2)),
                        DataCell(Text(query.current_price2,style: TextStyle(color: Colors.red))),
                        DataCell(Text(query.percent2+'%',style: TextStyle(color: Colors.red))),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text(query.name3)),
                        DataCell(Text(query.current_price3,style: TextStyle(color: Colors.red))),
                        DataCell(Text(query.percent3+'%',style: TextStyle(color: Colors.red))),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text(query.name4)),
                        DataCell(Text(query.current_price4,style: TextStyle(color: Colors.red))),
                        DataCell(Text(query.percent4+'%',style: TextStyle(color: Colors.red))),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text(query.name5)),
                        DataCell(Text(query.current_price5,style: TextStyle(color: Colors.red))),
                        DataCell(Text(query.percent5+'%',style: TextStyle(color: Colors.red))),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _news(BuildContext context) {
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
                child: Row(children: [SizedBox(width: 10,),Text("주요 뉴스",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),)],)
              )),
              Expanded(
                child: Card(
                    child: ListTile(
                      onTap: (){
                        Get.to(News(),arguments: query.link1);
                      },
                      title: Text(query.title1),
                      subtitle: Text(query.date1,style: const TextStyle(fontSize: 12),),
                    ),
                  ),
/*                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),*/
              ),
              Expanded(
                child: Card(
                    child: ListTile(
                      onTap: (){
                        Get.to(News(),arguments: query.link2);
                      },
                      title: Text(query.title2),
                      subtitle: Text(query.date2,style: const TextStyle(fontSize: 12),),
                    ),
                  ),
/*                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),*/

              ),
              Expanded(
                child: Card(
                  child: ListTile(
                    onTap: (){
                      Get.to(News(),arguments: query.link3);
                    },
                    title: Text(query.title3),
                    subtitle: Text(query.date3,style: const TextStyle(fontSize: 12),),
                  ),
                ),
/*                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),*/
              ),
              Expanded(
                child: Card(
                  child: ListTile(
                    onTap: (){
                      Get.to(News(),arguments: query.link4);
                    },
                    title: Text(query.title4),
                    subtitle: Text(query.date4,style: const TextStyle(fontSize: 12),),
                  ),
                ),
/*                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),*/
              ),
              Expanded(
                child: Card(
                  child: ListTile(
                    onTap: (){
                      Get.to(News(),arguments: query.link5);
                    },
                    title: Text(query.title5),
                    subtitle: Text(query.date5,style: const TextStyle(fontSize: 12),),
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



  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: Container(child: CircularProgressIndicator(),),)
        : ListView(
      children: [
        //_todayName(context),
        _today(context),
        //_issue_name(),
        _issue(context),
        //_thema_name(),
        _thema(context),
        _volume(context),
        _news(context),
      ]
    );
  }
  void showDialog1() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("km_score 란??"),
          content: SingleChildScrollView(child: new Text("Km_score는 매일 오후 8시 장 마감 후에 산출되며 인공지능(beta)과 Fscore, 차트 기술적 지표 등을 이용하여 매수를 판단하는 데 도움을 주는 점수입니다.\n\nTeam i5 가 권장하는 매매 방식은 장 마감 후 갱신된 Km_score를 확인하고 다음 날 해당 종목을 시초가격(장전시간외)에 진입합니다.\n\nKm_score를 사용하여 진입한 종목은 5% 수익 시 익절 3% 손실 시 손절이며 해당사항이 없을 시 10거래일 이후 매도하는 것입니다."),),
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
}
