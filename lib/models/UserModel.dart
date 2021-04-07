import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String id;
  //String name;
  String email;

  UserModel({this.id,  this.email});

  //Esta forma no salen errores, la forma del video salen errores actualmente 
  factory UserModel.fromDocument(DocumentSnapshot doc) {
    return UserModel(
      id : doc.data()['id'],
      //name = documentSnapshot["name"];
      email : doc.data()["email"],
    );
  }

}