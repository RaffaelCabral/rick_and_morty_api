import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty_api/src/modules/core/connectivity/connectivity_service.dart';
import 'package:rick_and_morty_api/src/modules/core/di/service_locator.dart';
import 'package:rick_and_morty_api/src/modules/core/http_service/api_constants.dart';
import 'package:rick_and_morty_api/src/modules/core/http_service/dio_service.dart';
import 'package:rick_and_morty_api/src/modules/core/routes/app_router.dart';
import 'package:rick_and_morty_api/src/modules/home/data/datasource/home_local_datasource_impl.dart';
import 'package:rick_and_morty_api/src/modules/home/data/datasource/home_remote_datasource_impl.dart';
import 'package:rick_and_morty_api/src/modules/home/data/local/home_cache_database.dart';
import 'package:rick_and_morty_api/src/modules/home/data/repository/home_repository.dart';
import 'package:rick_and_morty_api/src/modules/home/domain/usecase/get_episode_characters_usecase.dart';
import 'package:rick_and_morty_api/src/modules/home/presentation/viewmodel/home_cubit.dart';

class _MockConnectivity extends Mock implements Connectivity {}

void main() {
  group('HttpService', () {
    test('configura baseUrl, timeouts, headers e validateStatus', () {
      final service = HttpService();
      final options = service.client.options;

      expect(options.baseUrl, ApiConstants.baseUrl);
      expect(options.connectTimeout, ApiConstants.connectTimeout);
      expect(options.receiveTimeout, ApiConstants.receiveTimeout);
      expect(options.sendTimeout, ApiConstants.sendTimeout);
      expect(options.headers['Content-Type'], 'application/json');
      expect(options.headers['Accept'], 'application/json');
      expect(options.validateStatus(200), isTrue);
      expect(options.validateStatus(299), isTrue);
      expect(options.validateStatus(300), isFalse);
      expect(options.validateStatus(null), isFalse);
    });
  });

  group('ConnectivityServiceImpl', () {
    late Connectivity connectivity;
    late ConnectivityServiceImpl service;

    setUp(() {
      connectivity = _MockConnectivity();
      service = ConnectivityServiceImpl(connectivity);
    });

    test('retorna false quando só existe ConnectivityResult.none', () async {
      when(
        () => connectivity.checkConnectivity(),
      ).thenAnswer((_) async => [ConnectivityResult.none]);

      expect(await service.hasConnection, isFalse);
    });

    test('retorna true quando existe qualquer conexão válida', () async {
      when(() => connectivity.checkConnectivity()).thenAnswer(
        (_) async => [ConnectivityResult.none, ConnectivityResult.wifi],
      );

      expect(await service.hasConnection, isTrue);
    });
  });

  group('Service locator', () {
    tearDown(() async {
      await getIt.reset();
    });

    test(
      'registra tipos principais e pode ser chamado mais de uma vez',
      () async {
        await setupDependencies();
        await setupDependencies();

        expect(getIt.isRegistered<Connectivity>(), isTrue);
        expect(getIt.isRegistered<ConnectivityService>(), isTrue);
        expect(getIt.isRegistered<HttpService>(), isTrue);
        expect(getIt.isRegistered<HomeCacheDatabase>(), isTrue);
        expect(getIt.isRegistered<HomeLocalDataSourceImpl>(), isTrue);
        expect(getIt.isRegistered<HomeRemoteDataSourceImpl>(), isTrue);
        expect(getIt.isRegistered<HomeRepository>(), isTrue);
        expect(getIt.isRegistered<GetEpisodeCharactersUseCase>(), isTrue);
        expect(getIt.isRegistered<HomeCubit>(), isTrue);
      },
    );

    test('HomeCubit é registrado como factory', () async {
      await setupDependencies();

      final first = getIt<HomeCubit>();
      final second = getIt<HomeCubit>();

      expect(first, isNot(same(second)));
      await first.close();
      await second.close();
    });
  });

  group('appRouter', () {
    tearDown(() async {
      await getIt.reset();
    });

    testWidgets('renderiza rota inicial com HomeCubit disponível', (
      tester,
    ) async {
      await setupDependencies();

      await tester.pumpWidget(MaterialApp.router(routerConfig: appRouter));
      await tester.pumpAndSettle();

      expect(find.text('The Chaos Archive'), findsOneWidget);
      expect(find.text('Buscar por episódio'), findsOneWidget);
    });
  });
}
