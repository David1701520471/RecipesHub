

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipes_hub/core/controllers/UserController.dart';
import 'package:recipes_hub/models/UserModel.dart';
import 'package:recipes_hub/core/services/FireStoreDB.dart';


  class AuthController extends GetxController {
   final FirebaseAuth _auth = FirebaseAuth.instance;
   final  Rx<User> _firebaseUser = Rx<User>();

      TextEditingController emailController;
      TextEditingController passwordController;

    User get user => _firebaseUser.value;

    @override
    onInit() {
      super.onInit();
      emailController = TextEditingController();
      passwordController = TextEditingController();
      _firebaseUser.bindStream(_auth.authStateChanges());
    }

    @override
    void onClose() {
      emailController.dispose();
      passwordController.dispose();
    super.onClose();
  }

    void createUser(String name, String email, String password) async {
      try {
        UserCredential _authResult = await _auth.createUserWithEmailAndPassword(
            email: email.trim(), password: password);
        //create user in database.dart
        UserModel _user = UserModel(
          id: _authResult.user.uid,
          name: name,
          email: _authResult.user.email,
        );
        if (await FireStoreDB().createNewUser(_user)) {
          Get.find<UserController>().user = _user;
          Get.back();
        }
      } catch (e) {
        Get.snackbar(
          "Error creating Account",
          e.message,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }

    void login() async {
      try {
        UserCredential _authResult = await _auth.signInWithEmailAndPassword(
            email: emailController.text.trim(), password: passwordController.text);
        Get.find<UserController>().user =
        await FireStoreDB().getUser(_authResult.user.uid);
      } catch (e) {
        Get.snackbar(
          "Error signing in",
           e.message,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }

    void signOut() async {
      try {
        await _auth.signOut();
        Get.find<UserController>().clear();
      } catch (e) {
        Get.snackbar(
          "Error signing out",
          e.message,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }
  }