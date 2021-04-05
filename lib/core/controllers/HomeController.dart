
import 'package:get/state_manager.dart';

class HomeController extends GetxController{
  int _num=0;

  int get num=>_num;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();

  }

  void increment(){
    _num++;
    update();
  }
}