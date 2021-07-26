import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipes_hub/core/controllers/ListarRecetasController.dart';
import 'package:recipes_hub/meta/views/DetallesRecetaView.dart';
import 'package:recipes_hub/meta/widgets/NavigationDrawer.dart';

class ListarRecetasView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ListarRecetasController>(
      init: Get.find(),
      builder: (controller) => controller.loading.value
          ? Center(child: CircularProgressIndicator())
          : Scaffold(
              drawer: NavigationDrawer(),
              appBar: AppBar(
                title: Text(
                  "Recipe List ",
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
                        child: _listViewRecipes(),
                      )
                    ],
                  ),
                ),
              )),
    );
  }
}

Widget _listViewRecipes() {
  return GetBuilder<ListarRecetasController>(
    builder: (controller) => Container(
      height: 350,
      child: ListView.separated(
          itemCount: controller.recipeList.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () {
                  Get.to(() => DetallesRecetaView(
                      controller.recipeList[index], controller));
                },
                child: Container(
                    margin: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade100,
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(children: [
                          Container(
                            alignment: Alignment.topLeft,
                            height: 20,
                            width: MediaQuery.of(context).size.width * .3,
                            child: Text(
                              'Receta: ${controller.recipeList[index].nombre}',
                            ),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            height: 50,
                            width: MediaQuery.of(context).size.width * .3,
                            child: Text(
                              'Descripcion: ${controller.recipeList[index].descripcion} ',
                              maxLines: 5,
                            ),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            height: 20,
                            width: MediaQuery.of(context).size.width * .3,
                            child: Text(
                              'Dificultad: ${controller.recipeList[index].dificultad}',
                            ),
                          ),
                        ]),
                        ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: controller.seleccionarImagen(
                                controller.recipeList[index].imagenes.first,
                                context)),
                      ],
                    )));
          },
          separatorBuilder: (context, index) => SizedBox(
                width: 5,
              )),
    ),
  );
}
