import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipes_hub/models/Common/Categoria.dart';
import 'package:recipes_hub/models/Receta/RecetaModel.dart';

class RecetaController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController ingredienteController = TextEditingController();
  TextEditingController pasosController = TextEditingController();
  RecetaModel formRes;

  Rx<List<RecetaModel>> ricepieList = new Rx<List<RecetaModel>>();
  RxList<String> pasosList = new RxList<String>();
  RxList<String> ingredientesList = new RxList<String>();
  RxList<int> horas = new RxList<int>();
  RxList<int> minutos = new RxList<int>();
  int duracionH = null.obs();
  int duracionM = null.obs();

  RxList<String> dificultadesList = new RxList<String>();
  String dificultad = null.obs();

  RxList<Categoria> categoriasList = new RxList();
  List<String> categoriasSeleccionadasList = [];

  List<RecetaModel> get recipes => ricepieList.value;
  RxList<String> get pasos => pasosList;
  RxList<String> get ingredientes => ingredientesList;
  RxList<String> get dificultades => dificultadesList;
  RecetaModel get formResult => formRes;

  @override
  void onInit() {
    super.onInit();
    formRes = RecetaModel();
    ingredienteController = TextEditingController();
    pasosController = TextEditingController();
    for (var i = 0; i < 24; i++) {
      horas.add(i);
    }
    for (var i = 0; i < 60; i++) {
      minutos.add(i);
    }
    dificultades.addAll(['Baja', 'Media', 'Alta']);
    //TODO: codigo quemado para pruebas, esta infor se debería obtener desde la base de datos
    categoriasList.addAll([
      new Categoria("Almuerzo", false),
      new Categoria("Ensaladas", false),
      new Categoria("Cenas", false),
      new Categoria("Postres", false),
      new Categoria("Desayunos", false),
      new Categoria("Saludable", false),
    ]);

    //uid = Get.find<AuthController>().user.uid;
    //ricepieList.bindStream(
    //FireStoreDB().todoStream(uid)); //stream coming from firebase
  }

  @override
  void onClose() {
    super.onClose();
    ingredienteController.dispose();
    pasosController.dispose();
  }

  void validarFormulario() {
    //TODO:
  }

  String validarNombre(String nombre) {
    if (nombre.length == 0) {
      return "el campo nombre es requerido";
    } else if (nombre.length > 70) {
      return "el nombre de la receta no debe exceder los 70 caracteres";
    }
    return null;
  }

  RxList<int> listaTiempos(String tipo) {
    if (tipo == "Minutos") {
      return minutos;
    } else if (tipo == "Horas") {
      return horas;
    }
    return null;
  }

  void listarCategoriasSeleccionadas(String categoria, bool check) {
    if (check) {
      categoriasSeleccionadasList.add(categoria);
    } else {
      categoriasSeleccionadasList
          .removeWhere((element) => element == categoria);
    }
  }

  void agregarPaso() {
    if (pasosController.text != "" && pasosController != null) {
      pasosList.add(pasosController.text);
      pasosController.clear();
    } else {
      Get.snackbar("El campo paso es requerido", "",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Color.fromARGB(250, 200, 72, 45),
          colorText: Colors.white);
    }
  }

  void eliminarPaso(int index) {
    pasosList.removeAt(index);
  }

  void agregarIngrediente() {
    if (ingredienteController != null && ingredienteController.text != "") {
      ingredientesList.add(ingredienteController.text);
      ingredienteController.clear();
    } else {
      Get.snackbar("El campo ingrediete es requerido", "",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Color.fromARGB(250, 200, 72, 45),
          colorText: Colors.white);
    }
  }

  void eliminarIngrediente(int index) {
    ingredientesList.removeAt(index);
  }

  String setTiempo() {
    return null;
  }

  void asiganarValorTiempo(String tipo, int value) {
    if (tipo == "Minutos") {
      this.duracionM = value;
    } else if (tipo == "Horas") {
      this.duracionH = value;
    }
  }

  void asignarDificultad(String value) {
    this.dificultad = value;
  }
}
