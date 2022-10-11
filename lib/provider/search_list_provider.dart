import 'package:flutter/material.dart';
import 'dart:async';
import 'package:restaurant_app/data/models/resturant_model.dart';
import 'package:restaurant_app/data/api/api_service.dart';

enum SearchState { loading, noData, hasData, error, noQueri }

class SearchRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  // final String query;

  SearchRestaurantProvider({required this.apiService}) {
    fetcSearchResto(query);
  }

  late RestaurantSearch _searchResult;
  late SearchState _state;
  String _message = '';
  String query = '';

  String get message => _message;
  RestaurantSearch get result => _searchResult;
  SearchState get state => _state;

  Future<dynamic> fetcSearchResto(query) async {
    if (query != "") {
      try {
        _state = SearchState.loading;
        final search = await apiService.searchnameRestaurant(query);
        if (search.restaurants.isEmpty) {
          _state = SearchState.noData;
          notifyListeners();
          return _message = 'Restaurant yang Anda cari tidak ditemukan';
        } else {
          _state = SearchState.hasData;
          notifyListeners();
          return _searchResult = search;
        }
      } catch (e) {
        _state = SearchState.error;
        notifyListeners();
        return _message = 'Whoops. Kamu tidak tersambung dengan Internet!';
      }
    } else {
      _state = SearchState.noQueri;
      notifyListeners();
      return _message = 'No queri';
    }
  }

  void addQueri(String query) {
    this.query = query;
    fetcSearchResto(query);
    notifyListeners();
  }
}
