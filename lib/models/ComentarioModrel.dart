import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class ComentarioModel {
  String userName;
  String comentario;
  Timestamp fechaDeCreacion;
  String recetaId;

  ComentarioModel(
      {this.userName, this.comentario, this.fechaDeCreacion, this.recetaId});

  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'comentario': comentario,
      'fechaDeCreacion': fechaDeCreacion,
      'recetaId': recetaId
    };
  }

  factory ComentarioModel.fromMap(Map<String, dynamic> map) {
    return ComentarioModel(
        userName: map['userName'],
        comentario: map['comentario'],
        fechaDeCreacion: map['fechaDeCreacion'],
        recetaId: map['recetaId']);
  }

  String toJson() => json.encode(toMap());

  factory ComentarioModel.fromJson(String source) =>
      ComentarioModel.fromMap(json.decode(source));
}
