import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String id;
  String name;
  String email;

  UserModel({this.id, this.name, this.email});

  factory UserModel.fromDocument(DocumentSnapshot doc) {
    return UserModel(
      id : doc.data()['id'],
      name : doc.data()["name"],
      email : doc.data()["email"],
    );
  }
}
