import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipes_hub/models/Common/Categoria.dart';
import 'package:recipes_hub/models/Receta/RecetaModel.dart';
import 'package:recipes_hub/core/services/FireStoreDB.dart';
import 'package:image_picker/image_picker.dart';

import 'AuthController.dart';

class RecetaController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController ingredienteController = TextEditingController();
  TextEditingController pasosController = TextEditingController();
  RecetaModel formRes;

  String uid;

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

  RxList<PickedFile> selectedImageList = new RxList<PickedFile>();
  RxList<File> selectedImageListFile = new RxList<File>();
  RxString selectedImagePath = new RxString();

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

    selectedImagePath = ''.obs;
    uid = Get.find<AuthController>().user.uid;
    //ricepieList.bindStream(
    //FireStoreDB().todoStream(uid)); //stream coming from firebase
  }

  @override
  void onClose() {
    super.onClose();
    ingredienteController.dispose();
    pasosController.dispose();
  }


  void saveRecipe(TextEditingController todoController, String uid) {
    if (todoController != null) {
      FireStoreDB().addTodo(todoController.text, uid);
      todoController.clear();
    }
  }

  /**
   * Metodo usado para validar los campos especificados:
   * nombre de la receta,
   * numero de pasos,
   * categorias seleccionadas.
   * Junto a la confimacion de envio de la receta
   */
  void validarFormulario() {

    final isValid = formKey.currentState.validate();
    if (!isValid) {
      return;
    } else if (formRes.pasos.length < 1) {
      Get.snackbar("Se requiere un paso como minimo", "",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Color.fromARGB(250, 200, 72, 45),
          colorText: Colors.white);
    } else if (formRes.categorias.length < 1) {
      Get.snackbar("Se requiere una categoria como minimo", "",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Color.fromARGB(250, 200, 72, 45),
          colorText: Colors.white);
    } else {
      Get.defaultDialog(
        title: "La receta se enviara a revisión",
        titleStyle: TextStyle(fontSize: 17),
        middleText: "¿ Esta seguro que desea enviarla ?",
        middleTextStyle: TextStyle(fontSize: 14),
        textCancel: "Cancelar",
        textConfirm: "Confirmar",
        confirmTextColor: Colors.white,
        onCancel: () => Get.back(),
        onConfirm: () {
          //TODO: enviar el formResult a la base de datos
         FireStoreDB().agregarReceta(formRes, uid);
          print("ya prro");
        },
      );
    }
    formKey.currentState.save();

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

  /**
   * Metodo empleado para obtener la imagen seleccionada desde la galeria
   */
  void getImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().getImage(source: imageSource);
    if (pickedFile != null) {
      selectedImageList.add(pickedFile);
      selectedImageListFile.add(File(pickedFile.path));
    } else {
      Get.snackbar("Error", "No se ha seleccionado ninguna imagen",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Color.fromARGB(250, 200, 72, 45),
          colorText: Colors.white);
    }
  }

  void eliminarImagen(int index) {
    selectedImageList.removeAt(index);
  }

  void asiganarValor(String tipo, int value) {
    if (tipo == "Minutos") {
      this.duracionM = value;
    } else if (tipo == "Horas") {
      this.duracionH = value;
    }
  }

  void asignarDificultad(String value) {
    this.dificultad = value;
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
      print(ingredientesList);
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
    int calculomachete = (duracionH * 100) + duracionM;
    String duracion = calculomachete.toString();
    return duracion;
  }


  void listarCategoriasSeleccionadas(String categoria, bool check) {
    if (check) {
      categoriasSeleccionadasList.add(categoria);
    } else {
      categoriasSeleccionadasList
          .removeWhere((element) => element == categoria);
    }
  }

  void asiganarValorTiempo(String tipo, int value) {
    if (tipo == "Minutos") {
      this.duracionM = value;
    } else if (tipo == "Horas") {
      this.duracionH = value;
    }
  }
}