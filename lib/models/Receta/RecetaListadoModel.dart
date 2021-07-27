import 'dart:convert';

class RecetaListadoModel {
  String nombre;
  String descripcion;
  List<String> pasos;
  List<String> categorias;
  List<String> ingredientes;
  String duracion;
  List<String> imagenes;
  String dificultad;

  RecetaListadoModel({
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

  factory RecetaListadoModel.fromMap(Map<String, dynamic> map) {
    return RecetaListadoModel(
      nombre: map['nombre'],
      descripcion: map['descripcion'],
      pasos: List<String>.from(map['pasos']),
      categorias: List<String>.from(map['categorias']),
      ingredientes: List<String>.from(map['ingredientes']),
      duracion: map['duracion'],
      imagenes: List<String>.from(map['imagenes']),
      dificultad: map['dificultad'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RecetaListadoModel.fromJson(String source) =>
      RecetaListadoModel.fromMap(json.decode(source));
}
