import 'dart:convert';

import 'dart:io';

class RecetaModel {
  String recipeId;
  String nombre;
  String descripcion;
  List<String> pasos;
  List<String> categorias;
  List<String> ingredientes;
  String duracion;
  List<File> imagenes;
  String dificultad;

  RecetaModel({
    this.recipeId,
    this.nombre,
    this.descripcion,
    this.pasos,
    this.categorias,
    this.ingredientes,
    this.duracion,
    this.imagenes,
    this.dificultad,
  });

  Map<String, dynamic> toMap() {
    return {
      'recipeId': recipeId,
      'nombre': nombre,
      'descripcion': descripcion,
      'pasos': pasos,
      'categorias': categorias,
      'ingredientes': ingredientes,
      'duracion': duracion,
      'imagenes': imagenes,
      'dificultad': dificultad,
    };
  }

  factory RecetaModel.fromMap(Map<String, dynamic> map) {
    return RecetaModel(
      recipeId: map['recipeId'],
      nombre: map['nombre'],
      descripcion: map['descripcion'],
      pasos: List<String>.from(map['pasos']),
      categorias: List<String>.from(map['categorias']),
      ingredientes: List<String>.from(map['ingredientes']),
      duracion: map['duracion'],
      imagenes: List<File>.from(map['imagenes']),
      dificultad: map['dificultad'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RecetaModel.fromJson(String source) =>
      RecetaModel.fromMap(json.decode(source));
}
