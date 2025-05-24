//File contains functions of API and class of recipe's details
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'recipe_card.dart';

class Recipe {
  final String publisher;
  final String title;
  final String sourceUrl;
  final String recipeId;
  final String imageUrl;
  final double socialRank;
  final String publisherUrl;

  Recipe({
    required this.publisher,
    required this.title,
    required this.sourceUrl,
    required this.recipeId,
    required this.imageUrl,
    required this.socialRank,
    required this.publisherUrl,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      publisher: json['publisher'],
      title: json['title'],
      sourceUrl: json['source_url'],
      recipeId: json['recipe_id'],
      imageUrl: json['image_url'],
      socialRank: json['social_rank'].toDouble(),
      publisherUrl: json['publisher_url'],
    );
  }
}

class RecipeList {
  final int count;
  final List<Recipe> recipes;

  RecipeList({required this.count, required this.recipes});

  factory RecipeList.fromJson(Map<String, dynamic> json) {
    var list = json['recipes'] as List;
    List<Recipe> recipeList = list.map((i) => Recipe.fromJson(i)).toList();
    return RecipeList(
      count: json['count'],
      recipes: recipeList,
    );
  }
}

class RecipesListView extends StatelessWidget {
  const RecipesListView({super.key});

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
          return SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                if (index < snapshot.data!.recipes.length) {
                  var recipe = snapshot.data!.recipes[index];
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
              childCount: snapshot.data!.recipes.length,
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
