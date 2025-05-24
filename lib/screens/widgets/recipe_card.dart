//The card of every recipe showing details
import 'package:flutter/material.dart';
import 'package:gif_view/gif_view.dart';
import 'package:Pizza_recipes/screens/recipe_details_screen.dart';
import 'package:Pizza_recipes/screens/widgets/build_recipe_basic_info.dart';

class RecipeCard extends StatelessWidget {
  final Map<String, dynamic> recipeData;

  const RecipeCard({
    super.key,
    required this.recipeData,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(bottom: 14),
      child: Container(
        height: 242,
        clipBehavior: Clip.hardEdge,
        decoration: const BoxDecoration(
          border: BorderDirectional(
            start: BorderSide(
              color: Colors.green,
              width: 2.5,
            ),
            top: BorderSide(
              color: Colors.green,
              width: 2.5,
            ),
            bottom: BorderSide(
              color: Colors.green,
              width: 2.5,
            ),
          ),
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        child: Row(
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              width: 140,
              height: 242,
              decoration: const BoxDecoration(
                border: BorderDirectional(
                  end: BorderSide(
                    color: Colors.green,
                    width: 2,
                  ),
                ),
                borderRadius: BorderRadiusDirectional.only(
                  topStart: Radius.circular(16),
                  bottomStart: Radius.circular(16),
                ),
              ),
              foregroundDecoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.6),
                    Colors.white.withOpacity(0.0),
                  ],
                  begin: AlignmentDirectional.bottomCenter,
                  end: AlignmentDirectional.center,
                  stops: const [0.0, 0.3],
                ),
              ),
              child: Image.network(
                recipeData['image'],
                fit: BoxFit.cover,
                height: 187,
                isAntiAlias: true,
                filterQuality: FilterQuality.high,
                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return Center(
                      child: GifView.asset(
                        "assets/gifs/loading_indicator.gif",
                        height: 187,
                        fadeDuration: const Duration(microseconds: 500),
                        frameRate: 30,
                      ),
                    );
                  }
                },
                errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                  return const Center(
                    child: Icon(
                      Icons.error,
                      color: Colors.red,
                      size: 40,
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsetsDirectional.only(start: 24, end: 12, top: 12, bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: BuildRecipeBasicInfo(
                        recipeData: recipeData,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (ctx) => RecipeDetailsScreen(
                                        recipeData: recipeData,
                                      ),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.green,
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: const BorderSide(
                                      color: Colors.green,
                                      width: 1.2,
                                    ),
                                  ),
                                ),
                                child: const Text(
                                  'Preview Recipe Details',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Poppins',
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
