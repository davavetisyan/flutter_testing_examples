import 'package:mockito/annotations.dart';
import 'package:weather_app_tdd/data/datasources/weather_remote_data_source.dart';
import 'package:weather_app_tdd/domain/repositories/weather_repository.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app_tdd/domain/usecases/get_current_weather.dart';

@GenerateMocks([
  WeatherRepository,
  WeatherRemoteDataSource,
  GetCurrentWeatherUseCase, 

], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
