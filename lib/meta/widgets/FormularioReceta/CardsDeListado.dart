import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipes_hub/core/controllers/RecetaController.dart';

class CardsDeListado extends StatelessWidget {
  final RecetaController controller;
  final RxList<String> lista;
  final int index;
  final String tipo;

  const CardsDeListado(
    this.controller,
    this.index,
    this.tipo,
    this.lista,
  );

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Expanded(
                child: Text('${index + 1}.${lista[index]}'),
              ),
              IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    if (tipo == "pasos") {
                      controller.eliminarPaso(index);
                    } else if (tipo == "ingredientes") {
                      controller.eliminarIngrediente(index);
                    }
                  })
            ],
          ),
        ));
  }
}
