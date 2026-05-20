import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:rick_and_morty_api/src/modules/core/connectivity/connectivity_service.dart';
import 'package:rick_and_morty_api/src/modules/core/http_service/dio_service.dart';
import 'package:rick_and_morty_api/src/modules/home/data/datasource/home_local_datasource_impl.dart';
import 'package:rick_and_morty_api/src/modules/home/data/datasource/home_remote_datasource_impl.dart';
import 'package:rick_and_morty_api/src/modules/home/data/local/home_cache_database.dart';
import 'package:rick_and_morty_api/src/modules/home/data/repository/home_repository.dart';
import 'package:rick_and_morty_api/src/modules/home/domain/usecase/get_episode_characters_usecase.dart';
import 'package:rick_and_morty_api/src/modules/home/presentation/viewmodel/home_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  if (getIt.isRegistered<HttpService>()) return;

  getIt
    ..registerLazySingleton<Connectivity>(Connectivity.new)
    ..registerLazySingleton<ConnectivityService>(
      () => ConnectivityServiceImpl(getIt<Connectivity>()),
    )
    ..registerLazySingleton<HttpService>(HttpService.new)
    ..registerLazySingleton<HomeCacheDatabase>(
      HomeCacheDatabase.new,
      dispose: (database) => database.close(),
    )
    ..registerLazySingleton<HomeLocalDataSourceImpl>(
      () => HomeLocalDataSourceImpl(getIt<HomeCacheDatabase>()),
    )
    ..registerLazySingleton<HomeRemoteDataSourceImpl>(
      () => HomeRemoteDataSourceImpl(getIt<HttpService>()),
    )
    ..registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(
        getIt<HomeRemoteDataSourceImpl>(),
        getIt<HomeLocalDataSourceImpl>(),
        getIt<ConnectivityService>(),
      ),
    )
    ..registerLazySingleton<GetEpisodeCharactersUseCase>(
      () => GetEpisodeCharactersUseCase(getIt<HomeRepository>()),
    )
    ..registerFactory<HomeCubit>(
      () =>
          HomeCubit(getEpisodeCharacters: getIt<GetEpisodeCharactersUseCase>()),
    );
}
