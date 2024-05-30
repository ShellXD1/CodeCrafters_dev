import 'package:flutter/material.dart';
import 'package:proyecto_tsp_dev/view/ComponentesView/botonFavorito.dart';
import 'package:proyecto_tsp_dev/view/recetaDetallada.dart';
import 'package:proyecto_tsp_dev/viewModel/recetasViewModel.dart';
import 'package:proyecto_tsp_dev/viewModel/ingredientViewModel.dart';

// Clase para mostrar la tarjeta de una receta
class RecetaItem extends StatefulWidget {
  final Map<String, dynamic> recetaInfo;
  final RecetasViewModel? recetasViewModel;
  final IngredienteViewModel ingredientesViewModel;
  final VoidCallback? onFavoritoPressed;

  const RecetaItem({
    Key? key,
    required this.recetaInfo,
    this.recetasViewModel,
    this.onFavoritoPressed, 
    required this.ingredientesViewModel,
  }) : super(key: key);

  @override
  _RecetaItemState createState() => _RecetaItemState();
}

// Clase para manejar el estado de la tarjeta de una receta
class _RecetaItemState extends State<RecetaItem> {
  late Future<bool> _futureEsFavorita;

  // Método para obtener el estado de favoritos
  @override
  void initState() {
    super.initState();
    // Obtener el estado de favoritos una vez inicializado el widget
    _futureEsFavorita = _obtenerEsFavorita();
  }

  // Método para obtener el estado de favoritos
  Future<bool> _obtenerEsFavorita() async {
    // Obtener el índice de la receta
    int recipeIndex = widget.recetaInfo['id_receta'] ?? 0;
    // Obtener el estado de favoritos desde el ViewModel
    return widget.recetasViewModel!.esRecetaFavorita(recipeIndex);
  }

  // Método para mostrar la tarjeta de una receta
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _futureEsFavorita,
      builder: (context, snapshot) {
        bool recetaEsFavorita = snapshot.data ?? false;
        final String nombreReceta =
            widget.recetaInfo['nombre_receta'] ?? 'Receta sin nombre';
        final String imagenRecetaPath =
            widget.recetaInfo['imagen_receta'] ?? '';
        final int recipeIndex = (widget.recetaInfo['id_receta']) - 1 ?? 0;
        // Mostrar la tarjeta de una receta
        return GestureDetector(
          onTap: () {
            // Navegar a la pantalla de detalles de la receta
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RecetaDetalladaView(
                  recetasViewModel: widget.recetasViewModel!,
                  recipeIndex: recipeIndex, ingredienteViewModel: widget.ingredientesViewModel,
                ),
              ),
            );
          },
          child: Container(
            width: 300,
            margin: EdgeInsets.symmetric(vertical: 10.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (imagenRecetaPath.isNotEmpty)
                      Image.asset(
                        '$imagenRecetaPath',
                        width: 200,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            nombreReceta,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            maxLines: 3,  // Limita a 3 líneas de texto
                          ),
                        ),
                        BotonFavoritos(
                          esFavorita: recetaEsFavorita,
                          onPressed: () async {
                            // Cambiar el estado de favoritos cuando se presiona el botón
                            int recipeIndex =
                                widget.recetaInfo['id_receta'] ?? 0;
                            await widget.recetasViewModel!
                                .toggleFavorita(recipeIndex);
                            // Actualizar el estado de favoritos
                            setState(() {
                              _futureEsFavorita = _obtenerEsFavorita();
                            });
                            // Llamar a la función proporcionada, si existe
                            widget.onFavoritoPressed?.call();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}