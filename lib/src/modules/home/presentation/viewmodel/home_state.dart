import 'package:equatable/equatable.dart';
import 'package:rick_and_morty_api/src/modules/home/data/models/character_model.dart';
import 'package:rick_and_morty_api/src/modules/home/data/models/episode_model.dart';

enum HomeStateStatus { initial, loading, success, failure }

class HomeState extends Equatable {
  final HomeStateStatus status;
  final EpisodeModel? episode;
  final List<CharacterModel> characters;
  final String? errorMessage;

  const HomeState({
    this.status = HomeStateStatus.initial,
    this.episode,
    this.characters = const [],
    this.errorMessage,
  });

  @override
  List<Object?> get props => [status, episode, characters, errorMessage];

  HomeState copyWith({
    HomeStateStatus? status,
    EpisodeModel? episode,
    List<CharacterModel>? characters,
    String? errorMessage,
    bool clearError = false,
  }) {
    return HomeState(
      status: status ?? this.status,
      episode: episode ?? this.episode,
      characters: characters ?? this.characters,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}
