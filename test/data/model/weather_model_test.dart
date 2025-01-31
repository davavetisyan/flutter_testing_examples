import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app_tdd/data/models/weather_model.dart';
import 'package:weather_app_tdd/domain/entities/weather_entity.dart';

import '../../helpers/json_reader.dart';

void main() {
  const testWeatherModel = WeatherModel(
    cityName: 'New York',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );
  test(
    'should be a subclass of Weather entity',
    () async {
      //arange
      //act
      //assert
      expect(testWeatherModel, isA<WeatherEntity>());
    },
  );

  test(
    'should return valid model from json',
    () async {
      //arange

      Map<String, dynamic> json = jsonDecode(
          readJson('helpers/dummy_data/dummy_weather_response.json'));
      //act
      final result = WeatherModel.fromJson(json);

      //assert
      expect(testWeatherModel, equals(testWeatherModel));
    },
  );

  test(
    'should return valid json from to json ',
    () async {
      //arange

      //act
      final result = testWeatherModel.toJson();

      final expectedJsonMap = {
        'weather': [
          {
            'main': 'Clouds',
            'description': 'few clouds',
            'icon': '02d',
          },
        ],
        'main': {
          'temp': 302.28,
          'pressure': 1009,
          'humidity': 70,
        },
        'name': 'New York',
      };

      //assert
      expect(result, expectedJsonMap);
    },
  );
}
