import 'dart:io';

import 'package:flutter/material.dart';
import 'package:recipes_hub/core/controllers/RecetaController.dart';

class ImagenesCard extends StatelessWidget {
  final RecetaController controller;
  final int index;

  const ImagenesCard(this.controller, this.index);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      margin: EdgeInsets.all(1),
      child: Padding(
          padding: EdgeInsets.all(1.0),
          child: Column(
            children: <Widget>[
              Expanded(
                child: InkWell(
                  child: Container(
                      width: 100.0,
                      height: 100.0,
                      child: ListTile(
                        title: Image.file(
                          File(controller.selectedImageList[index].path),
                          fit: BoxFit.fill,
                        ),
                      )),
                ),
              ),
              IconButton(
                  icon: Icon(Icons.cancel_outlined),
                  onPressed: () {
                    controller.eliminarImagen(index);
                  })
            ],
          )),
    );
  }
}
