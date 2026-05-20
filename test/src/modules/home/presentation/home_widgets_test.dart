import 'package:bloc_test/bloc_test.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty_api/src/modules/home/presentation/view/home_page.dart';
import 'package:rick_and_morty_api/src/modules/home/presentation/viewmodel/home_cubit.dart';
import 'package:rick_and_morty_api/src/modules/home/presentation/viewmodel/home_state.dart';
import 'package:rick_and_morty_api/src/modules/home/presentation/widgets/character_card.dart';

import '../../../../helpers/home_fixtures.dart';

class _MockHomeCubit extends MockCubit<HomeState> implements HomeCubit {}

Future<void> _pumpHomePage(
  WidgetTester tester,
  HomeCubit cubit,
  HomeState state,
) async {
  whenListen(cubit, const Stream<HomeState>.empty(), initialState: state);

  await tester.pumpWidget(
    MaterialApp(
      home: BlocProvider<HomeCubit>.value(
        value: cubit,
        child: const HomePage(),
      ),
    ),
  );
}

void main() {
  late _MockHomeCubit cubit;

  setUp(() {
    cubit = _MockHomeCubit();
  });

  group('HomePage', () {
    testWidgets('renderiza estado inicial com título, campo e mensagem', (
      tester,
    ) async {
      await _pumpHomePage(tester, cubit, const HomeState());

      expect(find.text('The Chaos Archive'), findsOneWidget);
      expect(find.text('Buscar por episódio'), findsOneWidget);
      expect(find.text('Número do episódio'), findsOneWidget);
      expect(
        find.textContaining('Explore os personagens de cada episódio'),
        findsOneWidget,
      );
    });

    testWidgets(
      'ao buscar chama HomeCubit.searchFromInput com texto digitado',
      (tester) async {
        when(() => cubit.searchFromInput(any())).thenAnswer((_) async {});
        await _pumpHomePage(tester, cubit, const HomeState());

        await tester.enterText(find.byType(TextField), '28');
        await tester.tap(find.byIcon(Icons.search));
        await tester.pump();

        verify(() => cubit.searchFromInput('28')).called(1);
      },
    );

    testWidgets('estado loading exibe gif de portal', (tester) async {
      await _pumpHomePage(
        tester,
        cubit,
        const HomeState(status: HomeStateStatus.loading),
      );

      final image = tester.widget<Image>(find.byType(Image));

      expect(image.image, isA<AssetImage>());
      expect(
        (image.image as AssetImage).assetName,
        'assets/gifs/rick_and_morty_api_loading.gif',
      );
      expect(find.text('Abrindo o portal...'), findsOneWidget);
    });

    testWidgets('estado failure exibe mensagem de erro', (tester) async {
      await _pumpHomePage(
        tester,
        cubit,
        const HomeState(
          status: HomeStateStatus.failure,
          errorMessage: 'Falha ao carregar',
        ),
      );

      expect(find.text('Falha ao carregar'), findsOneWidget);
    });

    testWidgets('estado success exibe header do episódio e cards', (
      tester,
    ) async {
      final episode = episodeModel(name: 'The Ricklantis Mixup');
      final characters = [
        characterModel(id: 1, name: 'Rick Sanchez'),
        characterModel(id: 2, name: 'Morty Smith'),
      ];

      await _pumpHomePage(
        tester,
        cubit,
        HomeState(
          status: HomeStateStatus.success,
          episode: episode,
          characters: characters,
        ),
      );

      expect(find.text('The Ricklantis Mixup'), findsOneWidget);
      expect(find.text('Rick Sanchez'), findsOneWidget);
      expect(find.text('Morty Smith'), findsOneWidget);
      expect(find.byType(CharacterCard), findsNWidgets(2));
    });
  });

  group('CharacterCard', () {
    testWidgets('exibe nome, espécie, status e configura CachedNetworkImage', (
      tester,
    ) async {
      final character = characterModel();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 220,
              height: 320,
              child: CharacterCard(character: character),
            ),
          ),
        ),
      );

      final image = tester.widget<CachedNetworkImage>(
        find.byType(CachedNetworkImage),
      );

      expect(find.text('Rick Sanchez'), findsOneWidget);
      expect(find.text('Human'), findsOneWidget);
      expect(find.text('Alive'), findsOneWidget);
      expect(image.imageUrl, character.image);
    });
  });
}
