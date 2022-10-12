import 'package:flutter/material.dart';
import 'package:fsearch/fsearch.dart';
import 'package:provider/provider.dart';

import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/widgets/card_restaurant.dart';
import 'package:restaurant_app/provider/search_list_provider.dart';
import 'package:http/http.dart' as http;

class SearchRestaurant extends StatelessWidget {
  const SearchRestaurant({super.key});
  static const routeName = '/resto_search';
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SearchRestaurantProvider>(
      create: (_) =>
          SearchRestaurantProvider(apiService: ApiService(http.Client())),
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Search Page Restaurant'),
            backgroundColor: secondaryColor,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black45,
                )),
          ),
          body: const SingleChildScrollView(child: AnimatedTextSearch())),
    );
  }
}

class AnimatedTextSearch extends StatelessWidget {
  const AnimatedTextSearch({super.key});
  @override
  Widget build(BuildContext context) {
    final searhResataurant =
        Provider.of<SearchRestaurantProvider>(context, listen: false);
    return Container(
      width: (MediaQuery.of(context).size.width),
      height: (MediaQuery.of(context).size.height),
      margin: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: FSearch(
              // * mengatur tinggi dan lebar colom search
              height: 70,
              width: (MediaQuery.of(context).size.width),
              backgroundColor: primaryColor,
              shadowColor: Colors.black87,
              shadowBlur: 5.0,
              shadowOffset: const Offset(2.0, 2.0),
              hints: const [
                'Masukan Teks',
                'Restaurant Favorite Button',
              ],
              hintSwitchEnable: true,
              hintSwitchType: FSearchAnimationType.Fade,
              onSearch: (value) {
                searhResataurant.addQueri(value);
              },
            ),
          ),
// * membuat consumer
          Consumer<SearchRestaurantProvider>(
            builder: (context, result, _) {
              if (result.state == SearchState.noQueri) {
                return Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: const Icon(
                        Icons.search,
                        size: 100,
                        color: secondaryColor,
                      ),
                    ),
                    Text(
                      "Silahkan Masukan Nama Restaurant",
                      style: Theme.of(context).textTheme.subtitle1,
                    )
                  ],
                );
              } else if (result.state == SearchState.loading) {
                return Center(
                  child: Container(
                      margin: const EdgeInsets.all(10),
                      child: const CircularProgressIndicator()),
                );
              } else if (result.state == SearchState.hasData) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: result.result.restaurants.length,
                    itemBuilder: (context, index) {
                      var restaurants = result.result.restaurants[index];
                      return CardRestaurant(
                        restaurants: restaurants,
                      );
                    },
                  ),
                );
              } else if (result.state == SearchState.noData) {
                return Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      'No list restaurant you want',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                );
              } else if (result.state == SearchState.error) {
                return Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      "Whoops. Kamu tidak tersambung dengan Internet!",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                );
              } else {
                return const Center(child: Text(''));
              }
            },
          ),
        ],
      ),
    );
  }
}
