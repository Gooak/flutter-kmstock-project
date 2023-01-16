import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Report extends StatelessWidget {
  const Report({Key? key}) : super(key: key);
  Widget scroll1(){
    return SingleChildScrollView(
      child: Container(
        height: 1000,
        color: Colors.grey.withOpacity((0.5)
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("리포트"),
        ),
      ),
      body: Column(children: [
        Container(
          height: 250,
          color: Colors.grey.withOpacity((0.5)
          ),
        ),
        Expanded(child: scroll1(),)
      ],),
    );
  }
}
