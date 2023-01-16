import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:untitled/src/page/Financial/newbie/newbie_financial.dart';
import 'package:http/http.dart' as https;
import 'financial.dart';
import 'financialMain.dart';

class search_fin extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<search_fin> {
  TextEditingController inputController = TextEditingController();
  String inputText = '';
  String stock ='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('종목'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(16.0),
          ),
        ),
      ),
      body: Card(
        shape: RoundedRectangleBorder(  //모서리를 둥글게 하기 위해 사용
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 4,
        child: Container(
          padding: EdgeInsets.only(top:50),
          margin: EdgeInsets.all(10),
          width: double.infinity,
          height: 500, //테두리
          child: Center(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
                      child: TextField(
                        controller: inputController,
                        decoration: InputDecoration(
                          labelText: 'Search',
                          hintText: 'Enter your Search',
                          labelStyle: TextStyle(color: Colors.redAccent),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                            BorderSide(width: 1, color: Colors.redAccent),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                            BorderSide(width: 1, color: Colors.redAccent),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    ElevatedButton(
                      style: Get.isDarkMode ? ElevatedButton.styleFrom(primary: Colors.black12) : ElevatedButton.styleFrom(primary: Colors.blue),
                      onPressed: () {
                        setState(() {
                          print(stock);
                          inputText = inputController.text;
                          page(inputText);
                        });
                      },
                      child: Text('검색'),
                    ),
                    /*ElevatedButton(
                      onPressed: () {
                        setState(() {
                          inputText = inputController.text;
                          Get.to(Newbie_Financial(),arguments: inputText);
                        });
                      },
                      child: Text('초보자용 검색'),
                    ),*/
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  Future<bool> page(String data) async {
    String Search_Stock_Code = "SELECT 종목코드 FROM stock.db_20220524 WHERE 종목명 = '${data}';";
    String url = "http://kmuproject.kro.kr:5568/sql/${Search_Stock_Code}";
    String Changed_String = url.replaceAll(' ', '!');
    var client = new https.Client();
    try {
      https.Response response = await client.get(Uri.parse(Changed_String));
      print(response.statusCode);
      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body); // json 응답 값을 decode
        // jsonBody를 바탕으로 data 핸들링
        Get.to(Financial(), arguments: inputText);
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
  void showDialog1() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          //title: new Text("자세히보기"),
          content: SingleChildScrollView(child: new Text("잘못 입력하셨습니다."),),
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

