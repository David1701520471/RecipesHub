import 'package:flutter/material.dart';
import 'package:recipes_hub/core/controllers/RecetaController.dart';

class ListarNumeros extends StatelessWidget {
  final RecetaController controller;
  final int dynamicNumber;
  final String tipo;

  const ListarNumeros(this.controller, this.dynamicNumber, this.tipo);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DropdownButton<int>(
        value: dynamicNumber,
        icon: Icon(Icons.arrow_downward),
        onChanged: (value) {
          controller.asiganarValorTiempo(tipo, value);
          controller.update();
        },
        underline: Container(
          color: Colors.transparent,
        ),
        items: controller
            .listaTiempos(tipo)
            .map<DropdownMenuItem<int>>((int value) {
          return DropdownMenuItem<int>(
            value: value,
            child: Text('${value.toString()} $tipo'),
          );
        }).toList(),
        hint: Text(tipo),
        isExpanded: true,
      ),
    );
  }
}
