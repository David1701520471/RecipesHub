import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:test_api/test_api.dart';
import 'package:recipes_hub/core/controllers/RecetaController.dart';
import 'package:recipes_hub/models/Receta/RecetaModel.dart';

void main() {
  group('Pruebas crear receta', () {

    test('nombre de receta válido', () {
      final recetaControladora = RecetaController();

      List<String> ingredientesList = new List<String>();
      List<String> categoriasList = new List<String>();

      ingredientesList.addAll([
        "chocolate",
        "harina"
      ]);
      categoriasList.addAll([
        "Almuerzo",
       "Ensaladas"
      ]);
      final receta = RecetaModel(recipeId: 'rec1', nombre: 'Postre de chocolate',
          ingredientes: ingredientesList, categorias: categoriasList, descripcion: 'cualquier cosa',
      dificultad: 'media', duracion: '561', pasos: ['preparar', 'cocinar'], imagenes: null);


      var respuestaNombre = recetaControladora.validarNombre(receta.nombre);
      expect(respuestaNombre, null);


    });

    test('nombre de receta vacio', () {
      final recetaControladora = RecetaController();

      List<String> ingredientesList = new List<String>();
      List<String> categoriasList = new List<String>();

      ingredientesList.addAll([
        "chocolate",
        "harina"
      ]);
      categoriasList.addAll([
        "Almuerzo",
        "Ensaladas"
      ]);
      final receta = RecetaModel(recipeId: 'rec1', nombre: '',
          ingredientes: ingredientesList, categorias: categoriasList, descripcion: 'cualquier cosa',
          dificultad: 'media', duracion: '561', pasos: ['preparar', 'cocinar'], imagenes: null);


      var respuestaNombre = recetaControladora.validarNombre(receta.nombre);
      expect(respuestaNombre, "el campo nombre es requerido");


    });

    test('tamaño del nombre mayor a 70 caracteres', () {
      final recetaControladora = RecetaController();

      List<String> ingredientesList = new List<String>();
      List<String> categoriasList = new List<String>();

      ingredientesList.addAll([
        "chocolate",
        "harina"
      ]);
      categoriasList.addAll([
        "Almuerzo",
        "Ensaladas"
      ]);
      final receta = RecetaModel(recipeId: 'rec1', nombre: 'nombrenombre nombrenombre nombrenombre nombrenombre'
          'nombrenombre nombrenombre nombrenombre nombrenombre nombrenombre nombrenombre nombrenombre nombrenombre',
          ingredientes: ingredientesList, categorias: categoriasList, descripcion: 'cualquier cosa',
          dificultad: 'media', duracion: '561', pasos: ['preparar', 'cocinar'], imagenes: null);


      var respuestaNombre = recetaControladora.validarNombre(receta.nombre);
      expect(respuestaNombre, "el nombre de la receta no debe exceder los 70 caracteres");


    });

  });
}