import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipes_hub/core/controllers/AuthController.dart';
import 'package:recipes_hub/core/controllers/ComentariosController.dart';
import 'package:recipes_hub/core/services/FireStoreDB.dart';
import 'package:recipes_hub/meta/views/ComentariosView.dart';
import 'package:recipes_hub/models/Receta/RecetaListadoModel.dart';

class ListarRecetasController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  String userName;
  String uid;
  int _calificacion = null.obs();

  List<RecetaListadoModel> _recipeList;
  String _comentario;

  ValueNotifier<bool> get loading => _loading;
  List<RecetaListadoModel> get recipeList => _recipeList;
  String get comentario => _comentario;
  int get calificacion => _calificacion;


  @override
  void onInit() {
    super.onInit();
    userName = Get.find<AuthController>().user.email;
    uid = Get.find<AuthController>().user.uid;
    _recipeList = [];
    _comentario = null;
    getRecetas();
  }


  void setCalificacion(int calificacion) {
    _calificacion = calificacion;
  }

  void setComentario(String comentario) {
    _comentario = comentario;
  }

  ///Metodo para obtener las recetas almacenadas en la base de datos
  getRecetas() async {
    _loading.value = true;
    FireStoreDB().getRecetas().then((value) {
      for (var recipe in value) {
        _recipeList.add(RecetaListadoModel.fromMap(recipe.data()));
        _loading.value = false;
      }
      update();
    });
  }

  ///Metodo que asigna la imagen desde la web
  ///asigna la predeterminada si la receta no tiene ninguna
  ///@imagen string que tiene la ruta de la imagen
  ///@context contexto de la pantalla del telefono
  Widget seleccionarImagen(String imagene, BuildContext context) {
    if (imagene.isEmpty) {
      return Image.asset(
        'assets/images/rescipesHub.png',
        height: 120,
        width: MediaQuery.of(context).size.width * .45,
        fit: BoxFit.fill,
      );
    } else {
      return Image.network(
        imagene,
        height: 120,
        width: MediaQuery.of(context).size.width * .45,
        fit: BoxFit.cover,
      );
    }
  }

  Widget listarImagenes(List<String> imagenes, BuildContext context) {
    if (imagenes.first.isEmpty) {
      print('entro');
      return Image.asset(
        'assets/images/rescipesHub.png',
        height: 100,
        width: MediaQuery.of(context).size.width * .4,
        fit: BoxFit.fill,
      );
    } else {
      return CarouselSlider(
        items: crearSlider(imagenes, context),
        options: CarouselOptions(
            autoPlay: false,
            aspectRatio: 2.0,
            height: 230,
            enlargeCenterPage: true,
            enlargeStrategy: CenterPageEnlargeStrategy.height),
      );
    }
  }

  ///Metodo que crea el listado de imagenes obtenidas de la base de datos
  ///usado en los detalles de las recetas
  List<Widget> crearSlider(List<String> imagenes, BuildContext context) {
    List<Widget> imageSliders = [];
    for (String imagen in imagenes) {
      imageSliders.add(Container(
        child: Container(
          margin: EdgeInsets.all(1),
          child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: Image.network(
                imagen,
                width: Get.width,
                fit: BoxFit.cover,
              )),
        ),
      ));
    }
    return imageSliders;
  }

  ///Metodo usado para enviar la calificacion seleccionada por el usuario
  void enviarCalificacion(String recetaId) {
    Get.defaultDialog(
      title: "¿ Desea enviar su calificacion ?",
      titleStyle: TextStyle(fontSize: 17),
      middleText: 'Podra cambiarla en cualquier momento',
      middleTextStyle: TextStyle(fontSize: 14),
      textCancel: "Cancelar",
      textConfirm: "Confirmar",
      confirmTextColor: Colors.white,
      onCancel: () => null,
      onConfirm: () {
        FireStoreDB().PuntuarReceta(uid, recetaId, _calificacion);
        _calificacion = null;
        Get.back();
      },
    );
  }

  /// Metodo para validar que el comentario contenga caracteres/informacion
  /// @Comentario comentario que el usuario desea enviar
  void validarComentario(String recetaId) {
    if (comentario == null) {
      Get.snackbar("Se requiere por lo menos un caracter", "",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Color.fromARGB(250, 200, 72, 45),
          colorText: Colors.white);
    } else {
      FireStoreDB().enviarComentario(userName, recetaId, comentario);
      formKey.currentState.reset();
      verComentarios(recetaId);
    }
  }

  ///metodo que envia a la vista de comentarios de una receta
  ///@recetaId la identificacion de la receta a la que se le quieren ver los comentarios
  void verComentarios(String recetaId) {
    Get.lazyPut(() => ComentariosController(recetaId));
    Get.to(() => ComentariosView());
  }
}
