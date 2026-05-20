import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty_api/src/modules/home/data/exceptions/home_exceptions.dart';
import 'package:rick_and_morty_api/src/modules/home/domain/usecase/get_episode_characters_usecase.dart';
import 'package:rick_and_morty_api/src/modules/home/presentation/viewmodel/home_cubit.dart';
import 'package:rick_and_morty_api/src/modules/home/presentation/viewmodel/home_state.dart';

import '../../../../helpers/home_fixtures.dart';

class _MockGetEpisodeCharactersUseCase extends Mock
    implements GetEpisodeCharactersUseCase {}

Matcher _stateWith({required HomeStateStatus status, String? errorMessage}) {
  var matcher = isA<HomeState>().having(
    (state) => state.status,
    'status',
    status,
  );

  if (errorMessage != null) {
    matcher = matcher.having(
      (state) => state.errorMessage,
      'errorMessage',
      errorMessage,
    );
  }

  return matcher;
}

void main() {
  late GetEpisodeCharactersUseCase usecase;
  late HomeCubit cubit;

  setUp(() {
    usecase = _MockGetEpisodeCharactersUseCase();
    cubit = HomeCubit(getEpisodeCharacters: usecase);
  });

  tearDown(() async {
    await cubit.close();
  });

  blocTest<HomeCubit, HomeState>(
    'emite loading e success quando busca retorna dados',
    build: () {
      final episode = episodeModel();
      final characters = [characterModel()];
      when(
        () => usecase('28'),
      ).thenAnswer((_) async => (episode: episode, characters: characters));
      return cubit;
    },
    act: (cubit) => cubit.searchFromInput('28'),
    expect: () => [
      _stateWith(status: HomeStateStatus.loading),
      isA<HomeState>()
          .having((state) => state.status, 'status', HomeStateStatus.success)
          .having((state) => state.episode?.id, 'episode id', 28)
          .having((state) => state.characters.length, 'characters length', 1),
    ],
  );

  blocTest<HomeCubit, HomeState>(
    'mapeia HomeOfflineCacheException para failure com userMessage',
    build: () {
      when(
        () => usecase('28'),
      ).thenThrow(HomeOfflineCacheException('Sem dados offline'));
      return cubit;
    },
    act: (cubit) => cubit.searchFromInput('28'),
    expect: () => [
      _stateWith(status: HomeStateStatus.loading),
      _stateWith(
        status: HomeStateStatus.failure,
        errorMessage: 'Sem dados offline',
      ),
    ],
  );

  blocTest<HomeCubit, HomeState>(
    'mapeia HomeTimeoutException para failure com userMessage',
    build: () {
      when(() => usecase('28')).thenThrow(HomeTimeoutException());
      return cubit;
    },
    act: (cubit) => cubit.searchFromInput('28'),
    expect: () => [
      _stateWith(status: HomeStateStatus.loading),
      _stateWith(
        status: HomeStateStatus.failure,
        errorMessage: 'Tempo de conexão esgotado.',
      ),
    ],
  );

  blocTest<HomeCubit, HomeState>(
    'mapeia HomeNetworkException para failure com userMessage',
    build: () {
      when(() => usecase('28')).thenThrow(HomeNetworkException());
      return cubit;
    },
    act: (cubit) => cubit.searchFromInput('28'),
    expect: () => [
      _stateWith(status: HomeStateStatus.loading),
      _stateWith(
        status: HomeStateStatus.failure,
        errorMessage: 'Sem conexão com a internet.',
      ),
    ],
  );

  blocTest<HomeCubit, HomeState>(
    'mapeia HomeEpisodeNotFoundException para failure com userMessage',
    build: () {
      when(() => usecase('28')).thenThrow(HomeEpisodeNotFoundException());
      return cubit;
    },
    act: (cubit) => cubit.searchFromInput('28'),
    expect: () => [
      _stateWith(status: HomeStateStatus.loading),
      _stateWith(
        status: HomeStateStatus.failure,
        errorMessage: 'Episódio não encontrado.',
      ),
    ],
  );

  blocTest<HomeCubit, HomeState>(
    'mapeia ArgumentError para failure com mensagem do argumento',
    build: () {
      when(
        () => usecase(''),
      ).thenThrow(ArgumentError('Informe o número do episódio.'));
      return cubit;
    },
    act: (cubit) => cubit.searchFromInput(''),
    expect: () => [
      _stateWith(status: HomeStateStatus.loading),
      _stateWith(
        status: HomeStateStatus.failure,
        errorMessage: 'Informe o número do episódio.',
      ),
    ],
  );

  blocTest<HomeCubit, HomeState>(
    'mapeia erro inesperado para mensagem genérica',
    build: () {
      when(() => usecase('28')).thenThrow(Exception('boom'));
      return cubit;
    },
    act: (cubit) => cubit.searchFromInput('28'),
    expect: () => [
      _stateWith(status: HomeStateStatus.loading),
      _stateWith(
        status: HomeStateStatus.failure,
        errorMessage: 'Erro inesperado. Tente novamente.',
      ),
    ],
  );
}
