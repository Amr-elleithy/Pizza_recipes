//This file shows the screen of recipes details
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Pizza_recipes/screens/widgets/web_view_screen.dart';

class RecipeDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> recipeData;

  const RecipeDetailsScreen({super.key, required this.recipeData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            FontAwesomeIcons.arrowLeftLong,
          ),
        ),
        title: const Text(
          'Recipe Details',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontFamily: 'Poppins',
          ),
        ),
        backgroundColor: Colors.white,
        forceMaterialTransparency: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              recipeData['image'] ?? 'https://via.placeholder.com/150',
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
            ),
            const SizedBox(height: 16),
            Text(
              recipeData['title'] ?? 'No Title',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.green,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Publisher: ${recipeData['publisher'] ?? 'N/A'}',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Source: ${recipeData['source_url'] ?? 'N/A'}',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Recipe ID: ${recipeData['recipe_id'] ?? 'N/A'}',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Social Rank: ${recipeData['social_rank'] ?? 'N/A'}',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Publisher URL: ${recipeData['publisher_url'] ?? 'N/A'}',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                    //Representing the recipe from its publisher on their website
                        WebViewScreen(recipeData['source_url'] ?? ''),
                  ),
                );
              },
              child: const Text('View Recipe'),
            ),
          ],
        ),
      ),
    );
  }
}
