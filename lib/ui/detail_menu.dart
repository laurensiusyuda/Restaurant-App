import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/detail_page_provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/widgets/menu_restaurant_list.dart';

class MenuPageList extends StatelessWidget {
  const MenuPageList({super.key, required this.id});
  static const routeName = '/menuPage';
  final String id;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DetailRestaurantProvider>(
      create: (_) => DetailRestaurantProvider(apiService: ApiService(), id: id),
      child: Container(
        child: Consumer<DetailRestaurantProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.state == ResultState.hasData) {
              final restaurant = state.result;
              return Container(
                child: MenuList(
                  restaurant: restaurant,
                  foods: restaurant.restaurant.menus.foods,
                  drinks: restaurant.restaurant.menus.drinks,
                ),
              );
            } else if (state.state == ResultState.error) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return const Center(
                child: Text(''),
              );
            }
          },
        ),
      ),
    );
  }
}
