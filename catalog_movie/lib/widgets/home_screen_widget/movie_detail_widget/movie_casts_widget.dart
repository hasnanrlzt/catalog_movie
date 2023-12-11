import 'package:catalog_movie/bloc/movie_casts_bloc/movie_casts_cubit.dart';
import 'package:catalog_movie/bloc/theme_bloc/theme_controller.dart';
import 'package:catalog_movie/repositories/movie_repository.dart';
import 'package:catalog_movie/widgets/home_screen_widget/movie_detail_widget/cast_list_horizontal.dart';
import 'package:catalog_movie/widgets/home_screen_widgets/movie_widgets_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class MovieCasts extends StatelessWidget {
  const MovieCasts(
      {Key? key,
      required this.movieId,
      required this.themeController,
      required this.movieRepository})
      : super(key: key);
  final ThemeController themeController;
  final MovieRepository movieRepository;
  final int movieId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => MovieCastsCubit(
          repository: context.read<MovieRepository>(),
        )..fetchCasts(movieId),
        child:  CastsView(
          movieId: movieId,
          movieRepository: movieRepository,
          themeController: themeController,
        ),
      );
  }
}

class CastsView extends StatelessWidget {
  const CastsView(
      {Key? key,
      required this.movieId,
      required this.themeController,
      required this.movieRepository})
      : super(key: key);
  final ThemeController themeController;
  final MovieRepository movieRepository;
  final int movieId;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<MovieCastsCubit>().state;

    switch (state.status) {
      case ListStatus.failure:
        return const Center(
            child: Text(
          'Oops something went wrong!',
          style: TextStyle(color: Colors.white),
        ));
      case ListStatus.success:
        return CastsListHorizontal(
          casts: state.casts,
          movieRepository: movieRepository,
          themeController: themeController,
        );
      default:
        return buildMovielistLoaderWidget(context);
    }
  }
}