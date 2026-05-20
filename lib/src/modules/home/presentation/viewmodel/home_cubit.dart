import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_api/src/modules/home/data/exceptions/home_exceptions.dart';
import 'package:rick_and_morty_api/src/modules/home/domain/usecase/get_episode_characters_usecase.dart';
import 'package:rick_and_morty_api/src/modules/home/presentation/viewmodel/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required GetEpisodeCharactersUseCase getEpisodeCharacters})
    : _getEpisodeCharacters = getEpisodeCharacters,
      super(const HomeState());

  final GetEpisodeCharactersUseCase _getEpisodeCharacters;

  Future<void> searchFromInput(String rawInput) async {
    emit(
      state.copyWith(
        status: HomeStateStatus.loading,
        characters: const [],
        clearEpisode: true,
        clearError: true,
      ),
    );

    try {
      final result = await _getEpisodeCharacters(rawInput);

      emit(
        state.copyWith(
          status: HomeStateStatus.success,
          episode: result.episode,
          characters: result.characters,
        ),
      );
    } on HomeException catch (e) {
      emit(
        state.copyWith(
          status: HomeStateStatus.failure,
          characters: const [],
          errorMessage: e.userMessage,
          clearEpisode: true,
        ),
      );
    } on ArgumentError catch (e) {
      emit(
        state.copyWith(
          status: HomeStateStatus.failure,
          characters: const [],
          errorMessage: e.message?.toString() ?? 'Parâmetro inválido',
          clearEpisode: true,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: HomeStateStatus.failure,
          characters: const [],
          errorMessage: 'Erro inesperado. Tente novamente.',
          clearEpisode: true,
        ),
      );
    }
  }
}
