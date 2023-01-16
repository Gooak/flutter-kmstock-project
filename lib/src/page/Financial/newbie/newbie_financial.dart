/*
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:project2/src/page/Financial/opendart/opendart.dart';
import 'newbie_financialMain.dart';

class Newbie_Financial extends StatelessWidget {
   Newbie_Financial({Key? key}) : super(key: key);

   String name =Get.arguments;

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       body:SafeArea(
         child: CustomScrollView(
           slivers: [
             SliverAppBar(
               centerTitle: true,
                 title:Text("초보자 재무제표"),
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
                     child: Newbie_Fin(),
                   );
                 },
                 childCount: 1,
               ),
             ),
           ],
         ),
       ),
     );
   }
}
*/
