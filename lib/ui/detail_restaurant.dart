import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/provider/detail_page_provider.dart';
import 'package:restaurant_app/ui/description.dart';

class DetailRestaurant extends StatelessWidget {
  static const routeName = '/restaurant_detail';
  final String id;
  const DetailRestaurant({Key? key, required this.id}) : super(key: key);

  // * create padding and margin
  double deviceHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;
  double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DetailRestaurantProvider>(
      create: (_) => DetailRestaurantProvider(apiService: ApiService(), id: id),
      child: Scaffold(
        body: Consumer<DetailRestaurantProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.state == ResultState.hasData) {
              final restaurantData = state.result;
              return Scaffold(
                appBar: AppBar(
                  title: Text(
                    restaurantData.restaurant.name,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                body: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          // * --------- *//
                          // * Picture
                          Center(
                            child: Hero(
                              tag:
                                  "${ApiService.getImage}${restaurantData.restaurant.pictureId!}",
                              child: Container(
                                margin: EdgeInsets.only(
                                    top: deviceHeight(context) * 0.02,
                                    left: deviceWidth(context) * 0.02,
                                    right: deviceWidth(context) * 0.02,
                                    bottom: deviceHeight(context) * 0.02),
                                width: (MediaQuery.of(context).size.width),
                                height:
                                    (MediaQuery.of(context).size.height * 0.8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        "${ApiService.getImage}${restaurantData.restaurant.pictureId!}"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // * Navigation Bar
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 4,
                                child: Container(
                                  margin: EdgeInsets.only(
                                      top: deviceHeight(context) * 0.75,
                                      left: deviceWidth(context) * 0.05),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black,
                                        width: 5.0,
                                        style: BorderStyle.solid),
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.grey,
                                  ),
                                  child: Center(
                                    child: Text(
                                      restaurantData.restaurant.name,
                                      style:
                                          Theme.of(context).textTheme.headline5,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  margin: EdgeInsets.only(
                                      top: deviceHeight(context) * 0.75,
                                      right: deviceWidth(context) * 0.05),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.black,
                                    // * membuat icon button
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.arrow_forward,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        Navigator.pushNamed(context,
                                            DescriptionRestaurant.routeName,
                                            arguments:
                                                restaurantData.restaurant.id);
                                      },
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
              );
            } else if (state.state == ResultState.noData) {
              return Center(
                child: Text(state.message),
              );
            } else if (state.state == ResultState.error) {
              return Center(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 200),
                      width: 100,
                      height: 100,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/icons/nowifi.png'))),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        state.message,
                      ),
                    )
                  ],
                ),
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
