import 'package:api_clima_dio_bloc/event/clima_event.dart';
import 'package:api_clima_dio_bloc/states/clima_states.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/model_clima.dart';
import '../repository/repositotry_clima.dart';

class ControllerClima extends Bloc<ClimaEvent, ClimaStates> {
  final RepositoryClima repository;
  ControllerClima(value, this.repository) : super(InitalClimaStates()) {
    on<FetchClimaByCity>(_getClimaByCity);
  }

  Future<void> _getClimaByCity(
      FetchClimaByCity event, Emitter<ClimaStates> emit) async {
    emit(LoadingClimaStates());
    try {
      final modelClima = await repository.fetchClima(event.cidade);
      emit(SuccessClimaStates(modelClima: modelClima));
    } catch (e) {
      emit(ErrorClimaStates(mensageErrror: (e as DioError).message));
    }
  }

  //

  // void onChange(value) {
  //   add(FetchClimaByCity(cidade: value.toString()));
  // }
}
