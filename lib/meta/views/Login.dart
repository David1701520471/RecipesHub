
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipes_hub/core/controllers/AuthController.dart';


class Login extends GetWidget<AuthController> {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      init: AuthController(),
      builder:
          (_) =>
          Scaffold(
            appBar: AppBar(
              title: Text(
                "Login ",
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(hintText: "Email"),
                      controller: _.emailController,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: "Password"),
                      controller: _.passwordController,
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      child: Text("Log In"),
                      onPressed: () {
                        _.login();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
    );
  }
}
