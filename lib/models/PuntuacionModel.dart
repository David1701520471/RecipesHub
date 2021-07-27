import 'dart:convert';

class PuntuacionModel {
  String userId;
  int puntuacion;
  PuntuacionModel({
    this.userId,
    this.puntuacion,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'puntuacion': puntuacion,
    };
  }

  factory PuntuacionModel.fromMap(Map<String, dynamic> map) {
    return PuntuacionModel(
      userId: map['userId'],
      puntuacion: map['puntuacion'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PuntuacionModel.fromJson(String source) =>
      PuntuacionModel.fromMap(json.decode(source));
}
