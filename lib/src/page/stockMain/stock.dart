import 'package:flutter/material.dart';
import 'package:untitled/src/page/stockMain/tap/internal.dart';
import 'package:untitled/src/page/stockMain/tap/overseas.dart';

class Stock extends StatefulWidget {
  @override
  Stock_page createState() => Stock_page();
}

class Stock_page extends State<Stock> {
  // This function show the sliver app bar
  // It will be called in each child of the TabBarView
  /*SliverAppBar showSliverAppBar(String screenTitle) {
    return SliverAppBar(
      centerTitle: true,
      floating: true,
      pinned: true,
      snap: false,
      title: Text("증시 시황"),
      bottom: TabBar(
        tabs: [
          Tab(
            text: '국내',
          ),
          Tab(
            text: '해외',
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DefaultTabController(
          length: 2,
          child: TabBarView(children: [
            // This CustomScrollView display the Home tab content
            CustomScrollView(
              slivers: [
                showSliverAppBar('국내'),

                // Anther sliver widget: SliverList
                SliverList(
                  delegate: SliverChildListDelegate([
                    Internal(),
                  ]),
                ),
              ],
            ),

            // This shows the Settings tab content
            CustomScrollView(
              slivers: [
                showSliverAppBar('해외'),
                // Show other sliver stuff
                SliverList(
                  delegate: SliverChildListDelegate([
                    Overseas(),
                  ]),
                ),
              ],
            )
          ]),
        ));*/
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("증시시황"),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(16.0),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh:refresh,
        child: CustomScrollView(
          slivers: [
/*          SliverAppBar(
            centerTitle: true,
            title: Text("종목 발굴"),
            floating: true,
            snap: true,
          ),*/
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  return GestureDetector(
                    onTap: (){},
                    child: Internal(),
                  );
                },
                childCount: 1,
              ),
            ),
          ],
        ),),
    );
  }
  Future<void> refresh() async {
    Internal_main main = Internal_main();
    main.initState();
    await Future.delayed(Duration(seconds: 2));
    main.setState(() {
    });
  }
}
