//The name, rating, recipe_id,publisher that's shown in recipe_card
//It's connected to recipe_card file
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BuildRecipeBasicInfo extends StatelessWidget {
  final Map<String, dynamic> recipeData;

  const BuildRecipeBasicInfo({
    Key? key,
    required this.recipeData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          recipeData['title'] ?? 'Title not available',
          style: Theme.of(context).textTheme.titleLarge,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(
              FontAwesomeIcons.star,
              color: Colors.amber,
              size: 18,
            ),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                recipeData['social_rank'] ?? 'No rating',
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 16,
                  fontFamily: 'Poppins',
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Publisher: ${recipeData['publisher'] ?? 'N/A'}',
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
            fontFamily: 'Poppins',
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Recipe ID: ${recipeData['recipe_id'] ?? 'N/A'}',
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
            fontFamily: 'Poppins',
          ),
        ),
      ],
    );
  }}