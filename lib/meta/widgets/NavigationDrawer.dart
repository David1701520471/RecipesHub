import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipes_hub/core/controllers/AuthController.dart';
import 'package:recipes_hub/models/NavigationItem.dart';

class NavigationDrawer extends GetWidget<AuthController> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.grey,
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(
                    height: 24,
                  ),
                  buildMenuItem(context, NavigationItem.logOut, controller,
                      text: 'Cerar sesión', icon: Icons.logout),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget buildMenuItem(
  BuildContext context,
  NavigationItem item,
  AuthController authController, {
  String text,
  IconData icon,
}) {
  final color = Colors.white;
  return Material(
    color: Colors.transparent,
    child: ListTile(
      leading: Icon(
        icon,
        color: color,
      ),
      title: Text(
        text,
        style: TextStyle(color: color),
      ),
      onTap: () {
        authController.signOut();
      },
    ),
  );
}

void selectedItem(BuildContext context, NavigationItem item) {}
