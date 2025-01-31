import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app_tdd/domain/entities/weather_entity.dart';
import 'package:weather_app_tdd/domain/usecases/get_current_weather.dart';
import 'package:weather_app_tdd/presentation/bloc/weather_bloc.dart';
import 'package:weather_app_tdd/presentation/bloc/weather_event.dart';
import 'package:weather_app_tdd/presentation/bloc/weather_state.dart';
import 'package:bloc_test/bloc_test.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockGetCurrentWeatherUseCase getCurrentWeatherUseCase;
  late WeatherBloc weatherBloc;

  const testWeatherEntity = WeatherEntity(
    cityName: 'New York',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  const testCityName = 'New York';

  setUp(() {
    getCurrentWeatherUseCase = MockGetCurrentWeatherUseCase();
    weatherBloc = WeatherBloc(getCurrentWeatherUseCase);
  });

  test('initial state is WeatherEmpty', () {
    expect(weatherBloc.state, isA<WetherEmpty>());
  });

  blocTest<WeatherBloc, WeatherState>(
    'should emit WeatherLoading than WeatherLoaded',
    build: () {
      when(getCurrentWeatherUseCase.execute(testCityName))
          .thenAnswer((_) => Future(() => Right(testWeatherEntity)));
        return weatherBloc;
    },
    act: (bloc) {
      bloc.add(OnCityChange(cityName: testCityName));
    },
    wait: Duration(milliseconds: 500), 
    expect: ()=> {
      WeatherLoading(), 
      WeatherLoaded(result: testWeatherEntity), 
    }
  );
}
