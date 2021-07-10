import 'package:flutter/material.dart';
import 'package:recipes_hub/core/controllers/RecetaController.dart';

class CheckBoxList extends StatelessWidget {
  final RecetaController controller;
  final int index;
  CheckBoxList(
    this.controller,
    this.index,
  );
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 100.0, right: 100.0),
      child: CheckboxListTile(
        value: controller.categoriasList[index].check,
        title: Text(controller.categoriasList[index].categoria),
        controlAffinity: ListTileControlAffinity.platform,
        onChanged: (bool value) {
          controller.categoriasList[index].check = value;
          controller.listarCategoriasSeleccionadas(
              controller.categoriasList[index].categoria, value);
          controller.update();
          //print(controller.categoriasSeleccionadasList);
          //print('${controller.categoriasList[index].check},$value');
        },
      ),
    );
  }
}
