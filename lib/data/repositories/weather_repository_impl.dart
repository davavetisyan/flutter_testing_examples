import 'package:dartz/dartz.dart';
import 'package:weather_app_tdd/core/error/exceptions.dart';
import 'package:weather_app_tdd/core/error/failure.dart';
import 'package:weather_app_tdd/data/datasources/weather_remote_data_source.dart';
import 'package:weather_app_tdd/domain/entities/weather_entity.dart';
import 'package:weather_app_tdd/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource weatherRemoteDataSource;

  WeatherRepositoryImpl({required this.weatherRemoteDataSource});

  @override
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(String city) async {
    try {
      final result = await weatherRemoteDataSource.getCurrentWeather(city);

      return Right(result.toEntity());
    } on ServerException catch (err) {
      return Left(ServerFailure('An error has occure'));
    }
  }
}
