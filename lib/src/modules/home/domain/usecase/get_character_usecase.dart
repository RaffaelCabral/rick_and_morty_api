import 'package:rick_and_morty_api/src/modules/home/data/models/character_model.dart';
import 'package:rick_and_morty_api/src/modules/home/data/repository/home_repository.dart';

class GetCharacterUseCase {
  GetCharacterUseCase(this._repository);

  final HomeRepository _repository;

  Future<CharacterModel> call(int id) {
    if (id <= 0) {
      throw ArgumentError.value(
        id,
        'id',
        'O id do personagem deve ser maior que zero',
      );
    }

    return _repository.getCharacter(id);
  }
}
