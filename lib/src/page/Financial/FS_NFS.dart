import 'package:flutter/material.dart';
import 'package:untitled/src/page/Financial/financialMain.dart';
import 'package:untitled/src/page/Financial/search.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'dart:convert';
//import 'dart:html';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:untitled/src/page/Financial/query.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'Financial_Statements.dart';
import 'financial.dart';
import 'financial_candlechart.dart';
import 'financial_chart.dart';
import 'package:http/http.dart' as https;
import 'package:meta/meta.dart';
import 'dart:convert';

import 'newbie/newbie_Financial_Statements.dart';
import 'opendart/opendart.dart';

class FS_NFS extends StatelessWidget {
  FS_NFS({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(16.0),
              ),
            ),
            title: TabBar(
              tabs: [
                Tab(text: "일반사용자"),
                Tab(text: "초보자"),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              FS(),
              Newbie_Fin(),
            ],
          ),
        ),
    );
  }
}
