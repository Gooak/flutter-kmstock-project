import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({Key? key}) : super(key: key);

  Widget name(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child: Text("재무제표"),
        ),
      ],
    );
  }
  Widget action(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: (){
            Get.toNamed("/search");
          },
          child: Container(
            width: 23,
            height: 23,
            child: Icon(Icons.search),
          ),
        )
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          name(),
          action(),
        ],
      ),
    );
  }
}
