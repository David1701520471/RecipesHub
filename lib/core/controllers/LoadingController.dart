
import 'package:get/get.dart';
import 'package:recipes_hub/meta/views/HomePage.dart';

class LoadingController extends GetxController{

  @override
  void onReady() {
    super.onReady();
    Future.delayed(Duration(seconds: 2),(){
      Get.to(
            ()=> HomePage(),
        transition: Transition.zoom,
      );
    });
  }
}