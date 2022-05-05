import 'package:api_clima_dio_bloc/states/clima_states.dart';
import 'package:dio/dio.dart';

import '../model/model_clima.dart';

class RepositoryClima {
  final Dio dio;
  RepositoryClima({
    required this.dio,
  });
  Future<ModelClima> fetchClima(cidade) async {
    final url = 'https://goweather.herokuapp.com/weather/$cidade';
    final response = await dio.get(url);
    final body = response.data;
    final ModelClima json = ModelClima.fromJson(body);

    try {
      return json;
    } on DioError catch (e) {
      throw e;
    }
  }
}



//injeçao de independecia com modular 

//clean cod e nomeaçao 