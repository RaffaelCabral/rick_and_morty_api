import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_and_morty_api/src/modules/core/di/service_locator.dart';
import 'package:rick_and_morty_api/src/modules/home/presentation/view/home_page.dart';
import 'package:rick_and_morty_api/src/modules/home/presentation/viewmodel/home_cubit.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return BlocProvider(
          create: (_) => getIt<HomeCubit>(),
          child: const HomePage(),
        );
      },
    ),
  ],
);
