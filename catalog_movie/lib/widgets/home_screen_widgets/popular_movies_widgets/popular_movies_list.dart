import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:catalog_movie/bloc/popular_movies_bloc/popular_movies_cubit.dart';
import 'package:catalog_movie/bloc/theme_bloc/theme_controller.dart';
import 'package:catalog_movie/repositories/movie_repository.dart';

import '../movie_widgets_loader.dart';
import '../movies_list_horizontal.dart';

class PopularMoviesList extends StatelessWidget {
  const PopularMoviesList(
      {Key? key, required this.themeController, required this.movieRepository})
      : super(key: key);
  final ThemeController themeController;
  final MovieRepository movieRepository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PopularMovieCubit(
        repository: context.read<MovieRepository>(),
      )..fetchList(),
      child: PopularMovieView(
        themeController: themeController,
        movieRepository: movieRepository,
      ),
    );
  }
}

class PopularMovieView extends StatelessWidget {
  const PopularMovieView(
      {Key? key, required this.themeController, required this.movieRepository})
      : super(key: key);
  final ThemeController themeController;
  final MovieRepository movieRepository;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<PopularMovieCubit>().state;
    switch (state.status) {
      case ListStatus.failure:
        return const Center(child: Text('Oops something went wrong!'));
      case ListStatus.success:
        if (state.movies.isEmpty) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      "No More Popular Movies",
                      style: TextStyle(color: Colors.black45),
                    )
                  ],
                )
              ],
            ),
          );
        } else {
          return MoviesListHorizontal(
            movies: state.movies,
            movieRepository: movieRepository,
            themeController: themeController,
          );
        }
      default:
        return buildMovielistLoaderWidget(context);
    }
  }
}
