import 'dart:async';
import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';

enum ResultState { loading, noData, hasData, error }

class DetailRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;
  final String id;

  DetailRestaurantProvider({required this.apiService, required this.id}) {
    _fetchRestaurantDetail(id);
  }

  late dynamic _restaurantResult;
  late ResultState _state;
  String _message = '';
  String get message => _message;
  dynamic get result => _restaurantResult;
  ResultState get state => _state;

  Future<dynamic> _fetchRestaurantDetail(String id) async {
    try {
      _state = ResultState.loading;
      final restaurantDetail = await apiService.getDetailRestaurant(id);
      notifyListeners();
      _state = ResultState.hasData;
      _restaurantResult = restaurantDetail;
      notifyListeners();
      return _restaurantResult;
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Oops. Koneksi internet kamu mati!';
    }
  }
}
