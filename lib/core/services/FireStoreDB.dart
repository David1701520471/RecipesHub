import 'dart:io';

import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:recipes_hub/models/Receta/RecetaModel.dart';
import 'package:recipes_hub/models/TodoModel.dart';
import 'package:recipes_hub/models/UserModel.dart';

class FireStoreDB {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> createNewUser(UserModel user) async {
    try {
      await _firestore.collection("users").doc(user.id).set({
        "name": user.name,
        "email": user.email,
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<UserModel> getUser(String uid) async {
    try {
      DocumentSnapshot _doc =
          await _firestore.collection("users").doc(uid).get();

      return UserModel.fromDocument(_doc);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> addTodo(String content, String uid) async {
    try {
      await _firestore.collection("users").doc(uid).collection("todos").add({
        'dateCreated': Timestamp.now(),
        'content': content,
        'done': false,
      });
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Stream<List<TodoModel>> todoStream(String uid) {
    return _firestore
        .collection("users")
        .doc(uid)
        .collection("todos")
        .orderBy("dateCreated", descending: true)
        .snapshots()
        .map((QuerySnapshot query) {
      List<TodoModel> retVal = [];
      query.docs.forEach((element) {
        retVal.add(TodoModel.fromDocument(element));
      });
      return retVal;
    });
  }

  Future<void> updateTodo(bool newValue, String uid, String todoId) async {
    try {
      _firestore
          .collection("users")
          .doc(uid)
          .collection("todos")
          .doc(todoId)
          .update({"done": newValue});
    } catch (e) {
      print(e);
      rethrow;
    }
  }



  Future<void> agregarReceta(RecetaModel receta, String uid) async {
    try {
      await _firestore
          .collection("users")
          .doc(uid)
          .collection("recipes")
          .add({
        'categorias':receta.categorias,
        'descripcion':receta.descripcion,
        'dificultad' : receta.dificultad,
        'duracion': receta.duracion,
        'ingredientes':receta.ingredientes,
        'pasos':receta.pasos,
        'nombre':receta.nombre

      });
      saveImages(receta.imagenes);


    } catch (e) {
      print(e);
      rethrow;
    }
  }



  Future<void> saveImages(List<File> _images) async {


    DocumentReference ref = Firestore.instance.collection("image").doc();
    _images.forEach((image) async {
      String imageURL = await uploadFile(image);
      ref.update({"image": FieldValue.arrayUnion([imageURL])});
    });
  }



  Future<String> uploadFile(File _image) async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('images/${basename(_image.path)}');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    print('File Uploaded');
    String returnURL;
    await storageReference.getDownloadURL().then((fileURL) {
      returnURL =  fileURL;
    });
    return returnURL;
  }











}
