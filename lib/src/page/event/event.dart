import 'package:flutter/material.dart';

import 'eventMain.dart';

class Event extends StatefulWidget {
  @override
  Event_main createState() => Event_main();
}
class Event_main extends State<Event> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("종목 발굴"),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(16.0),
          ),
        ),
      ),
      body: event(),/*(
        onRefresh:refresh,
        child: CustomScrollView(
        slivers: [
*//*          SliverAppBar(
            centerTitle: true,
            title: Text("종목 발굴"),
            floating: true,
            snap: true,
          ),*//*
          SliverList(
            delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  return GestureDetector(
                    onTap: () {},
                    child: event(),
                  );
                },
                childCount: 1,
              ),
            ),
        ],
      ),),*/
    );
  }

  Future<void> refresh() async {
    event_main main = event_main();
    main.initState();
    await Future.delayed(Duration(seconds: 2));
    main.setState(() {

    });
  }
}

