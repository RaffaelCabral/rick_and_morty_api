import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_api/src/modules/home/data/local/home_offline_exceptions.dart';
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
    } on OfflineCacheException catch (e) {
      emit(
        state.copyWith(
          status: HomeStateStatus.failure,
          errorMessage: e.message,
        ),
      );
    } on DioException catch (e) {
      emit(
        state.copyWith(
          status: HomeStateStatus.failure,
          errorMessage: _mapDioError(e),
        ),
      );
    } on ArgumentError catch (e) {
      emit(
        state.copyWith(
          status: HomeStateStatus.failure,
          errorMessage: e.message?.toString() ?? 'Parâmetro inválido',
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: HomeStateStatus.failure,
          errorMessage: 'Erro inesperado. Tente novamente.',
        ),
      );
    }
  }

  String _mapDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return 'Tempo de conexão esgotado.';
      case DioExceptionType.connectionError:
        return 'Sem conexão com a internet.';
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        if (statusCode == 404) return 'Episódio não encontrado.';
        return 'Erro no servidor (${statusCode ?? 'desconhecido'}).';
      default:
        return e.message ?? 'Falha na requisição.';
    }
  }
}
