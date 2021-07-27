import 'package:get/get.dart';
import 'package:recipes_hub/core/controllers/AuthController.dart';
import 'package:recipes_hub/core/controllers/ListarRecetasController.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController(), permanent: true);
    Get.put<ListarRecetasController>(ListarRecetasController(),
        permanent: true);
  }
}
