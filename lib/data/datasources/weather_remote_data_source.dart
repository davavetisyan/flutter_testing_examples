import 'dart:convert';

import 'package:weather_app_tdd/core/error/exceptions.dart';
import 'package:weather_app_tdd/data/models/weather_model.dart';
import 'package:http/http.dart' as http;

import '../../core/constants/constants.dart';

abstract class WeatherRemoteDataSource {
  Future<WeatherModel> getCurrentWeather(String cityName);
}

class WeatherRemoteDataSourceImpl extends WeatherRemoteDataSource {
  final http.Client client;

  WeatherRemoteDataSourceImpl({required this.client});

  @override
  Future<WeatherModel> getCurrentWeather(String cityName) async {
    try {
      final response =
          await client.get(Uri.parse(Urls.currentWeatherByName(cityName)));

      if (response.statusCode == 201) {
        return WeatherModel.fromJson(jsonDecode(response.body));
      } else {
        throw ServerException();
      }
    } catch (err) {
      rethrow;
    }
  }
}
