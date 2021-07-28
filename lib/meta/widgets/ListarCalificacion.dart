import 'package:flutter/material.dart';
import 'package:recipes_hub/core/controllers/ListarRecetasController.dart';

class ListarCalificacion extends StatelessWidget {
  final ListarRecetasController controller;
  final List<int> listaNumeros = [1, 2, 3, 4, 5];

  ListarCalificacion(this.controller);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DropdownButton<int>(
        value: controller.calificacion,
        icon: Icon(Icons.arrow_downward),
        onChanged: (value) {
          controller.setCalificacion(value);
          controller.update();
          controller.enviarCalificacion();
        },
        underline: Container(
          color: Colors.transparent,
        ),
        items: listaNumeros.map<DropdownMenuItem<int>>((int value) {
          return DropdownMenuItem<int>(
              value: value,
              child: Row(
                children: [
                  Text(value.toString()),
                  Icon(
                    Icons.star,
                  ),
                ],
              ));
        }).toList(),
        hint: Text('Calificar'),
        isExpanded: true,
      ),
    );
  }
}
