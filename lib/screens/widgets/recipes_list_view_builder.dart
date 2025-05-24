//File that loads api data
import 'package:flutter/material.dart';
import 'package:Pizza_recipes/screens/widgets/recipe_card.dart';
import 'recipes_API.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RecipesListViewBuilder extends StatelessWidget {
  final String searchQuery;

  const RecipesListViewBuilder({super.key, required this.searchQuery});

  Future<RecipeList> fetchRecipes() async {
    final response = await http.get(Uri.parse('https://forkify-api.herokuapp.com/api/search?q=pizza'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return RecipeList.fromJson(data);
    } else {
      throw Exception('Failed to load recipes');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<RecipeList>(
      future: fetchRecipes(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // Filter recipes based on searchQuery
          final filteredRecipes = snapshot.data!.recipes
              .where((recipe) => recipe.title.toLowerCase().contains(searchQuery))
              .toList();

          return SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                if (index < filteredRecipes.length) {
                  var recipe = filteredRecipes[index];
                  return RecipeCard(
                    recipeData: {
                      'publisher': recipe.publisher,
                      'title': recipe.title,
                      'source_url': recipe.sourceUrl,
                      'recipe_id': recipe.recipeId,
                      'image': recipe.imageUrl,
                      'social_rank': recipe.socialRank.toString(),
                      'publisher_url': recipe.publisherUrl,
                    },
                  );
                }
                return null;
              },
              childCount: filteredRecipes.length,
            ),
          );
        } else if (snapshot.hasError) {
          return SliverToBoxAdapter(
            child: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        }
        return const SliverToBoxAdapter(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
