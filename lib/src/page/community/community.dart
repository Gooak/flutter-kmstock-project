import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cp949/cp949.dart' as cp949;
import 'package:intl/intl.dart';
import 'package:untitled/src/page/Financial/query.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Community extends StatefulWidget {
  @override
  Community_main createState() => Community_main();
}


class Community_main extends State<Community> {
  TextEditingController inputController = TextEditingController();
  String inputText = '삼성전자';

  String stockcode ="";
  String dartCode ="";
  String rcept_no= "";

  List? _dartData = [];
  int _pageIndex = 1;
  bool isLoading = false;

/*  void initState() {
    Future.microtask(() async{
      _dartData = await _connect(index: _pageIndex.toString());
      setState(() {});
      return;
    });
    super.initState();
  }*/
  void initState() {
    setState(() {
      isLoading = true;
    });
    Future<String> Stock_Code;
    Stock_Code = Find_Stock_Code(inputText);
    print(Stock_Code);
    Stock_Code.then((val) async {
      // 종목코드가 나오면 해당 값을 출력
      if(val==null){
        print("값없음");
      }
      print('val: $val');
      stockcode = val;
        Future.microtask(() async{
          _dartData = null;
          _dartData = await _connect1(index: _pageIndex.toString());
          setState(() {});
          return;
        });
    }).catchError((error) {
      // error가 해당 에러를 출력
      print('error: $error');
    });
    setState(() {
      isLoading = false;
    });
    super.initState();
  }
  /*Widget build(BuildContext context) {
    return Scaffold(
      appBar: (AppBar(
        centerTitle: true,
        title:Text("커뮤니티"),
      )),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh:refresh,
          child:CustomScrollView(
          slivers: [
            SliverAppBar(
              centerTitle: true,
              title:  TextField(
                controller: inputController,
                decoration: InputDecoration(
                  fillColor: Colors.white.withOpacity(0.2),
                  filled: true,
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              floating: true,
              snap: true,
              //leading: IconButton(onPressed:(){}, icon: Icon(Icons.arrow_back)),
              actions: [
                IconButton(onPressed:(){
                  inputText = inputController.text;
                  Future<String> Stock_Code;
                  Stock_Code =Find_Stock_Code(inputText);
                  Stock_Code.then((val) async {
                    // 종목코드가 나오면 해당 값을 출력
                    print('val: $val');
                    stockcode = val;
                    void initState() {
                      Future.microtask(() async{
                        _dartData = null;
                        _dartData = await _connect1(index: _pageIndex.toString());
                        setState(() {});
                        return;
                      });
                      super.initState();
                    }
                    initState();
                  }).catchError((error) {
                    // error가 해당 에러를 출력
                    print('error: $error');
                  });
                }, icon: Icon(Icons.search))
              ],
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  return SafeArea(
                    child: _dartData == null
                        ? Center(child: Text("load..."),)
                        : ListView.builder(
                        shrinkWrap: true,
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
                              title: Text(_dartData![index]['title'].toString()),
                              subtitle: Text(_dartData![index]['date']+"  글쓴이"+_dartData![index]['writer']+" 조회수"+_dartData![index]['views']+" 공감"+_dartData![index]['pos']+" 비공감"+_dartData![index]['neg']),
                            ),
                          );
                        }
                    ),
                  );
                },
                childCount: 1,
              ),
            ),
          ],
        ),),
      ),
    );
  }*/
    void _showDialog1() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("자세히보기"),
          content: SingleChildScrollView(child: new Text("잘못 입력하셨습니다."),),
        );
      },
    );
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (AppBar(
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(16.0),
          ),
        ),
        title:Text("커뮤니티[${inputText}]"),
        bottom: AppBar(
          toolbarHeight: 50, // Set this height
          flexibleSpace: Container(
            child: Column(children: <Widget>[
              Container(
                  height: 40,
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: TextField(
                    controller: inputController,
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: IconButton(onPressed:(){
                          inputText = inputController.text;
                          print(inputText);
                          page(inputText);
                        }, icon: Icon(Icons.search, color: Colors.black,)),
                        border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(40))),
                        hintStyle: new TextStyle(color: Colors.black38),
                        hintText: "Search"),
                  )),
            ]),
          ),
        ),
      )),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh:refresh,
          child: isLoading
              ? Center(child: Container(child: CircularProgressIndicator(),),)
              : SafeArea(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: _dartData?.length,
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
                                title: Text(_dartData![index]['title'].toString()),
                                subtitle: Text(_dartData![index]['date']+"  글쓴이:"+_dartData![index]['writer']+" \n조회수:"+_dartData![index]['views']+" 공감:"+_dartData![index]['pos']+" 비공감:"+_dartData![index]['neg']),
                              ),
                            );
                          }
                      ),
                    ),
                ),
              ),
          );
  }

  Future<void> refresh() async {
    initState();
    await Future.delayed(Duration(seconds: 2));
    setState(() {

    });
  }
  Future<String> Find_Stock_Code(String Stock_Name) async
  {
    String Search_Stock_Code = "SELECT 종목코드 FROM stock.db_20220524 WHERE 종목명 = '${Stock_Name}';";
    String url = "http:///sql/${Search_Stock_Code}";
    String Changed_String = url.replaceAll(' ', '!');
    var response = await http.get(Uri.parse(Changed_String));

    var statusCode = response.statusCode;
    var responseHeaders = response.headers;
    var responseBody = response.body;
    List list = jsonDecode(responseBody);

    /* print("statusCode: ${statusCode}");
    print("responseHeaders: ${responseHeaders}");
    print("responseBody: ${responseBody}");*/
    return list[0]['종목코드'];
  }

  Future<List> _connect({required String index}) async{
    String url = "http:///board/005930/5";
    String Changed_String1 = url.replaceAll(' ', '!');
    var response1= await http.get(Uri.parse(Changed_String1));

    var responseBody1 = response1.body;

    List _result = jsonDecode(responseBody1);

    //print("responseBody: ${responseBody1}");
    //print(_result);
    return _result;
  }
  Future<List> _connect1({required String index}) async{
    String url = "http:///board/${stockcode}/5";
    String Changed_String1 = url.replaceAll(' ', '!');
    var response1= await http.get(Uri.parse(Changed_String1));

    var responseBody1 = response1.body;

    List _result = jsonDecode(responseBody1);

    //print("responseBody: ${responseBody1}");
    //print(_result);
    return _result;
  }

  Future<bool> page(String data) async {
    String Search_Stock_Code = "SELECT 종목코드 FROM stock.db_20220524 WHERE 종목명 = '${data}';";
    String url = "http://sql/${Search_Stock_Code}";
    String Changed_String = url.replaceAll(' ', '!');
    var client = new http.Client();
    try {
      http.Response response = await client.get(Uri.parse(Changed_String));
      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body); // json 응답 값을 decode
        // jsonBody를 바탕으로 data 핸들링
        Future<String> Stock_Code;
        Stock_Code = Find_Stock_Code(inputText);
        print(Stock_Code);
        Stock_Code.then((val) async {
          // 종목코드가 나오면 해당 값을 출력
          if(val==null){
            print("값없음");
          }
          print('val: $val');
          stockcode = val;
          void initState() {
            setState(() {
              isLoading = true;
            });
            Future.microtask(() async{
              _dartData = null;
              _dartData = await _connect1(index: _pageIndex.toString());
              setState(() {});
              return;
            });
            super.initState();
          }
          initState();
        }).catchError((error) {
          // error가 해당 에러를 출력
          print('error: $error');
        });
        Future.delayed(Duration(seconds: 2), () {
          setState(() {
            super.setState(() {
              isLoading = false;
            });
          });
        });
        return true;
      } else { // 200 안뜨면 에러
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(
                  Icons.clear,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Text(
                    '"${data}"의 주식 종목은 없습니다.',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        );
        return false;
      }
    } catch (e) {
      Exception(e);
    } finally {
      client.close();
    }
    return false;
  }
}

