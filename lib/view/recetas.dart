import 'package:flutter/material.dart';
import 'package:proyecto_tsp_dev/view/recetaDetallada.dart';
import 'package:proyecto_tsp_dev/viewModel/recipeViewModel.dart';

class RecetasView extends StatelessWidget {
  final RecipeViewModel recipeViewModel;

  const RecetasView({Key? key, required this.recipeViewModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recetas', style: TextStyle(fontSize: 30.0, fontFamily: 'Chivo')),
        leading: IconButton(
          icon: Icon(Icons.home,
              size: 40.0), // Mantenemos el ícono de inicio como estaba
          onPressed: () {
            print(
                "Botón de la casita presionado (regresar a la pantalla de inicio)");
            Navigator.pop(context); // Regresar a la pantalla de inicio
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Recetas:',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24.0, fontFamily: 'Chivo'),
                ),
                SizedBox(height: 10.0),
                Container(
                  padding: EdgeInsets.all(10.0),
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      for (var recipe in recipeViewModel.recipes)
                        RecipeCard(
                          imagePath:
                              'assets/recetas/${recipe.image}', // Utilizamos imágenes para las recetas
                          name: recipe.name,
                          onTap: () {
                            print("Receta '${recipe.name}' seleccionada");
                            int recipeIndex =
                                recipeViewModel.recipes.indexOf(recipe);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RecetaDetalladaView(
                                    recipeViewModel: recipeViewModel,
                                    recipeIndex: recipeIndex),
                              ),
                            );
                          },
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Color(0xFF9EE060),
        child: Row(
          children: <Widget>[
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // Acción al presionar el botón "Recetas"
                  print("Botón 'Recetas' presionado");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF9EE060),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  padding: EdgeInsets.all(16.0),
                ),
                child: Text(
                  'Recetas',
                  style: TextStyle(fontSize: 25.0, fontFamily: 'Chivo', color: Colors.black,),
                ),
              ),
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // Acción al presionar el botón "Ingredientes"
                  print("Botón 'Ingredientes' presionado");
                  Navigator.popUntil(
                      context,
                      ModalRoute.withName(
                          '/')); // Regresar a la pantalla de inicio
                  Navigator.pushNamed(context,
                      '/ingredientes'); // Navegar a la pantalla de recetas
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF9EE060),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  padding: EdgeInsets.all(16.0),
                ),
                child: Text(
                  'Ingredientes',
                  style: TextStyle(fontSize: 25.0, fontFamily: 'Chivo', color: Colors.black,),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RecipeCard extends StatelessWidget {
  final String imagePath;
  final String name;
  final VoidCallback onTap;

  const RecipeCard({
    Key? key,
    required this.imagePath,
    required this.name,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.blueGrey,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              imagePath,
              fit: BoxFit.cover,
              height: 150.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                name,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
