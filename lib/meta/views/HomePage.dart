import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:recipes_hub/core/controllers/AuthController.dart';
import 'package:recipes_hub/core/controllers/TodoController.dart';
import 'package:recipes_hub/core/controllers/UserController.dart';
import 'package:recipes_hub/core/services/FireStoreDB.dart';
import 'package:recipes_hub/meta/widgets/TodoCard.dart';

class HomePage extends GetWidget<AuthController> {
  final TextEditingController _todoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GetX<UserController>(
          initState: (_) async {
            Get.find<UserController>().user =
            await FireStoreDB().getUser(Get.find<AuthController>().user.uid);
          },
          builder: (_) {
            if (_.user.email != null) {
              return Text(
                  "Welcome " + _.user.name,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold),);
            } else {
              return Text(
                  "loading...",
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold),);
            }
          },
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              controller.signOut();
            },
          ),
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              if (Get.isDarkMode) {
                Get.changeTheme(ThemeData.light());
              } else {
                Get.changeTheme(ThemeData.dark());
              }
            },
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Text(
            "Add Todo Here:",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Card(
            margin: EdgeInsets.all(20),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _todoController,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      if (_todoController.text != "") {
                        FireStoreDB()
                            .addTodo(_todoController.text, controller.user.uid);
                        _todoController.clear();
                      }
                    },
                  )
                ],
              ),
            ),
          ),
          Text(
            "Your Todos",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          GetX<TodoController>(
            init: Get.put<TodoController>(TodoController()),
            builder: (TodoController todoController) {
              if (todoController != null && todoController.todos != null) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: todoController.todos.length,
                    itemBuilder: (_, index) {
                      return TodoCard(
                          uid: controller.user.uid,
                          todo: todoController.todos[index]);
                    },
                  ),
                );
              } else {
                return Text("loading...");
              }
            },
          )
        ],
      ),
    );
  }
}