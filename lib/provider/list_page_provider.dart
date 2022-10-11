import 'dart:async';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/models/resturant_model.dart';

import 'package:flutter/material.dart';

enum ResultState { loading, noData, hasData, error }

enum SearchState { loading, noData, hasData, error, noQueri }

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;
  RestaurantProvider({required this.apiService}) {
    _fetchAllArticle();
  }
  late dynamic _restaurantResult;
  late ResultState _state;
  String _message = '';
  String get message => _message;
  String query = '';
  dynamic get result => _restaurantResult;
  ResultState get state => _state;

  Future<dynamic> _fetchAllArticle() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurantDetail = await apiService.getRestaurantList();
      _state = ResultState.hasData;
      notifyListeners();
      return _restaurantResult = restaurantDetail;
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Oops. Koneksi internet kamu mati!';
    }
  }
}
