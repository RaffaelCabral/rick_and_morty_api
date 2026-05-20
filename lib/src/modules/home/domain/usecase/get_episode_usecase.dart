import 'package:rick_and_morty_api/src/modules/home/data/models/episode_model.dart';
import 'package:rick_and_morty_api/src/modules/home/data/repository/home_repository.dart';

class GetEpisodeUseCase {
  GetEpisodeUseCase(this._repository);

  final HomeRepository _repository;

  Future<EpisodeModel> call(int id) {
    if (id <= 0) {
      throw ArgumentError.value(
        id,
        'id',
        'O id do episódio deve ser maior que zero',
      );
    }

    return _repository.getEpisode(id);
  }
}
