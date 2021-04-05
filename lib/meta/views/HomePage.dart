
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipes_hub/core/controllers/HomeController.dart';



class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder:
          (_)=>Scaffold(
        body: Center(
          child: Text(_.num.toString()),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            _.increment();
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }

}