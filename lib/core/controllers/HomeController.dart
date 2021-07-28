
import 'package:get/state_manager.dart';

class HomeController extends GetxController{
  int _num=0;

  int get num=>_num;




  void increment(){
    _num++;
    update();
  }
}