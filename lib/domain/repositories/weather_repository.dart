import 'package:dartz/dartz.dart';
import 'package:weather_app_tdd/core/error/failure.dart';
import 'package:weather_app_tdd/domain/entities/weather_entity.dart';

abstract class WeatherRepository {
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(String city);
}
