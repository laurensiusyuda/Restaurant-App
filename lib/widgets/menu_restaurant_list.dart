import 'package:flutter/material.dart';
import 'package:restaurant_app/data/models/resturant_model.dart';

class MenuList extends StatelessWidget {
  final RestaurantDetail restaurant;
  final List<Category> drinks;
  final List<Category> foods;
  const MenuList(
      {super.key,
      required this.drinks,
      required this.foods,
      required this.restaurant});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(restaurant.restaurant.name),
        ),
        body: Center(
          child: Container(
            height: (MediaQuery.of(context).size.height),
            margin: const EdgeInsets.all(5),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Menu Makanan dan Minum",
                  style: Theme.of(context).textTheme.headline5,
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: drinks.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding: const EdgeInsets.all(5),
                        child: Card(
                          child: Column(
                            children: [
                              Text(
                                drinks[index].name,
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: foods.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding: const EdgeInsets.all(5),
                        child: Card(
                          child: Column(
                            children: [
                              Text(
                                foods[index].name,
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
