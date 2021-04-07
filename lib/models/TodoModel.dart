import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {

  String content;
  String todoId;
  Timestamp dateCreated;

  TodoModel({
    this.content,
    this.todoId,
    this.dateCreated,
  });

  factory TodoModel.fromDocument(DocumentSnapshot doc) {
    return TodoModel(
      content: doc.data()["content"],
      todoId: doc.data()['id'],
      dateCreated: doc.data()["dateCreated"],
    );
  }

}