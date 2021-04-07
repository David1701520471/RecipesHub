import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:recipes_hub/core/controllers/AuthController.dart';
import 'package:recipes_hub/core/controllers/UserController.dart';
import 'package:recipes_hub/meta/views/HomePage.dart';
import 'package:recipes_hub/meta/views/Login.dart';

class Root extends GetWidget<AuthController> {
  @override
  Widget build(BuildContext context) {
    return GetX(
      initState: (_) async {
        Get.put<UserController>(UserController());
      },
     /* builder: (_) {
        if (Get.find<AuthController>().user?.uid != null) {
          return HomePage();
        } else {
          return Login();
        }
      },*/
    );
  }
}