import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/detail_page_provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/ui/detail_menu.dart';
import 'package:http/http.dart' as http;

class DescriptionRestaurant extends StatelessWidget {
  static const routeName = '/deskripsi';
  final String id;
  DescriptionRestaurant({Key? key, required this.id}) : super(key: key);
  // * create padding and margin
  double deviceHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;
  double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DetailRestaurantProvider>(
      create: (_) => DetailRestaurantProvider(
          apiService: ApiService(http.Client()), id: id),
      child: Scaffold(
        body: Consumer<DetailRestaurantProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.state == ResultState.hasData) {
              final restaurant = state.result;
              return Scaffold(
                body: SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Stack(
                          children: <Widget>[
                            // * image
                            Container(
                              margin: const EdgeInsets.all(5),
                              height:
                                  (MediaQuery.of(context).size.height * 0.55),
                              child: Hero(
                                tag:
                                    "${ApiService.getImage}${restaurant.restaurant.pictureId}",
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(5),
                                      bottomRight: Radius.circular(5),
                                    ),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          "${ApiService.getImage}${restaurant.restaurant.pictureId!}"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // * button back
                            Container(
                              margin: EdgeInsets.only(
                                  top: deviceHeight(context) * 0.05,
                                  left: deviceWidth(context) * 0.02),
                              child: CircleAvatar(
                                backgroundColor: Colors.grey,
                                // * membuat icon button
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            ),
                            // * konten
                            Container(
                              // * body
                              margin: EdgeInsets.only(
                                  top: deviceHeight(context) * 0.4),
                              width: (MediaQuery.of(context).size.width),
                              decoration: const BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(70),
                                  topLeft: Radius.circular(70),
                                ),
                              ),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    restaurant.restaurant.name,
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  ),
                                  Text(
                                    restaurant.restaurant.city,
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                  Text(
                                    restaurant.restaurant.rating.toString(),
                                    style:
                                        Theme.of(context).textTheme.subtitle2,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(15),
                                    child: Text(
                                      restaurant.restaurant.description,
                                      textAlign: TextAlign.justify,
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: ElevatedButton(
                                        style: raisedButtonStyle,
                                        child: Text('Menu',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1),
                                        onPressed: () {
                                          Navigator.pushNamed(
                                            context,
                                            MenuPageList.routeName,
                                            arguments: restaurant.restaurant.id,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // * ---- *//
                          ],
                        ),
                      ],
                    ),
                  ),
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

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: Colors.black87,
    primary: const Color.fromRGBO(224, 224, 224, 1),
    minimumSize: Size(200, 50),
    padding: const EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2)),
    ),
  );
}
