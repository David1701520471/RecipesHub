import 'dart:convert';

class ComentarioModel {
  String userName;
  String comentario;

  ComentarioModel({
    this.userName,
    this.comentario,
  });

  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'comentario': comentario,
    };
  }

  factory ComentarioModel.fromMap(Map<String, dynamic> map) {
    return ComentarioModel(
      userName: map['userName'],
      comentario: map['comentario'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ComentarioModel.fromJson(String source) =>
      ComentarioModel.fromMap(json.decode(source));
}
