import 'package:flutter/material.dart';
import 'package:untitled/src/page/Financial/financ_stock.dart';
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
import 'package:untitled/src/page/Financial/stock_main.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'FS_NFS.dart';
import 'Financial_Statements.dart';
import 'financial.dart';
import 'financial_candlechart.dart';
import 'financial_chart.dart';
import 'package:http/http.dart' as https;
import 'package:meta/meta.dart';
import 'dart:convert';

import 'opendart/opendart.dart';

class Financial extends StatefulWidget {
  @override
  FinancialState createState() => FinancialState();
}

class FinancialState extends State<Financial> {
  String name = Get.arguments;
/*  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: true,
            title: Text("재무제표"),
            floating: true,
            snap: true,
            actions: [
              IconButton(onPressed:(){Get.to(() => DartStock(), arguments: [name]);}, icon: Text("공시"))
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
    ),
    );
  }*/
 // final choices = ['종목 정보', '차트"', '재무제표', '공시', '이름뭐더라'];


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(name),
          bottom: PreferredSize(
              preferredSize: Size.fromHeight(40),
            child : Align(
              alignment: Alignment.centerLeft,
             child : const TabBar(
            indicatorWeight: 5,
            indicatorSize: TabBarIndicatorSize.label,
            unselectedLabelColor: Color(0xFFDDDDDD),
            tabs: [
              Tab(text: "종목 정보"),
              Tab(text: "차트"),
              Tab(text: "재무제표"),
              Tab(text: "공시"),
              Tab(text: "종목 상세"),
            ],
            isScrollable: true,
            //labelPadding: EdgeInsets.only(left: 0, right: 0),
          ),
            )
          ),
        ),
        body: TabBarView(
          children: [
            StockMain(),
            Fin_Candle(),
            FS_NFS(),
            DartStock(),
            fin_stock(),
          ],
        ),
      ),
    );
  }
/*  SliverAppBar showSliverAppBar(String screenTitle) {
    return SliverAppBar(
      centerTitle: true,
      floating: true,
      pinned: true,
      snap: false,
      title: Text("재무제표"),
      bottom: TabBar(
        tabs: [
          Tab(
            text: '메인',
          ),
          Tab(
            text: '차트',
          ),
          Tab(
            text: '재무제표',
          ),
          Tab(
            text: '공시',
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DefaultTabController(
          length: 4,
          child: TabBarView(children: [
            // This CustomScrollView display the Home tab content
            CustomScrollView(
              slivers: [
                showSliverAppBar('메인'),
                // Anther sliver widget: SliverList
                SliverList(
                  delegate: SliverChildListDelegate([
                  ]),
                ),
              ],
            ),

            // This shows the Settings tab content
            CustomScrollView(
              slivers: [
                showSliverAppBar('차트'),
                // Anther sliver widget: SliverList
                SliverList(
                  delegate: SliverChildListDelegate([
                    Container(
                      child: Fin_Candle(),
                    )
                  ]),
                ),
              ],
            ),
            CustomScrollView(
              slivers: [
                showSliverAppBar('재무제표'),

                // Anther sliver widget: SliverList
                SliverList(
                  delegate: SliverChildListDelegate([
                  ]),
                ),
              ],
            ),
            CustomScrollView(
              slivers: [
                showSliverAppBar('공시'),
                // Anther sliver widget: SliverList
                DartStock(),
              ],
            ),
          ]),
        ));
  }*/
}
