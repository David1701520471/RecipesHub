import 'package:flutter/material.dart';
import 'package:recipes_hub/core/controllers/RecetaController.dart';

class ListarDificultad extends StatelessWidget {
  final RecetaController controller;
  final String dynamicSkill;

  const ListarDificultad(this.controller, this.dynamicSkill);
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: DropdownButton<String>(
      value: dynamicSkill,
      icon: Icon(Icons.arrow_downward),
      onChanged: (value) {
        controller.asignarDificultad(value);
        controller.update();
      },
      underline: Container(
        color: Colors.transparent,
      ),
      items:
          controller.dificultades.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      hint: Text("Dificultad"),
      isExpanded: true,
    ));
  }
}
