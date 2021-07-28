import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:recipes_hub/core/controllers/ComentariosController.dart';
import 'package:recipes_hub/meta/widgets/NavigationDrawer.dart';

class ComentariosView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ComentariosController>(
        init: Get.find(),
        builder: (controller) {
          if (controller.loading.value) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Scaffold(
                drawer: NavigationDrawer(),
                appBar: AppBar(
                  title: Text(
                    "Comments ",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                body: SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(top: 20, left: 10, right: 10),
                    child: Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 25),
                          height: MediaQuery.of(context).size.height,
                          width: double.infinity,
                          child: _listComents(),
                        )
                      ],
                    ),
                  ),
                ));
          }
        });
  }
}

Widget _listComents() {
  return GetBuilder<ComentariosController>(
    builder: (controller) => Container(
      child: ListView.separated(
          itemCount: controller.comentarios.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () {
                  //TODO: en algun momento poder ir al usuario del comentario
                },
                child: Container(
                  height: MediaQuery.of(context).size.height / 15,
                  margin: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          height: 20,
                          width: MediaQuery.of(context).size.width * .2,
                          child: Text(
                            controller.comentarios[index].userName,
                            maxLines: 2,
                          ),
                        ),
                        Text('|'),
                        Expanded(
                          child: Container(
                            alignment: Alignment.topLeft,
                            width: MediaQuery.of(context).size.width * .6,
                            child: Text(
                              controller.comentarios[index].comentario,
                              maxLines: null,
                            ),
                          ),
                        )
                      ]),
                ));
          },
          separatorBuilder: (context, index) => SizedBox(
                width: 0,
              )),
    ),
  );
}
