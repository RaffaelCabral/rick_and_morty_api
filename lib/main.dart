import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_api/src/modules/core/http_service/dio_service.dart';
import 'package:rick_and_morty_api/src/modules/core/theme/app_theme.dart';
import 'package:rick_and_morty_api/src/modules/home/data/datasource/home_datasource.dart';
import 'package:rick_and_morty_api/src/modules/home/data/repository/home_repository.dart';
import 'package:rick_and_morty_api/src/modules/home/domain/usecase/get_episode_characters_usecase.dart';
import 'package:rick_and_morty_api/src/modules/home/presentation/view/home_page.dart';
import 'package:rick_and_morty_api/src/modules/home/presentation/viewmodel/home_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  final http = HttpService();
  final datasource = HomeRemoteDatasourceImpl(http);
  final repository = HomeRepositoryImpl(datasource);
  final getEpisodeCharacters = GetEpisodeCharactersUseCase(repository);

  runApp(
    BlocProvider(
      create: (_) => HomeCubit(getEpisodeCharacters: getEpisodeCharacters),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rick and Morty',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      home: const HomePage(),
    );
  }
}
