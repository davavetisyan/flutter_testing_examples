import 'package:equatable/equatable.dart';
import 'package:weather_app_tdd/domain/entities/weather_entity.dart';

abstract class WeatherState extends Equatable {}

class WetherEmpty extends WeatherState {
  @override
  List<Object?> get props => [];
}

class WeatherLoading extends WeatherState {
  @override
  List<Object?> get props => [];
}

class WeatherLoaded extends WeatherState {
  final WeatherEntity result;

  WeatherLoaded({required this.result});

  @override
  List<Object?> get props => [result];
}

class WeatherLoadError extends WeatherState {
  final String message;

  WeatherLoadError({required this.message});

  @override
  List<Object?> get props => [message];
}
