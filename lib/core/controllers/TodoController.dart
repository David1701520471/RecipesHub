import 'package:get/get.dart';
import 'package:recipes_hub/core/controllers/AuthController.dart';
import 'package:recipes_hub/core/controllers/bindings/AuthBinding.dart';
import 'package:recipes_hub/models/TodoModel.dart';
import 'package:recipes_hub/core/services/FireStoreDB.dart';

class TodoController extends GetxController {
  Rx<List<TodoModel>> todoList = Rx<List<TodoModel>>();

  List<TodoModel> get todos => todoList.value;

  @override
  void onInit() {
    String uid = Get.find<AuthController>().user.uid;
    todoList
        .bindStream(Database().todoStream(uid)); //stream coming from firebase
  }
}