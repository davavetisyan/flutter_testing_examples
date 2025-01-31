import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {}

class OnCityChange extends WeatherEvent {
  final String cityName;

  OnCityChange({required this.cityName});
  @override
  List<Object?> get props => [cityName];
}
