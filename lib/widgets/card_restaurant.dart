import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/database_provider.dart';

import 'package:restaurant_app/common/navigation.dart';

import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/models/resturant_model.dart';

import 'package:restaurant_app/ui/detail_restaurant.dart';

class CardRestaurant extends StatelessWidget {
  final RestaurantElement restaurants;

  const CardRestaurant({
    Key? key,
    required this.restaurants,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<bool>(
          future: provider.isBookmarked(restaurants.id),
          builder: (context, snapshot) {
            var isBookmarked = snapshot.data ?? false;
            return Material(
              child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  leading: Hero(
                    tag: "${ApiService.getImage}${restaurants.pictureId!}",
                    child: Image.network(
                      "${ApiService.getImage}${restaurants.pictureId!}",
                      width: 100,
                    ),
                  ),
                  title: Text(
                    restaurants.name,
                  ),
                  subtitle: Text(restaurants.city ?? ""),
                  trailing: isBookmarked
                      ? IconButton(
                          icon: const Icon(Icons.bookmark),
                          color: Theme.of(context).colorScheme.secondary,
                          onPressed: () =>
                              provider.removeBookmark(restaurants.id),
                        )
                      : IconButton(
                          icon: const Icon(Icons.bookmark_border),
                          color: Theme.of(context).colorScheme.secondary,
                          onPressed: () => provider.addBookmark(restaurants),
                          key: Key(restaurants.name),
                        ),
                  onTap: () => Navigation.intentWithData(
                      DetailRestaurant.routeName, restaurants.id)),
            );
          },
        );
      },
    );
  }
}
