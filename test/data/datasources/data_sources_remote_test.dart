import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app_tdd/core/constants/constants.dart';
import 'package:weather_app_tdd/core/error/exceptions.dart';
import 'package:weather_app_tdd/data/datasources/weather_remote_data_source.dart';
import 'package:weather_app_tdd/data/models/weather_model.dart';

import '../../helpers/json_reader.dart';
import '../../helpers/test_helper.mocks.dart';
import 'package:http/http.dart' as http;

void main() {
  late MockHttpClient mockHttpClient;
  late WeatherRemoteDataSourceImpl weatherRemoteDataSourceImpl;
  setUp(() {
    mockHttpClient = MockHttpClient();
    weatherRemoteDataSourceImpl =
        WeatherRemoteDataSourceImpl(client: mockHttpClient);
  });

  const testCityName = 'New York';

  group('get current weather ', () {
    test('getting data succesfully', () async {
      //arange
      when(mockHttpClient
              .get(Uri.parse(Urls.currentWeatherByName(testCityName))))
          .thenAnswer(
        (_) async => http.Response(
            readJson('helpers/dummy_data/dummy_weather_response.json'), 201),
      );
      //act

      final result =
          await weatherRemoteDataSourceImpl.getCurrentWeather(testCityName);
      //assert

      expect(result, isA<WeatherModel>());
    });

    test('getting data unsuccesfully', () async {
      //arange
      when(mockHttpClient
              .get(Uri.parse(Urls.currentWeatherByName(testCityName))))
          .thenAnswer(
        (_) async => http.Response("Not Found", 404),
      );
      //act

      final result;

      try {
        result =
            await weatherRemoteDataSourceImpl.getCurrentWeather(testCityName);
      } catch (err) {
        expect(err, isA<ServerException>());
      }
      //assert
    });
  });
}
