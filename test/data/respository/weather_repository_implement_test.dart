import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app_tdd/core/error/exceptions.dart';
import 'package:weather_app_tdd/core/error/failure.dart';
import 'package:weather_app_tdd/data/models/weather_model.dart';
import 'package:weather_app_tdd/data/repositories/weather_repository_impl.dart';
import 'package:weather_app_tdd/domain/entities/weather_entity.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockWeatherRemoteDataSource mockWeatherRemoteDataSource;
  late WeatherRepositoryImpl weatherRepositoryImpl;

  const testCityName = 'New York';

  setUp(() {
    mockWeatherRemoteDataSource = MockWeatherRemoteDataSource();
    weatherRepositoryImpl = WeatherRepositoryImpl(
        weatherRemoteDataSource: mockWeatherRemoteDataSource);
  });

  const testWeatherEntity = WeatherEntity(
    cityName: 'New York',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  const testWeatherModel = WeatherModel(
    cityName: 'New York',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  group('getting result from repository', () {
    test('getting data succesfully', () async {
      when(mockWeatherRemoteDataSource.getCurrentWeather(testCityName))
          .thenAnswer((_) => Future(() => testWeatherModel));

      final result =
          await weatherRepositoryImpl.getCurrentWeather(testCityName);

      expect(result, equals(Right(testWeatherEntity)));
    });

    test('getting data unsuccesfully', () async {
      when(mockWeatherRemoteDataSource.getCurrentWeather(testCityName))
          .thenThrow(ServerException());

      final result =
          await weatherRepositoryImpl.getCurrentWeather(testCityName);

      expect(result, equals(Left(ServerFailure('An error has occure'))));
    });
  });
}
