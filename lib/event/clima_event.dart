abstract class ClimaEvent {}

class FetchClimaByCity extends ClimaEvent {
  String cidade;
  FetchClimaByCity({
    this.cidade = 'Maringa',
  });
}
