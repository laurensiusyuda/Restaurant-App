import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/models/resturant_model.dart';

class ApiService {
  final http.Client client;
  static const String getImage =
      "https://restaurant-api.dicoding.dev/images/small/";

  ApiService(this.client);

// * mengambil semua data
  Future<Restaurant> getRestaurantList() async {
    final response =
        await client.get(Uri.parse("https://restaurant-api.dicoding.dev/list"));
    if (response.statusCode == 200) {
      return Restaurant.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to Data');
    }
  }

//* mengambil data berdasarkan id
  Future<RestaurantDetail> getDetailRestaurant(String id) async {
    final response = await client
        .get(Uri.parse("https://restaurant-api.dicoding.dev/detail/$id"));
    if (response.statusCode == 200) {
      return RestaurantDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed Load Restaurant');
    }
  }

//* melakukan list data berdasarkan query
  Future<RestaurantSearch> searchnameRestaurant(String query) async {
    final response = await client
        .get(Uri.parse("https://restaurant-api.dicoding.dev/search?q=$query"));
    if (response.statusCode == 200) {
      return RestaurantSearch.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to Search Restaurant');
    }
  }
}
