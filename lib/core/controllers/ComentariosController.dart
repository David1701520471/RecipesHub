import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipes_hub/core/services/FireStoreDB.dart';
import 'package:recipes_hub/models/ComentarioModrel.dart';

class ComentariosController extends GetxController {
  List<ComentarioModel> _comentarioList = [];
  ValueNotifier<bool> _loading = ValueNotifier(false);
  String recetaId;
  String userName;

  List<ComentarioModel> get comentarios => _comentarioList;
  ValueNotifier<bool> get loading => _loading;

  ComentariosController(this.recetaId);

  @override
  void onInit() {
    _comentarioList = [];
    getComentarios();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getComentarios() async {
    _loading.value = true;
    FireStoreDB().getComentarios(recetaId).then((value) {
      for (var recipe in value) {
        _comentarioList.add(ComentarioModel.fromMap(recipe.data()));
        _loading.value = false;
      }
      if (_comentarioList.isEmpty) {
        _loading.value = false;
      }
      update();
    });
  }
}
