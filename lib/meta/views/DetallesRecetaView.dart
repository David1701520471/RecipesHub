import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipes_hub/core/controllers/ListarRecetasController.dart';
import 'package:recipes_hub/meta/widgets/ListarCalificacion.dart';
import 'package:recipes_hub/models/Receta/RecetaListadoModel.dart';

class DetallesRecetaView extends StatelessWidget {
  RecetaListadoModel recipe;
  ListarRecetasController controller;
  DetallesRecetaView(
    this.recipe,
    this.controller,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 270,
              child: controller.listarImagenes(recipe.imagenes, context),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(18),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                            onPressed: () {
                              controller.verComentarios(recipe.id);
                            },
                            child: Row(
                              children: [
                                Text(
                                  'Ver comentarios',
                                ),
                                Icon(Icons.book),
                              ],
                            )),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Receta: ${recipe.nombre}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            padding: EdgeInsets.all(16),
                            width: MediaQuery.of(context).size.width * .4,
                            height: MediaQuery.of(context).size.height / 14,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.grey,
                                )),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  'Dificultad: ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15),
                                ),
                                Text(
                                  recipe.dificultad,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                          Container(
                              padding: EdgeInsets.all(16),
                              width: MediaQuery.of(context).size.width * .4,
                              height: MediaQuery.of(context).size.height / 14,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Colors.grey,
                                  )),
                              child: Column(
                                children: [
                                  scoreList(),
                                ],
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Descripcion',
                          maxLines: null,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          child: Text(
                            recipe.descripcion,
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Ingredientes :',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                          listarItems(recipe.ingredientes),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Pasos :',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                          listarItems(recipe.pasos),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  Expanded(
                    child: Form(
                      key: controller.formKey,
                      child: TextFormField(
                          maxLines: null,
                          decoration: InputDecoration(
                            icon: Icon(Icons.comment_bank_outlined),
                            hintText: 'Comentar',
                          ),
                          onChanged: (comentario) =>
                              controller.setComentario(comentario)),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      print(controller.comentario);
                      controller.validarComentario(recipe.id);
                      controller.setComentario(null);
                    },
                    child: Icon(Icons.send),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget listarItems(List<String> items) {
  return ListView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (_, index) {
        return Text(
          '${index + 1}. ${items[index]} ',
          style: TextStyle(fontSize: 18),
        );
      });
}

Widget scoreList() {
  return GetBuilder<ListarRecetasController>(
    builder: (controller) => ListarCalificacion(controller),
  );
}
