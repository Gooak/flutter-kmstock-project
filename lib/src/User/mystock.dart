import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:untitled/src/controller/auth_controller.dart';

import '../page/Financial/financial.dart';


class mystock extends StatefulWidget {
  @override
  mystock_main createState() => mystock_main();
}

class mystock_main extends State<mystock> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  TextEditingController _stockname = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _quantity = TextEditingController();

  int purchase_amount_int =0;
  String purchase_amount ='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text("내 주식목록"),
      centerTitle: true,),
      body: ListView(
        children: <Widget>[
          Container(
            height: 500,
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('userstock')
                  .where('uid', isEqualTo: AuthController.to.user.value.uid)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) return Text("Error: ${snapshot.error}");
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Loading...")
                          ],
                        ));
                  default:
                    return ListView(
                      children: snapshot.data!.docs
                          .map((DocumentSnapshot document) {
                        document['datetime'];
                        return Card(
                          elevation: 2,
                          child: InkWell(
                            // Read Document
                            onTap: () {
                              Get.to(() => Financial(),arguments: document['name']);
                            },
                            // Update or Delete Document
                            onLongPress: () {
                              showUpdateOrDeleteDocDialog(document);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        document['name'],
                                  style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                  Text(
                                    document['price']+'원',
                                    style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                      Text(
                                        document['quantity']+'개',
                                        style: TextStyle(
                                          color: Colors.blueGrey,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        document['purchase_amount']+'원',
                                        style: TextStyle(
                                          color: Colors.blueGrey,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                ],
                                ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      document['datetime'],
                                      style: TextStyle(color: Colors.black54),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                }
              },
            ),
          )
        ],
      ),
      // Create Document
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add), onPressed: showCreateDocDialog),
    );
  }

  /// Firestore CRUD Logic

/*
  // 문서 생성 (Create)
  */
void createDoc(String name, String price, String quantity, String purchaseAmount) {
  DateTime now = DateTime.now();
  DateFormat formatter = DateFormat('yyyy-MM-dd hh:mm');
  String strToday = formatter.format(now);
    FirebaseFirestore.instance.collection('userstock').add({
      'uid' : AuthController.to.user.value.uid,
      'name': name,
      'price': price,
      'quantity': quantity,
      'purchase_amount' : purchaseAmount,
      'datetime' : strToday.toString(),
    });
  }

  // 문서 조회 (Read)
/*  void showDocument(String name) {
    FirebaseFirestore.instance
        .collection('userstock')
        .doc(name)
        .get()
        .then((doc) {
      showReadDocSnackBar(doc);
    });
  }*/

  // 문서 갱신 (Update)
  void updateDoc(String id, String price, String quantity, String purchaseAmount) {
    print(price);
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('yyyy-MM-dd hh:mm');
    String strToday = formatter.format(now);
    FirebaseFirestore.instance.collection('userstock').doc(id).update({
      'price': price,
      'quantity': quantity,
      'purchase_amount' : purchaseAmount,
      'datetime' : strToday.toString(),
    });
  }

  // 문서 삭제 (Delete)
  void deleteDoc(String id) {
    FirebaseFirestore.instance.collection('userstock')
        .doc(id)
        .delete();
  }


  void showCreateDocDialog() {
    _stockname.clear();
    _price.clear();
    _quantity.clear();
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("주식 입력"),
          content: Container(
            height: 200,
            child: Column(
              children: <Widget>[
                TextField(
                  autofocus: true,
                  decoration: InputDecoration(labelText: "주식이름"),
                  controller: _stockname,
                ),
                TextField(
                  decoration: InputDecoration(labelText: "단가"),
                  controller: _price,
                ),

                TextField(
                  decoration: InputDecoration(labelText: "수량"),
                  controller: _quantity,
                )
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Cancel"),
              onPressed: () {
                _stockname.clear();
                _price.clear();
                _quantity.clear();
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text("Create"),
              onPressed: () {
                if (_stockname.text.isNotEmpty &&
                    _price.text.isNotEmpty && _quantity.text.isNotEmpty) {
                  purchase_amount_int = int.parse(_price.text)*int.parse(_quantity.text);
                  purchase_amount = purchase_amount_int.toString();
                  createDoc(_stockname.text, _price.text,_quantity.text, purchase_amount);
                }
                _stockname.clear();
                _price.clear();
                _quantity.clear();
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

/*  void showReadDocSnackBar(DocumentSnapshot doc) {
    _scaffoldKey.currentState
      ?.hideCurrentSnackBar()
      ?.showSnackBar(
        SnackBar(
          backgroundColor: Colors.deepOrangeAccent,
          duration: Duration(seconds: 5),
          content: Text(
              "$fnName: ${doc[fnName]}\n$fnDescription: ${doc[fnDescription]}"
                  "\n$fnDatetime: ${timestampToStrDateTime(doc[fnDatetime])}"),
          action: SnackBarAction(
            label: "Done",
            textColor: Colors.white,
            onPressed: () {},
          ),
        ),
      );
  }*/

  void showUpdateOrDeleteDocDialog(DocumentSnapshot doc) {
    _stockname.text = doc['name'];
    _price.text = doc['price'];
   _quantity.text = doc['quantity'];

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(doc['name']),
          content: Container(
            height: 200,
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(labelText: "단가"),
                  controller: _price,
                ),
                TextField(
                  decoration: InputDecoration(labelText: '수량'),
                  controller: _quantity,
                )
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Cancel"),
              onPressed: () {
                _stockname.clear();
                _price.clear();
                _quantity.clear();
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text("Update"),
              onPressed: () {
                if (_stockname.text.isNotEmpty &&
                    _price.text.isNotEmpty && _quantity.text.isNotEmpty) {
                  purchase_amount_int = int.parse(_price.text)*int.parse(_quantity.text);
                  purchase_amount = purchase_amount_int.toString();
                  updateDoc(doc.id, _price.text, _quantity.text, purchase_amount);
                }
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text("Delete"),
              onPressed: () {
                deleteDoc(doc.id);
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
}