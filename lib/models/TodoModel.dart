import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {

  String content;
  String todoId;
  Timestamp dateCreated;
  bool done;

  TodoModel({
    this.content,
    this.todoId,
    this.dateCreated,
    this.done,
  });

  factory TodoModel.fromDocument(DocumentSnapshot doc) {
    return TodoModel(
      content: doc.data()["content"],
      todoId: doc.data()['id'],
      dateCreated: doc.data()["dateCreated"],
      done: doc.data()["done"],
    );
  }

}