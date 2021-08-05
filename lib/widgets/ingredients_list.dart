import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:meals/widgets/ingredients_list_item.dart';

class IngredientsList extends StatelessWidget {
  final List<String> ingredients;
  final _controller = ScrollController();
  final _height = 30.0;

  IngredientsList({Key? key, required this.ingredients}) : super(key: key);

  scrollTo() async {
    await Future.delayed(const Duration(milliseconds: 100));
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      if (_controller.hasClients) {
        _controller.animateTo(_controller.position.maxScrollExtent,
            duration: const Duration(milliseconds: 150),
            curve: Curves.fastOutSlowIn);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) => scrollTo());
    return ListView(
      controller: _controller,
      children: getIngredients(),
    );
  }

  List<Widget> getIngredients() {
    return ingredients
        .map((ingredient) => IngredientsListItem(ingredient: ingredient))
        .toList();
  }
}
