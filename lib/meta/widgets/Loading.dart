import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipes_hub/core/controllers/LoadingController.dart';

class Loading extends StatelessWidget{
  const Loading ({Key key}):super(key:key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoadingController>(
        init: LoadingController(),
        builder:
            (_)=> Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        )
    );
  }

}