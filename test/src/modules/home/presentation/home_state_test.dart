import 'package:flutter_test/flutter_test.dart';
import 'package:rick_and_morty_api/src/modules/home/presentation/viewmodel/home_state.dart';

import '../../../../helpers/home_fixtures.dart';

void main() {
  group('HomeState', () {
    test('estado inicial tem valores padrão', () {
      const state = HomeState();

      expect(state.status, HomeStateStatus.initial);
      expect(state.episode, isNull);
      expect(state.characters, isEmpty);
      expect(state.errorMessage, isNull);
    });

    test('copyWith clearEpisode remove episódio', () {
      final state = HomeState(episode: episodeModel());

      final next = state.copyWith(clearEpisode: true);

      expect(next.episode, isNull);
    });

    test('copyWith clearError remove erro', () {
      const state = HomeState(errorMessage: 'Erro');

      final next = state.copyWith(clearError: true);

      expect(next.errorMessage, isNull);
    });
  });
}
