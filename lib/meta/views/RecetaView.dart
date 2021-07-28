import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipes_hub/core/controllers/RecetaController.dart';
import 'package:recipes_hub/meta/widgets/CheckBoxList.dart';
import 'package:recipes_hub/meta/widgets/FormularioReceta/CardsDeListado.dart';
import 'package:recipes_hub/meta/widgets/FormularioReceta/ImagenesCard.dart';
import 'package:recipes_hub/meta/widgets/FormularioReceta/ListarDificultad.dart';
import 'package:recipes_hub/meta/widgets/FormularioReceta/ListarNumeros.dart';
import 'package:recipes_hub/meta/widgets/NavigationDrawer.dart';

class RecetaView extends GetWidget<RecetaController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RecetaController>(
      init: RecetaController(),
      builder: (_) => Scaffold(
        drawer: NavigationDrawer(),
        appBar: AppBar(
          title: Text(
            "Formulario de receta ",
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: ListView(children: <Widget>[
          Form(
            key: _.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Nombre de la receta',
                      icon: Icon(Icons.food_bank_outlined)),
                  onChanged: (name) {
                    _.formResult.nombre = name;
                    print(name);
                  },
                  validator: (name) {
                    return _.validarNombre(name);
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Descripcion de la receta',
                      icon: Icon(Icons.food_bank_outlined)),
                  onChanged: (description) {
                    _.formResult.descripcion = description;
                  },
                ),
                //pasos
                Card(
                  margin: EdgeInsets.all(20),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Pasos',
                            ),
                            controller: _.pasosController,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            _.agregarPaso();
                          },
                        )
                      ],
                    ),
                  ),
                ),

                Obx(() => listarPasos(_)),
                //ingredientes
                Card(
                  margin: EdgeInsets.all(20),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Ingredientes',
                            ),
                            controller: _.ingredienteController,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            _.agregarIngrediente();
                          },
                        )
                      ],
                    ),
                  ),
                ),
                Obx(() => listarIngredientes(_)),
                SizedBox(
                  height: 20.0,
                ),
                Text("Duración"),
                Padding(
                  padding: const EdgeInsets.only(left: 100.0, right: 100.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      ListarNumeros(_, _.duracionH, "Horas"),
                      ListarNumeros(_, _.duracionM, "Minutos"),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text("Dificultad"),
                Padding(
                    padding: const EdgeInsets.only(left: 100.0, right: 100.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        ListarDificultad(_, _.dificultad),
                      ],
                    )),
                SizedBox(
                  height: 20.0,
                ),
                //Selector de imagenes
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30.0),
                      child: TextButton.icon(
                        autofocus: true,
                        icon: Icon(
                          Icons.photo_camera_outlined,
                          size: 40,
                        ),
                        onPressed: () {
                          _.getImage(ImageSource.gallery);
                        },
                        label: Text("Seleccionar foto"),
                      ),
                    ),
                    Obx(() {
                      if (_.selectedImageList.isEmpty) {
                        return Text("Seleccione una imagen desde galeria");
                      } else {
                        return listarImagenes(_);
                      }
                    }),
                  ],
                ),
                SizedBox(
                  height: 30.0,
                ),
                //Selector Categorias
                Text("Categorias"),
                Obx(() => listarCategorias(_)),
                //Boton de verificacion
                ElevatedButton(
                    child: Text('Enviar'),
                    onPressed: () {
                      _.formResult.categorias = _.categoriasSeleccionadasList;
                      _.formResult.duracion = _.setTiempo();
                      _.formResult.pasos = _.pasosList;
                      _.formResult.ingredientes = _.ingredientesList;
                      _.formResult.dificultad = _.dificultad;
                      _.formResult.imagenes = _.selectedImageListFile;

                      _.validarFormulario();
                    })
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

//Intente hacer esto un widget independiente pero salia un error toco a la mala :c
Widget listarPasos(RecetaController controller) {
  return ListView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: controller.pasos.length,
      itemBuilder: (_, index) {
        return CardsDeListado(controller, index, "pasos", controller.pasos);
      });
}

Widget listarIngredientes(RecetaController controller) {
  return ListView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: controller.ingredientes.length,
      itemBuilder: (_, index) {
        return CardsDeListado(
            controller, index, "ingredientes", controller.ingredientes);
      });
}

Widget listarCategorias(RecetaController controller) {
  return ListView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: controller.categoriasList.length,
      itemBuilder: (_, index) {
        return CheckBoxList(controller, index);
      });
}

Widget listarImagenes(RecetaController controller) {
  return GridView.builder(
      itemCount: controller.selectedImageList.length,
      shrinkWrap: true,
      physics: ScrollPhysics(),
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (_, index) => ImagenesCard(controller, index));
}
