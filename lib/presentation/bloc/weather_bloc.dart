import 'package:weather_app_tdd/domain/usecases/get_current_weather.dart';
import 'package:weather_app_tdd/presentation/bloc/weather_event.dart';
import 'package:weather_app_tdd/presentation/bloc/weather_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';


class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc(this._getCurrentWeatherUseCase) : super(WetherEmpty()) {
    on<OnCityChange>(
      _onCityChangeHandler,
      transformer: (events, mapper) {
        return events.debounceTime(const Duration(milliseconds: 300)).asyncExpand(mapper);
      },
    );
  }

  final GetCurrentWeatherUseCase _getCurrentWeatherUseCase;

  _onCityChangeHandler(OnCityChange event, emit) async {
    emit(WeatherLoading());

    final result = await _getCurrentWeatherUseCase.execute(event.cityName);

    result.fold((failure) {
      emit(WeatherLoadError(message: failure.message));
    }, (succes) {
      emit(WeatherLoaded(result: succes));
    });
  }
}


// EventTransformer<T> debounce<T>(Duration duration) {
//   return (events, mapper) => events.debounceTime()
// } 