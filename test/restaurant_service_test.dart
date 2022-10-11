import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/models/resturant_model.dart';

import 'restaurant_service_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('Testing Restaurant List', () {
    test('return restaurant list if the http call completes successfully',
        () async {
      final client = MockClient();
      final jsonFile = File('test/assets/restaurant_list.json');
      final resultActual = await jsonFile.readAsString();
      when(client.get(Uri.parse('https://restaurant-api.dicoding.dev/list')))
          .thenAnswer((_) async => http.Response(resultActual, 200));
      expect(await ApiService().getRestaurantList(), isA<Restaurant>());
    });
    test('return restaurant detail if the http call completes successfully',
        () async {
      final client = MockClient();
      final jsonFile = File('test/assets/restaurant_detail.json');
      final resultActual = await jsonFile.readAsString();
      when(client.get(Uri.parse(
              'https://restaurant-api.dicoding.dev/detail/rqdv5juczeskfw1e867')))
          .thenAnswer((_) async => http.Response(resultActual, 200));
      expect(await ApiService().getDetailRestaurant('s1knt6za9kkfw1e867'),
          isA<RestaurantDetail>());
    });
  });
}
