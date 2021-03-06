import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipes_hub/core/controllers/AuthController.dart';
import 'package:recipes_hub/core/controllers/ListarRecetasController.dart';
import 'package:recipes_hub/core/controllers/UserController.dart';
import 'package:recipes_hub/meta/views/ListarRecetasView.dart';
import 'package:recipes_hub/meta/views/Login.dart';

class Root extends GetWidget<AuthController> {
  @override
  Widget build(BuildContext context) {
    return GetX(
      initState: (_) async {
        Get.put<UserController>(UserController());
      },
      builder: (_) {
        if (Get.find<AuthController>().user?.uid != null) {
            Get.put<ListarRecetasController>(ListarRecetasController(),
              permanent: true);
          return ListarRecetasView();
        } else {
          return Login();
        }
      },
    );
  }
}
