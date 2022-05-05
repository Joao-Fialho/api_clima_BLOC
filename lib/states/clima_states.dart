import 'package:flutter/cupertino.dart';

import '../model/model_clima.dart';

abstract class ClimaStates {}

class InitalClimaStates extends ClimaStates {}

class SuccessClimaStates extends ClimaStates {
  final ModelClima modelClima;
  SuccessClimaStates({
    required this.modelClima,
  });
  String getIconClima() {
    if (modelClima.description == 'Sunny') {
      return 'assets/image/iconSunny.jpg';
    } else if (modelClima.description == 'Partly cloudy') {
      return 'assets/image/iconPartlyCloudy.jpg';
    } else if (modelClima.description == 'Patchy rain possible') {
      return 'assets/image/iconPartlyRainPossible.jpg';
    } else {
      return 'assets/image/iconnublado.jpg';
    }
  }
}

class ErrorClimaStates extends ClimaStates {
  final String mensageErrror;

  ErrorClimaStates({this.mensageErrror = ''});
}

class LoadingClimaStates extends ClimaStates {}
